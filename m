From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 19:30:42 +0200
Message-ID: <003101cd808b$db381e70$91a85b50$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>	<CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>	<004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>	<CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>	<01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>	<7v628epzia.fsf@alter.siamese.dyndns.org>	<000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>	<7vy5l9lj6m.fsf@alter.siamese.dyndns.org>	<001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>	<7v4nnxld24.fsf@alter.siamese.dyndns.org>	<002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>	<CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>	<002f01cd808a$2e027e90$8a077bb0$@schmitz-digital.de> <CA+sFfMd5zzfZVrGJSMkr2ga8kTg6Tiun=HBdHkg6rV-stjDT8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "'Brandon Casey'" <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:31:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Ely-0003gu-07
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933196Ab2HVRbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:31:12 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:55041 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930Ab2HVRbL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 13:31:11 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MC7ge-1SvTL60KaO-009Niv; Wed, 22 Aug 2012 19:30:48 +0200
In-Reply-To: <CA+sFfMd5zzfZVrGJSMkr2ga8kTg6Tiun=HBdHkg6rV-stjDT8Q@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDMCb+a+7QMjYLRhAalBYtECWH7b+QJMED4YAf2RaVIB/2GPoAIbSAlPlTwG+DA=
Content-Language: de
X-Provags-ID: V02:K0:+u0vdmroiKih8byegaZtDBvZDQK1gvg+Ec32YJnmBGx
 wjmUP0PlB3tUPD34e1L0hbbQvhBmfsPIPDQmgPiZzJyktF0e6f
 odLvI9g8Y98hwOk8VTteQKP0QCizKxD/T3tLB+uX9d16kRtWt9
 R1SL9dFyE+wMCONkHFu3gkDJnnOFBqQTtFYsfKUg/ldIVvaF36
 jsi1TgzxvHOGBJpXGGGxbUyb7MHBJfv3BTnUUnnq+2Nu8Gr0pE
 yWSdsEHl0eCfOZTUyxWciN1+sLjEuCGwkMi0/Wi7te52wj8l9w
 eFbhBlhf0xe+QGNkk8EWjZq9XaJSNeGvbXPpey5i/oVLCyVA6l
 OUsaV2zwGxtt/0Tg3TxGhHHBH2ucye9zGnyZ1SytQ7kri4HTQP
 7yOmUNLDadFSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204042>

> From: Brandon Casey [mailto:drafnel@gmail.com]
> Sent: Wednesday, August 22, 2012 7:23 PM
> To: Joachim Schmitz
> Cc: Junio C Hamano; Shawn Pearce; git@vger.kernel.org;
> rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> On Wed, Aug 22, 2012 at 10:18 AM, Joachim Schmitz <jojo@schmitz-digital.de>
> wrote:
> >> From: Brandon Casey [mailto:drafnel@gmail.com]
> >> Sent: Wednesday, August 22, 2012 7:01 PM
> >> To: Joachim Schmitz
> >> Cc: Junio C Hamano; Shawn Pearce; git@vger.kernel.org;
> >> rsbecker@nexbridge.com
> >> Subject: Re: Porting git to HP NonStop
> >>
> >> On Wed, Aug 22, 2012 at 9:30 AM, Joachim Schmitz
> >> <jojo@schmitz-digital.de>
> >> wrote:
> >>
> >> > OK, so how about this:
> >> > /usr/local/bin/diff -EBbu ./compat/mkdir.c.orig ./compat/mkdir.c
> >> > --- ./compat/mkdir.c.orig       2012-08-21 05:02:11 -0500
> >> > +++ ./compat/mkdir.c    2012-08-21 05:02:11 -0500
> >> > @@ -0,0 +1,24 @@
> >> > +#include "../git-compat-util.h"
> >> > +#undef mkdir
> >> > +
> >> > +/* for platforms that can't deal with a trailing '/' */ int
> >> > +compat_mkdir_wo_trailing_slash(const char *dir, mode_t mode) {
> >> > +       int retval;
> >> > +       char *tmp_dir = NULL;
> >> > +       size_t len = strlen(dir);
> >> > +
> >> > +       if (len && dir[len-1] == '/') {
> >> > +               if ((tmp_dir = strdup(dir)) == NULL)
> >> > +                       return -1;
> >> > +               tmp_dir[len-1] = '\0';
> >> > +       }
> >> > +       else
> >> > +               tmp_dir = (char *)dir;
> >> > +
> >> > +       retval = mkdir(tmp_dir, mode);
> >> > +       if (tmp_dir != dir)
> >> > +               free(tmp_dir);
> >> > +
> >> > +       return retval;
> >> > +}
> >>
> >> Why not rearrange this so that you assign to dir the value of tmp_dir
> >> and then just pass dir to mkdir.  Then you can avoid the recast of
> >> dir to (char*) in the else branch.  Later, just call free(tmp_dir).
> >> Also, we have xstrndup.  So I think the body of your function can become
> something like:
> >>
> >>    if (len && dir[len-1] == '/')
> >>        dir = tmp_dir = xstrndup(dir, len-1);
> >
> > xstndup() can't fail?
> 
> Correct.  It will either succeed or die.  It will also try to free up some memory
> used by git if possible.

OK. So let's use that then.

Bye, Jojo
