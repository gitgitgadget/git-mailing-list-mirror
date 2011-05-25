From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 21:05:49 +1000
Message-ID: <SNT124-W39164C74A457129811245DC4740@phx.gbl>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <elazarl@gmail.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 13:06:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPBue-00075d-Kk
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 13:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab1EYLFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 07:05:52 -0400
Received: from snt0-omc4-s16.snt0.hotmail.com ([65.55.90.219]:22118 "EHLO
	snt0-omc4-s16.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751336Ab1EYLFw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 07:05:52 -0400
Received: from SNT124-W39 ([65.55.90.200]) by snt0-omc4-s16.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 25 May 2011 04:05:50 -0700
X-Originating-IP: [114.77.220.50]
Importance: Normal
In-Reply-To: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
X-OriginalArrivalTime: 25 May 2011 11:05:50.0954 (UTC) FILETIME=[B5508CA0:01CC1ACB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174381>


> Date: Wed, 25 May 2011 12:40:48 +0300
> From: elazarl@gmail.com
>
> I want to use git log to show all commits that do not match a given
> pattern. I know I can use the following to show all commits that do
> match a pattern, similar to the "grep -v" command line option:
>
> git log -v --grep= # results all commits that do NOT match pattern
>
> Is there a way invert the sense of matching?
>
> If not, is it OK to submit a patch? Anything to consider for this patch?

I'm confused; do you want to find all the commits that do not match a
pattern? Because you seem to have achieved that. If, on the other hand,
you want the commits that DO match a pattern, then just leave out the
"-v" option.

What exactly are you trying to achieve?


Tim.

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
 		 	   		  