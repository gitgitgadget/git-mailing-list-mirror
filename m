From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 7/8] Documentation/cherry-pick: describe passing more than one commit
Date: Mon, 14 Jun 2010 05:33:10 +0200
Message-ID: <201006140533.10649.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> <201006020757.34186.chriscool@tuxfamily.org> <20100602061452.GA9439@progeny.tock>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 05:33:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO0QQ-0004Cn-Cn
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 05:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab0FNDdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jun 2010 23:33:21 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:35136 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863Ab0FNDdU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jun 2010 23:33:20 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E1DBE818050;
	Mon, 14 Jun 2010 05:33:11 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <20100602061452.GA9439@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149065>

On Wednesday 02 June 2010 08:14:52 Jonathan Nieder wrote:
> Christian Couder wrote:
> > On Tuesday 01 June 2010 11:51:24 Jonathan Nieder wrote:
> >> git rev-list master -- README | git cherry-pick -n --stdin::
> >>
> >> 	Apply the changes introduced by all commits on the master
> >> 	branch that touched README to the working tree and index,
> >> 	so the result can be inspected and made into a single new
> >> 	commit if suitable.
> >
> > I think "--reverse" is needed after "rev-list" and cherry-pick has =
no
> > --stdin option.
>=20
> That=E2=80=99s too bad. :(  git show inherits it from rev-list.
>=20
> Your new series looks good.  Maybe I will obfuscate the examples some
> other day.

I will send a patch to add option --stdin to revert/cherry-pick. And it=
 adds=20
your fixed obfuscating example :-)

Thanks,
Christian.
