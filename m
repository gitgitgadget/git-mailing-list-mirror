From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] sh-setup: explicitly mark CR as a field
 separator
Date: Tue, 27 Oct 2015 10:19:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510270950230.31610@s15462909.onlinehome-server.info>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <cover.1445782122.git.johannes.schindelin@gmx.de> <2b089201404299257f23b3931499ea16202f0f65.1445782122.git.johannes.schindelin@gmx.de> <vpqlhaqas8g.fsf@grenoble-inp.fr>
 <xmqq8u6piir8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 10:19:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr0Q8-0003Ri-Py
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 10:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbbJ0JTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 05:19:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:62732 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbbJ0JTt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 05:19:49 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LZiQy-1aEHws2wii-00lSN9;
 Tue, 27 Oct 2015 10:19:22 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq8u6piir8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Ep7CRIxOdPMEA7EozbhE9aKnEfW17PlqJWEpE0//gOdcmM4umb1
 h+Ne5wXgZjp+6YDoS7vYG2Tm6D2afsb9Phl39QZpSFy1mroCLLO9kBLl8uQBtLltvYx0k0d
 Sx1mwJj0qnAhUh8/COk0FfEUzqQVNFI8HJS5gEXZvyQuqa8vl6uO2MH41SyHneALzrRO6cS
 H3YGNtBOSB7ceOMKCLqjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NrdjxKDSqf8=:GLfKufvI7+/qvcLF5WntwY
 H+72Ow/8JJBqx3zHDRCFSq5Ltsv0jMg9Vz6Ebp/aiiXkd7+ZmW2EGmWE9grxJCD1WABmPlr/l
 lh9dZ0ChR+x496ZFv/oMBIJ6XD+EkS+bnuqqkIm5URFVaIeyqP5Q7Wldotg3R0LbOqnwdrB0h
 LKk8SWoOs2penLhrU8hQUiLa5JhcbW0Iz6ivowWV7/P6vPQYqE/SuRuHAAXjbvo8V4rZUeFyb
 zvFFeq5DRzw+sD5jaIlGOUXKIVY/+zcWwbfKWXeFlydGtGM9M42shSzWL84eAKK+pPwOlWVLQ
 Me4nsHsKq1SxNNUzWx1FQtDpdgsRdQird0b5cHDSzjYn8LHoKNFL2rLRsEHMSLN1VKfV0JH4O
 HDned//FJ2GeSqLXCFpBxB5UVoYAqW6u8PrKiHW9dJ/+oXD2dmktyr0GWhZtxYdbbwMtd2yqt
 z0JUseP7QSjMWersxTsn8aQRTbCcNQwxew0w3ONCpXbBrmivaHJUcq1kTcN+lSsDwxishEAkn
 ZoNWEN9iKW/SqxIobVWDGWQ7T9RTCcFokdEG4Uq3PQTTqqa1wVCPlOE0JqHXcWeLePiuQi4wu
 +vS2atYu6lb3Yz3vfr9zDFuyPc9eKdzsY+gFJsXkwu+0i+Oi/ufg8chStjVwr4ovX4Orbia1O
 Ne9HGniYluPTiK0xXk7QQB8V6c+pvaxwRgMo3U8lH8JjoY76E3NwqX1NgJgtQvODq0iqQLmd6
 0Vedg2qFjTVmU9n+UA0E5nJlGXyZ+OarAoq5V2zjT2gzRgfo9FJYA17P7XLUA67XR0DaLgkG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280249>

Hi Junio,

On Mon, 26 Oct 2015, Junio C Hamano wrote:

> I asked Dscho if the shell is done correctly _for_ the platform.

This assumes that the platform is either CR/LF or LF. That is incorrect.
Windows does *not* dictate the line endings to be CR/LF. Certain
applications do.

The shell is an MSys2 shell, and MSys2 convention is to use LF. Hence the
shell is done correctly for the platform.

Yet on Windows (and in cross-platform projects also on Linux and MacOSX),
you have to deal with the fact that text files produced outside the cozy
little shell can have different line endings.

As I said, I am uninterested in arguing for arguing's sake. Otherwise I
would shoot down your argument that LF in IFS "does not hurt" but CR
somehow magically does. I am sure it would be a helluva discussion and
fun. But I do not have the time.

What I really needed you to do indicate the way forward.

The patch you provided in the mail I am replying to fails to fix the bug.

Ciao,
Johannes
