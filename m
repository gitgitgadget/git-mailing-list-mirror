From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] daemon: restore getpeername(0,...) use
Date: Sat, 8 Sep 2012 21:20:11 +0200
Message-ID: <002101cd8df6$f7cab2a0$e76017e0$@schmitz-digital.de>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de> <1347124173-14460-2-git-send-email-jengelh@inai.de> <k2g0up$28h$1@ger.gmane.org> <7vwr04tjzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 21:20:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAQa7-0001PO-9I
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 21:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab2IHTUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 15:20:32 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:59551 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab2IHTUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 15:20:31 -0400
Received: from DualCore (dsdf-4db5dae6.pool.mediaWays.net [77.181.218.230])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LnG25-1TmUcC2nev-00hH9f; Sat, 08 Sep 2012 21:20:21 +0200
In-Reply-To: <7vwr04tjzo.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKQODjfGir0QdY292QjkJfxRd4QjQGLm4FOAtJ5aowBOL55HJXOxjJg
Content-Language: de
X-Provags-ID: V02:K0:+LsSzK7moa0fvyqqnA+kxSh4Wagn50uHT8aqFTpb0Gl
 mryi7fgyrg0MWzkIzXDI+dBiHnkOJQmibfNgPkG+yPv7Atbt37
 oEZXhCsJr61wphcuIwbQ5H1Eh7NZdEZz0cLcFsN5t3Vs3JIoPA
 ZJKEZymCLwiq9VFKiBjYm7XafwiBpe6O3YdQJq8g+kgJuQfWaL
 VRHUh4W9i3+1XtB9hBJiE9fjIY8L6OV2bfhuDjlFmPibIVsfOZ
 mjrjd2fD41V5L3u+Zh4mqzpaf/La713tyaxscMj/qX7op1YX6S
 uVYXQdvU/vsIHv9JzQicmYS5MC9FXwXFbGAWGrYcVvZhswa0TG
 VQAxJFUfw6RrA7y5hzvN/e04/VSUzsVXJpi98+rhi2HfneN38o
 s2D5KOBCWF2cQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205030>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Saturday, September 08, 2012 9:04 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> + setenv("REMOTE_PORT", portbuf, true);
> >
> > setenv() is not a function available on all plattfomrs.
> 
> Please do some homework before adding irrelevant noise.  At the
> minimum, run "git grep" to see if we already use it in other places,
> and investigate why we can use it safely across platforms we already
> support.

Hmm, guess I missed the indirect inclusion of git-compat-util.h
And didn't know about 'git grep', so thanks for the hint

Will look closer next time ;-)
