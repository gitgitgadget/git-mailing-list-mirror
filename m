From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 21:24:11 +1000
Message-ID: <SNT124-W631EA986B78300D93BF669C4740@phx.gbl>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>,<SNT124-W39164C74A457129811245DC4740@phx.gbl>,<BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>,<SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: <elazarl@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 13:24:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPCCQ-0005V4-0D
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 13:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab1EYLYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 07:24:14 -0400
Received: from snt0-omc4-s25.snt0.hotmail.com ([65.55.90.228]:57309 "EHLO
	snt0-omc4-s25.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755767Ab1EYLYN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 07:24:13 -0400
Received: from SNT124-W63 ([65.55.90.201]) by snt0-omc4-s25.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 25 May 2011 04:24:12 -0700
X-Originating-IP: [114.77.220.50]
Importance: Normal
In-Reply-To: <SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
X-OriginalArrivalTime: 25 May 2011 11:24:12.0699 (UTC) FILETIME=[46017EB0:01CC1ACE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174384>


> From: timmazid@hotmail.com
> > From: elazarl@gmail.com
> > Oops, let me be 100% clear about that, "git log -v
> > --grep=3D=3D> presented a possible syntax.
> >
> > $ git --version
> > git version 1.7.4.msysgit.0
> > $ git log -v --grep=3DNormalized
> > commit 88c7a82aaf240ed130c64c455c294e7af04d30f8
> > Author: Elazar
> > Date: Mon May 16 10:40:21 2011 +0300
> >
> > Normalized Makfile so that it'll work by default. Include Makefile
> >
> > see, it ignores the "-v", and include only commits with "Normalized=
" -
> > the ones I don't want to see.
>
> Ah, I see; my apologies.
>
> Well, personally, I've never used the --grep option. I pipe it throug=
h
> grep, where I can supply options such as -v. However, if the --grep
> option already exists, then it does make sense to allow users to use
> options they would normally be able to with grep.
>
> As for the syntax, that seems like a good idea on the surface, but
> how would you go about supporting other grep options? Such as
> "-i"?

Woops; my bad; "-i" is already supported. But the point still stands...
I think?

Should there be a seperate "--grep-options" option for "git log" to
pass options onto grep?

 Tim.

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org=A0=A0=A0 - against proprietary attachments
 		 	   		  