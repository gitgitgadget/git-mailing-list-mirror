From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 12/12] is_refname_available(): reimplement using do_for_each_ref_in_array()
Date: Mon, 24 Oct 2011 13:58:46 +0200
Message-ID: <4EA552F6.4010005@alum.mit.edu>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu> <1319060692-27216-13-git-send-email-mhagger@alum.mit.edu> <7v4nz4bftk.fsf@alter.siamese.dyndns.org> <4E9FD1C3.3090302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 13:59:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIJBR-0002oe-8V
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 13:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756Ab1JXL7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 07:59:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40225 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717Ab1JXL7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 07:59:06 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9OBwllN025373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 24 Oct 2011 13:58:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <4E9FD1C3.3090302@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184172>

On 10/20/2011 09:46 AM, Michael Haggerty wrote:
> On 10/20/2011 03:40 AM, Junio C Hamano wrote:
>> Hmm, why is this patch and only this one in the series full of whitespace
>> violations? Did you use a different settings or something?
> 
> This happens rarely; I don't know why.  Maybe I copy-pasted snippets
> from a view in an application that expanded the tabs.  [...]

Now I think I know how this happened.  When "git diff"'s output goes to
a TTY, it passes its output through the pager.  The default pager, less,
seems to convert tabs into spaces.  I probably copy-pasted some output
of diff into my editor then removed the first column of '+' characters.

Just another reason why tabs are evil...

:-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
