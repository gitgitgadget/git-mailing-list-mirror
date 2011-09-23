From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 23 Sep 2011 10:35:20 +0200
Message-ID: <4E7C44C8.10000@alum.mit.edu>
References: <4E7A3BDE.3040301@alum.mit.edu> <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4E7AF1AE.5030005@alum.mit.edu> <7vwrd0xzdc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 10:35:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R71ES-0003le-N3
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 10:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab1IWIfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 04:35:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:57820 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab1IWIfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 04:35:31 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8N8ZKBS018921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 23 Sep 2011 10:35:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <7vwrd0xzdc.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181950>

On 09/22/2011 07:26 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I would like the checking configuration to be *versioned* along with the
>> code.  For example, suppose my project decides to enforce a rule that
>> all Python code needs to be indented with spaces.  It might be that not
>> all of our old code adheres to this rule, and that we only want to clean
>> up the code in master.
> 
> You want to sneak in a badly formatted code? Add an entry to the in-tree
> attributes file to disable whitespace checking to cover that file!

No, the scenario that I was trying to describe is a project that wants
to tighten up its code formatting rules after years of laxity.  It is
convenient to support legacy branches that still contain nonconforming
code without having to reformat it all, just as it is convenient to fix
the current code incrementally rather than requiring all of the cleanup
to be done in one big bang.  Thus it is important that new rules not be
enforced retroactively on old code.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
