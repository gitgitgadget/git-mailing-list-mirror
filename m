From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Jan 2012, #05; Mon, 23)
Date: Tue, 24 Jan 2012 09:35:05 +0100
Message-ID: <4F1E6D39.1080506@alum.mit.edu>
References: <7vmx9d6hpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 09:35:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpbqX-0002K3-8A
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 09:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab2AXIfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 03:35:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46619 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab2AXIfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 03:35:10 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0O8Z52M014913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Jan 2012 09:35:07 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7vmx9d6hpw.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189042>

On 01/24/2012 01:56 AM, Junio C Hamano wrote:
> Here are the topics that have been cooking. [...]
> * mh/ref-api-rest (2011-12-12) 35 commits
>  . [...]
> 
> I had to remove this temporarily out of 'pu' as I didn't want to deal with
> merge conflicts with the mh/ref-clone-without-extra-refs topic that
> removes yet another caller of add_extra_ref() that this series touches.

Yes, I agree; the branch can be put on ice.  After I find the time to
remove the last user of extra_refs, I plan to rework the branch with no
support for extra_refs at all.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
