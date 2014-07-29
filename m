From: Guang Chen <cgcgbcbc@gmail.com>
Subject: Re: git add -i failed in 2.0.3
Date: Tue, 29 Jul 2014 14:55:29 +0800
Message-ID: <9A4F68F4-6162-462C-92E4-BD80D1BC1A75@gmail.com>
References: <DB19F40E-912E-42F0-AB63-838BADAF77FB@gmail.com> <53D74131.40005@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:55:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC1KA-00010w-Vk
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 08:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbaG2Gzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 02:55:47 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62134 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbaG2Gzq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 02:55:46 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so11229009pdj.30
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sxTldl3zL2EAcav3lOKEJZWos1/45sbfaCShJZZch6U=;
        b=Xcy1q9sOSx00kMkdqrSlDwYxlbj1mOsDSGavgpj/BAjD6PPE66w0gCGWgl2Y8S1iOC
         ta0KkxPPAlCGNC6hKx/K+Uj71Yk5j7YUiY8xRiJpJt8TG78n3914ROnbfyEFFGi2Ztsf
         YHg7G9nm0h/ox72elYYkQKZA7pIAq7Dt8mgx7UAcvZnZtZD3pnPnNmAoM3XXhlFmEIlh
         StPN80NaKz3BjkfxOqtsQHv0zeBi+ZnQdxtX2KadroSjIbHLK3mOMvpp/ZwsKYgyUnf+
         uVeTui/zdd4xK+kVPk5hlqm7MAHGIj9Ve1HAjBYFXJDixbK995WRz26kmFjd3FLSVcno
         HHVw==
X-Received: by 10.70.138.102 with SMTP id qp6mr103520pdb.132.1406616945812;
        Mon, 28 Jul 2014 23:55:45 -0700 (PDT)
Received: from [101.5.147.54] ([101.5.147.54])
        by mx.google.com with ESMTPSA id cr4sm19715824pbb.86.2014.07.28.23.55.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 23:55:45 -0700 (PDT)
In-Reply-To: <53D74131.40005@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254397>

I used 1.9.2 before, it was installed with brew as well.
I didn=92t found Git.pm under /usr/local/Cellar/git/, /usr/local/Cellar=
/git/2.0.3/, and I looked at /usr/local/Cellar/git/1.9.2/, there isn=92=
t a Git.pm either.

type perl says:
perl is /usr/bin/perl

Additionally, perl --version says:

This is perl 5, version 16, subversion 2 (v5.16.2) built for darwin-thr=
ead-multi-2level
(with 3 registered patches, see perl -V for more detail)=20

On Jul 29, 2014, at 14:37, Torsten B=F6gershausen <tboegi@web.de> wrote=
:

> On 07/27/2014 05:26 PM, Guang Chen wrote:
>> I use brew upgrade git to this version on OSX. And when I use git ad=
d -i, it says:
> Which version did you use before?
> Was it installed with brew as well ?
>>=20
>> Can't locate Git.pm in @INC (@INC contains: @@@/git/2.0.3/lib/perl5/=
site_perl /Applications/Xcode.app/Contents/Developer/Library/Perl/5.16/=
darwin-thread-multi-2level /Library/Developer/CommandLineTools/Library/=
Perl/5.16/darwin-thread-multi-2level /Users/guangchen/.opam/system/lib/=
perl5/darwin-thread-multi-2level /Users/guangchen/.opam/system/lib/perl=
5 /Library/Perl/5.16/darwin-thread-multi-2level /Library/Perl/5.16 /Net=
work/Library/Perl/5.16/darwin-thread-multi-2level /Network/Library/Perl=
/5.16 /Library/Perl/Updates/5.16.2 /System/Library/Perl/5.16/darwin-thr=
ead-multi-2level /System/Library/Perl/5.16 /System/Library/Perl/Extras/=
5.16/darwin-thread-multi-2level /System/Library/Perl/Extras/5.16 .) at =
/usr/local/Cellar/git/2.0.3/libexec/git-core/git-add--interactive line =
7.
>> BEGIN failed--compilation aborted at /usr/local/Cellar/git/2.0.3/lib=
exec/git-core/git-add--interactive line 7.
> Do you have Git.pm on your disc, somewhere under /usr/local/Cellar/gi=
t ?
>=20
> Which perl do you have, (may be more than 1?)
> I tend to have different perl installations under Mac OS, whch needs
> tweeking in the PATH, to have the "right one" in the PATH before e.g.=
 the
> one that comes with Mac OS.
> (Or write a wrapper script that sets up the PATH and then calls git)
>=20
> What does "type perl" in a command window say?
>=20
