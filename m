From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [RFR] gitattributes(5) documentation
Date: Sat, 21 Apr 2007 17:51:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704211749300.5655@qynat.qvtvafvgr.pbz>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net><7vr6qlxexe.fsf@assigne
 d-by-dhcp.cox.net><7v647tcjr6.fsf@assigned-by-dhcp.cox.net><7vslav4yv6.fsf_
 -_@assigned-by-dhcp.cox.net><alpine.LFD.0.98.0704191835290.9964@woody.linux
 -foundation.org> <7virbr4p0v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 03:25:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfQpQ-0003me-Ng
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 03:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbXDVBZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 21:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753955AbXDVBZV
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 21:25:21 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:41867 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753940AbXDVBZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 21:25:20 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sat, 21 Apr 2007 18:25:19 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sat, 21 Apr 2007 18:25:14 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7virbr4p0v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45205>

On Thu, 19 Apr 2007, Junio C Hamano wrote:

> Set to string value "input"::
>
> 	This is similar to setting the attribute to `true`, but
> 	also forces git to act as if `core.autocrlf` is set to
> 	`input` for the path.
>
> Any other value set to `crlf` attribute is ignored and git acts
> as if the attribute is left unspecified.

I think that a better option would be that if it's set to a string value, that 
string value is treated as if core.autocrlf was set to that value.

in the long run this would let you phase out the core.autocrlf option entirely, 
letting the bahavior be specified in gitattributes.

David Lang
