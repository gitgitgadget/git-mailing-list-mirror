From: "Chen WANG" <ellre923@gmail.com>
Subject: RE: pretty format can't work on cron job
Date: Sat, 6 Nov 2010 12:42:07 +0800
Message-ID: <01c101cb7d6c$fd053cf0$f70fb6d0$@com>
References: <7B2091481B9ED640A92789B0CA07059587CCF7@CDCEXMAIL02.tw.trendnet.org> <4CD3C262.6080108@viscovery.net> <7B2091481B9ED640A92789B0CA07059587CD03@CDCEXMAIL02.tw.trendnet.org> <20101105131444.GB11707@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <j.sixt@viscovery.net>, <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>,
	"Chen Wang \(QA-CN\)" <chen_wang@trendmicro.com.cn>
X-From: git-owner@vger.kernel.org Sat Nov 06 05:43:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEacH-00084X-Me
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 05:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214Ab0KFEmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Nov 2010 00:42:20 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:56548 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab0KFEmT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 00:42:19 -0400
Received: by pxi15 with SMTP id 15so580351pxi.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 21:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:references
         :in-reply-to:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding:x-mailer:thread-index:content-language;
        bh=ISeDnXT0oRfbH7eDLIYnxZqfnvq0V+GqhZXdc0Jcq5E=;
        b=x9G+8L4PdEgB4uOitHfD67HRuFgni5WfpaM1BiXVrOgTyB+9tlWasDCrYYQNXA0vXn
         +UhxVYzI7xpSNn7CQv8kuBGwkcJTevB7o1vXIY8BY4RlB2kr55I3ldph8+4Lk/4gmwJs
         vDsEENbAIlXhrpgaERirvhFgeeB0QuYk9eptM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-type:content-transfer-encoding:x-mailer
         :thread-index:content-language;
        b=oXNT3jYopnvEOzAoUtek7vTrpHNVDZSeT/jRdk/zM5A4VV4qing8QV0kuhoDwu0Wt9
         yDj6QLQ8zqrufdtH0/JAYzSjX6Saqq+2gUTQSxW20JJdKgeuenDA5PgahZ9vQ0D6H5RX
         Y5+Hy3BIowAYffFEN+BLhww6DINpZEEd3tIm0=
Received: by 10.142.210.5 with SMTP id i5mr2317174wfg.324.1289018538613;
        Fri, 05 Nov 2010 21:42:18 -0700 (PDT)
Received: from njchenwang ([218.104.127.130])
        by mx.google.com with ESMTPS id w14sm2930668wfd.6.2010.11.05.21.42.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Nov 2010 21:42:16 -0700 (PDT)
In-Reply-To: <20101105131444.GB11707@sigill.intra.peff.net>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Act8609QH03fMJ+xSiis1wSdZbJnpQAgCn6A
Content-Language: zh-cn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160833>

> -----Original Message-----
> From: Jeff King [mailto:peff@peff.net]
> Sent: 2010=E5=B9=B411=E6=9C=885=E6=97=A5 21:15
> To: chen_wang@trendmicro.com.cn
> Cc: j.sixt@viscovery.net; git@vger.kernel.org; ellre923@gmail.com
> Subject: Re: pretty format can't work on cron job
>=20
> On Fri, Nov 05, 2010 at 04:47:05PM +0800, chen_wang@trendmicro.com.cn
> wrote:
>=20
> > > > But when I put that command on cron job, even I run =E2=80=9C. =
/etc/profile=E2=80=9D and
> =E2=80=9C.
> > > ~/.bash_profile=E2=80=9D first, I can=E2=80=99t get correct forma=
t of output.
> > > > -------------------------------------------------
> > > > Author: %aN <amit.shah@redhat.com>; Date: Wed Oct 20 13:45:43 2=
010
> > > +1030
> > > >  100.0% drivers/char/
> > > >  1 files changed, 14 insertions(+), 3 deletions(-)
> > > > -------------------------------------------------
> > >
> > > % has a special meaning in a crontab. See man 5 crontab.
> > >
> >
> > I warped this command in script and trigger script in crontab.
> > I think it's not the root cause, because %ae still works.
>=20
> I notice that the only placeholder that is broken is %aN, which conve=
rts
> using the .mailmap file. Maybe something in your environment is
> preventing reading that file properly?
>=20

$ ll .mailmap
-rw-r--r-- 1 wangchen club 4021 Oct 15 06:18 .mailmap

> Can you show us the exact script you're calling from your crontab fil=
e?
> I'm wondering if it's something to do with being in the same director=
y.
>=20

Sure.
$ crontab -l
58 06 * * * /home/wangchen/kps_update
$ cat /home/wangchen/kps_update
#!/bin/bash
su wangchen -
=2E /etc/profile
=2E ~/.bash_profile
cd /home/wangchen/kps
git pull
make
cd /home/wangchen/linux-2.6
git pull
/home/wangchen/kps/kps_web/kps_do /home/wangchen/linux-2.6 /home/wangch=
en/kps
$ cat /home/wangchen/kps/kps_web/kps_do
#!/bin/sh
#check script parameters
if [ -r $1 -a -w $2 ]; then
        echo "begin to update kps_result"
        readonly LGP=3D$1
        KGP=3D$2
        KGP=3D${KGP%%/}
else
        echo "usage: $0 linux_kernel_source_dir kps_source_dir"
        exit 1
fi
cd $LGP
git log 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2.. -M --date=3Dshort --=
pretty=3Dformat:"Author: %aN <%ae>; Date: %ad" --shortstat --dirstat --=
no-merges >/tmp/ChangeLog-all

> -Peff
