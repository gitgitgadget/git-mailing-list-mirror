From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: git commit -C vs. prepare-commit-msg hook
Date: Wed, 3 Nov 2010 00:01:12 +0100
Message-ID: <20101102230112.GC2116@neumann>
References: <20101102145059.GB2116@neumann>
	<AANLkTimdjAc1ZKNkWAO_KU8CqorShMv0TNDvsy5qmSDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 00:01:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDPqz-0003Ap-93
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 00:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab0KBXBQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 19:01:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65059 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab0KBXBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 19:01:15 -0400
Received: from localhost6.localdomain6 (p5B130B92.dip0.t-ipconnect.de [91.19.11.146])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Lkism-1OfBYz2mmq-00aloj; Wed, 03 Nov 2010 00:01:13 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTimdjAc1ZKNkWAO_KU8CqorShMv0TNDvsy5qmSDw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:UWf5Q5eWG4lybvXP+O1K74VcS3GecWDcPnb4pw7ggX/
 OuoYygdZ1srkpaUC+LTZnxorXndXmr6oR2bNHG0tQa/3Db7XEJ
 vEIPxhfOB5x+LRjI3/aJcWOlMTnGJiIh5xWiHc5q1Kls0T57ry
 bqC6TDex2v08IC5HYFqyfZnKKORHmt+bJXMKb52kJE73MNhym0
 6d0nZFF0uGzS6tAXTETdg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160562>

Hi Pat,


Thanks for your reply.

On Tue, Nov 02, 2010 at 02:11:33PM -0600, Pat Notz wrote:
> 2010/11/2 SZEDER G=E1bor <szeder@ira.uka.de>:
> > Hi,
> >
> > Just noticed (read: got bitten by ;) that 'git commit' runs the
> > prepare-commit-msg hook even if it was invoked with the -C option.
> > This seems contradictory to me, because 'git commit -C' is to reuse=
 an
> > already existing log message (and author info) as is, whereas
> > prepare-commit-msg is there to automatically edit the commit messag=
e.
> >
>=20
> Can your hook look for the presence of the third command line argumen=
t
> to catch this case?

Yeah, this is what I tried as workaround ...

> Granted, you won't be able to tell the difference between -C and -c
> or --amend.

=2E.. and this is why it didn't work out, i.e. I needed to differentiat=
e
-C from -c or --amend.

> > Is this desired and I'm missing something, or is this a bug? =A0(or=
 just
> > accidental, but we can't do anything about it anyway because of
> > backward compatibility?)
