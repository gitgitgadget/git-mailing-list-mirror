From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Mon, 26 Jul 2010 10:56:58 +0200
Message-ID: <201007261056.58985.jnareb@gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> <AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 26 10:57:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdJUu-0000nJ-Ta
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 10:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723Ab0GZI5L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 04:57:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51610 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab0GZI5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 04:57:10 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so2644799bwz.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 01:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LVLHl3zMpzHvZbVS+UeYGm9B8/xv3o0TbtYzhnHDgsQ=;
        b=SP+xIGTvIin5FS90fMDws3tiosXXhW7eG4CjOaVm8KOVbMZ/6uIrQjcADFyUP0DtKs
         F5F/j/myoV/bdieZIR/0f+EXRQvyIK9z9oUJNnVSC9PRHvTsLeMemcy1y9UbSRNDPNt6
         i5zDkvg5gnElwPj4g37zXsAcOCyl6Fg3ONRgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TKGjjfL0F+YYV2N9tgQVKZU8rW9Ly49h0Ig55BUFj2oVxhyye6Sj/MbfO2jZfoJRwE
         7wxhQVEIapbYmE+oTSlZGeG+sFL2YwX3+tA/XANTZA32G/y9cx6lC/dQIrdtmaVGIrxb
         LZY7eOtMD/Zz2VjJmHRn6cY3iWfcJfm98/ycE=
Received: by 10.204.134.156 with SMTP id j28mr5481497bkt.10.1280134629603;
        Mon, 26 Jul 2010 01:57:09 -0700 (PDT)
Received: from [192.168.1.13] (abvc184.neoplus.adsl.tpnet.pl [83.8.200.184])
        by mx.google.com with ESMTPS id s34sm2694676bkk.1.2010.07.26.01.57.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 01:57:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151820>

On Sat, Jul 24, 2010, skillzero@gmail.com napisa=C5=82:
> On Fri, Jul 23, 2010 at 3:50 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>=20
> > Honest question: do you care about the wasted disk space and downlo=
ad
> > time for these extra files? =C2=A0Or just the fact that git gets sl=
ow when
> > you have them?
>=20
> I have the similar situation to the original poster (huge trees) and
> for me it's all three: disk space, download time, and performance. My
> tree has a few relatively small (< 20 MB) shared directories of commo=
n
> code, a few large (2-6 GB) directories of code for OS's, and then
> several medium size (< 500 MB) directories for application code. The
> application developers only care about the app+shared directories (an=
d
> are very annoyed by the massive space and performance impact of the O=
S
> directories). The firmware-only developers only care about OS+shared
> and are mildly annoyed by the medium space and performance impact of
> the app directories. I work on all of the pieces, but even I would
> prefer to have things separated so when I work on the apps, git
> status/etc doesn't take a big hit for close to a million files in the
> OS directories (particularly when doing git status on Windows). Even
> when using the -uno option to git status, it's still pretty slow (ove=
r
> a minute).
>=20
> git-submodule might be technically possible in this situation, but
> having to commit and push each submodule and then commit and push the
> super module makes it slightly worse than just dealing with the
> space/download/performance issues of one huge repository.

But this is just a matter for improving UI for dealing with submodules,
isn't it.   For example having "git commit --recursive" would help
with 'having to commit each submodule', though how you would write comm=
it
messages then: perhaps supermodule commit message could be by default
composed out of submodules commits (if any).  "git push --recursive"
(or some support for push in "git remote") would help with 'having to
push each submodule'.

Isn't it?
--=20
Jakub Narebski
Poland
