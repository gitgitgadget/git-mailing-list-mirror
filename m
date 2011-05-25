From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 21:35:12 +1000
Message-ID: <SNT124-W15FA6D1CACA43B253810FAC4740@phx.gbl>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>,<SNT124-W39164C74A457129811245DC4740@phx.gbl>,<BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>,<SNT124-W5207D5461CD80509763B79C4740@phx.gbl>,<BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: <elazarl@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 13:35:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPCMz-0005xy-HE
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 13:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737Ab1EYLfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 07:35:14 -0400
Received: from snt0-omc4-s3.snt0.hotmail.com ([65.55.90.206]:26020 "EHLO
	snt0-omc4-s3.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752048Ab1EYLfN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 07:35:13 -0400
Received: from SNT124-W15 ([65.55.90.199]) by snt0-omc4-s3.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 25 May 2011 04:35:12 -0700
X-Originating-IP: [114.77.220.50]
Importance: Normal
In-Reply-To: <BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
X-OriginalArrivalTime: 25 May 2011 11:35:12.0777 (UTC) FILETIME=[CF716790:01CC1ACF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174386>


> Date: Wed, 25 May 2011 14:28:12 +0300
> From: elazarl@gmail.com
> On Wed, May 25, 2011 at 2:21 PM, Tim Mazid  wrote:
> >
> > Well, personally, I've never used the --grep option. I pipe it through
> > grep, where I can supply options such as -v.
>
> But then you must use single-line commits output. Which is
> inconvenient if you want to read all the commit message.

That is a good point.


> > As for the syntax, that seems like a good idea on the surface, but
> > how would you go about supporting other grep options? Such as
> > "-i"?
>
> Now that I think of it, we already have the '--not' option for
> revision specifiers. Why won't we use it for grep patterns? That way
> -v will not be overloaded (it usually means verbose). For example
>
> git log --all --not --grep A --grep B
>
> Would mean find all commits without A and with B, in SQL "SELECT *
> FROM COMMITS WHERE message NOT LIKE '%A%' AND message LIKE '%B%'".

But how do you know which "--grep" the "--not" applies to? Does it have 
to go directly before the "--grep" option? Can it be a few options before
as long is it's still before? If you want to find commits not matching two
patterns, do you have to do "--not --grep A --not --grep B"?

I can see this as being a possible source of confusion; people doing
"--not grep A --grep B" and expecting it to mean NOT A AND NOT B.


Tim.

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
 		 	   		  