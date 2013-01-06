From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 6 Jan 2013 16:46:17 -0500
Organization: PD Inc
Message-ID: <BFCB094090C6444F8C951211FF795561@black>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de> <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de> <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com> <20130106120917.GC22081@elie.Belkin> <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9E822.4020709@gmail.com> <7vtxqum1u9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Try3B-0002FE-3m
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 22:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab3AFVqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 16:46:18 -0500
Received: from projects.pdinc.us ([67.90.184.26]:53603 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753018Ab3AFVqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 16:46:17 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r06Ljuo5029148
	for <git@vger.kernel.org>; Sun, 6 Jan 2013 16:45:56 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <7vtxqum1u9.fsf@alter.siamese.dyndns.org>
Thread-Index: Ac3sVccUi6J5wzEqRzCy3Q49BBFlEQAASP6g
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212847>

> -----Original Message-----
> From: Junio C Hamano
> Sent: Sunday, January 06, 2013 16:36
> 
> Thanks; so perhaps you can give me an OK to forge your S-o-b 
> to the following?

I am personally fine with it, because cygwin is used by developers not
production systems and I expect my developers to upgrade their environment for
security fixes, etc.
If I ever had a situation where I am using git, in production, on cygwin, where
I could not upgrade I would effort to make a compile test based patch to the
make file to accommodate the issue.

> 
> -- >8 --
> From: Mark Levedahl <mlevedahl@gmail.com>
> Date: Sun, 6 Jan 2013 11:56:33 -0800
> Subject: [PATCH] Makefile: add comment on CYGWIN_V15_WIN32API
> 
> There is no documented, reliable, and future-proof method to 
> determine the installed w32api version on Cygwin. There are 
> many things that can be done that will work frequently, 
> except when they won't.
> 
> The only sane thing is to follow the guidance of the Cygwin
> developers: the only supported configuration is that which 
> the current setup.exe produces, and in the case of problems, 
> if the installation is not up to date then updating is the 
> first required action.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 4d47af5..52e298a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -273,6 +273,10 @@ all::
>  #
>  # Define NO_REGEX if you have no or inferior regex support 
> in your C library.
>  #
> +# Define CYGWIN_V15_WIN32API if you are using Cygwin v1.7.x 
> but are not 
> +# using the current w32api packages. The recommended 
> approach, however, 
> +# is to update your installation if compilation errors occur.
> +#
>  # Define HAVE_DEV_TTY if your system can open /dev/tty to 
> interact with the  # user.
>  #
> --
> 1.8.1.302.g0f4eaa7

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
