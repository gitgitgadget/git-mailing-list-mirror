From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 23:22:56 +0200
Message-ID: <005201cd80ac$4cd414b0$e67c3e10$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org> <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> <7vy5l9lj6m.fsf@alter.siamese.dyndns.org> <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de> <7v4nnxld24.fsf@alter.siamese.dyndns.org> <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de> <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com> <503519B3.1020403@kdbg.org> <CA+sFfMedWVAgqvHS67V6L=ROjdN6M3p3pYTUDk98xgozX4djEw@mail.gmail.com> <CA+sFfMdL=h=aoX7mCWfXJ+QvDLH7gvzWWo9HMX
 KSaTv+ykx-8w@mail.gmail.com> <004401cd80a3$4b0cff60$e126fe20$@schmitz-digital.de> <7v628a7iu5.fsf@alter.siamese.dyndns.org> <004501cd80a9$d01ecc00$705c6400$@schmitz-digital.de> <7vobm2637y.fsf@alter.siamese.dyndn
	s.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:23:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4IOO-0000fd-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 23:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab2HVVXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 17:23:06 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:57696 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2HVVXF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 17:23:05 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MalwI-1TOZMj0gyQ-00KQgE; Wed, 22 Aug 2012 23:23:03 +0200
In-Reply-To: <7vobm2637y.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDMCb+a+7QMjYLRhAalBYtECWH7b+QJMED4YAf2RaVICtbjc6wG8pDJ9AqeuHsoBWWDgawHAthMNAapj6DYA+qUF2JT2U0lA
Content-Language: de
X-Provags-ID: V02:K0:na3E8Z4r6x38PiVLv2pRTv4UdWoH6GMCrjAlH/qTAVO
 8uYvmBPYC4G4wZJzqSkdn6QFqd0VvCiSreZsxvL8XMYastAJBf
 NUM0ytbbReXzthzGeEP8v+24LRGwgihvEwXWaAvLKgoLl+MVoR
 C2ODicV0WpcXYH3Kq+nAj3GONEsLKvtwXcvKrW8RBhda6EO8nh
 WchRX5JOTYL6D7c+l/kd0VLOZCyR43uOXGwpaVMZQ/2ImyYJCp
 n/JXgw0UQ4U+1mLjZaGiWdKv11fD2B8+AdMpFDQFw38uLfUs+I
 XFtP/PhtEnjgMtZMHOWugWUDtfrc8TXcYwbnZny5TkIU5P77u4
 r9msTwrn/0CXltPsjxbxlmcRXNVT25OFVcNpyFSWqwSrsBJyg3
 f0uHYDOKxesqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204100>



> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, August 22, 2012 11:12 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> If it helps your port, compat/itimer.c sounds like a good place.
> >> Doesn't it need a new header file to introduce structures and
> >> constants,
> > too?
> >
> > You mean the ITIMER_* and struct itimerval, right?
> > On NonStop these are available in <sys/time.h>, so here's no need to
> > add them.
> 
> At least you would need a header to declare these two functions and make
> them visible so that the remainder of the codebase will not have to know
about
> git_setitimer(), no?  Or does your header files on NonStop declare
setitimer()
> but does not implement it?

No it doesn't, at least not if a form visible to a compiler...

> As your proposed name is not compat/tandem.c but more generic sounding
> compat/itimer.c, we would have to plan for systems other than NonStop, so
we
> may later have to introduce makefile variables to ask that header file to
> declare the structure and define the constants that are missing from such
a
> system.  While you are porting to NonStop, you may not have to
define/declare
> them, but knowing that these files are the place to later do so is part of
the
> planning.

I thought of having the function decclaration in git-compat-util.h, just
like for eg. setenv, gitmkdtemp, etc.

Bye, Jojo
