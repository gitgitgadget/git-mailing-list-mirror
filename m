From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 23:05:08 +0200
Message-ID: <004501cd80a9$d01ecc00$705c6400$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org> <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> <7vy5l9lj6m.fsf@alter.siamese.dyndns.org> <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de> <7v4nnxld24.fsf@alter.siamese.dyndns.org> <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de> <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com> <503519B3.1020403@kdbg.org> <CA+sFfMedWVAgqvHS67V6L=ROjdN6M3p3pYTUDk98xgozX4djEw@mail.gmail.com> <7vtxvu7p5s.fsf@alter.siamese.dyndns.org
 > <CA+sFfMdL=h=aoX7mCWfXJ+QvDLH7gvzWWo9HMXKSaTv+ykx-8w@mail.gmail.com> <004401cd80a3$4b0cff60$e126fe20$@schmitz-digital.de> <7v628a7iu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:05:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4I7C-0000Ym-Su
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 23:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933358Ab2HVVFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 17:05:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:63552 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933330Ab2HVVFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 17:05:18 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MUVcJ-1TDKgb3T8N-00RLZa; Wed, 22 Aug 2012 23:05:15 +0200
In-Reply-To: <7v628a7iu5.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDMCb+a+7QMjYLRhAalBYtECWH7b+QJMED4YAf2RaVICtbjc6wG8pDJ9AtdvFzACp64eygFZYOBrAcC2Ew2U9LnKkA==
Content-Language: de
X-Provags-ID: V02:K0:xea6o/hLFFT6ScuONOzpSFuR4mnfZ3xVq+H4yr39rZx
 1JkV5t1nPkCTGhXb8lO+uQ8CKUV2/36SfMN9wS72DBYc12DS6R
 kZGUMvK0FDWtf8hkVu9k1EshBB5JDCNosH5j2EwSIRXtVpAUCN
 akYJwZ/oEVdgWpsfAwYVf5+V22lc3tjslJ9RxRTcReYeiI5WxS
 8pvdyLFIuVG56zu7f7J3LBSwEYXM6QEf5jZX6ZwAgePTJ3Jp3S
 MzCIqrbW4Lek+GhkRrxrIa23fYC1Vof8C2/6I+qZ+mhkUavkGp
 TG8QokIpnOul/DwCA8jw25VHxqEjVsg44tJ/cWRFHMwd/hs80v
 EOoorxYKA1M6xZDPB9kD6lPLHVIV/ImW1hZ+q6ATghw+XjAzk4
 7xQhTiyiRCHJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204096>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, August 22, 2012 10:50 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Hi folks
> >
> > There another API missing on HP NonStop and that is setitimer(), used
> > in progress.c and build/log.c I do have a homebrewed implementation, on
top
> of alarm(), it goes like this:
> >
> > #include "../git-compat-util.h"
> > #undef getitimer
> > #undef setitimer
> >
> >
> > int
> > git_getitimer(int which, struct itimerval *value)
> 
> See Documentation/CodingGuidelines for style nits.

Will do and adjust code accordingly. Here I was more concerned about content
though ;-)

...
> > Worth being added to compat/, e.g. as setitimer.c, or, as itimer.c (as
> > a by-product, it has getitimer() too)?
> 
> If it helps your port, compat/itimer.c sounds like a good place.
> Doesn't it need a new header file to introduce structures and constants,
too?

You mean the ITIMER_* and struct itimerval, right?
On NonStop these are available in <sys/time.h>, so here's no need to add
them.

Bye, Jojo
