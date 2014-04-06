From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: Makefile: Another "make" command is used when going into SUBDIR
 perl
Date: Sun, 06 Apr 2014 16:33:17 +0200
Message-ID: <534165AD.3040606@web.de>
References: <20140405231039.GA26578@rhi.hi.is>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 16:34:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWo9G-0005im-Ih
	for gcvg-git-2@plane.gmane.org; Sun, 06 Apr 2014 16:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbaDFOeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2014 10:34:10 -0400
Received: from mout.web.de ([212.227.17.12]:55383 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621AbaDFOeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2014 10:34:08 -0400
Received: from [192.168.178.27] ([79.253.155.66]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M1oGM-1WrEdq17Zy-00tnLx; Sun, 06 Apr 2014 16:34:04
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20140405231039.GA26578@rhi.hi.is>
X-Provags-ID: V03:K0:c8a5HCfy0FtwfN8l7O3e42R+HCqEfXwcLrs1PULfpgUcLpxXn65
 uzrXZw+bOK14hK8xyRoDNw2Ej2UmhkUA7WElAvejW2YR38W08CfZ2rP7ISBZIh1AjXrmB5W
 xWPGweLO+hwgYmhoNAULkS1tBATLgIC4RdAumAmnKwuLtgJ2tlWjGnljBbXcRqIbOVRV62Y
 MSoxH8OwQNxsTwrX2YA6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245788>

Am 06.04.2014 01:10, schrieb Bjarni Ingi Gislason:
> Package: git-1.9.0
>
>    Another make command is used in the Makefile when it enters subdir
> PERL.
>
>    The used "make" command is a link in my home directory to
> "/usr/sfw/bin/gmake".  Other make commands are "/usr/ccs/bin/make" an=
d
> "/usr/xpg4/bin/make".
>
> My PATH variable has these directories in this order
>
> $HOME, /usr/sfw/bin, /usr/xpg4/bin and /usr/ccs/bin
>
>    The used variables for make are
>
> CPPFLAGS=3D-I/usr/local/ssl/include
> NO_GETTEXT=3DYesPlease
> NO_TCLTK=3DYesPlease

Try adding "MAKE =3D /usr/sfw/bin/gmake".

Ren=E9
