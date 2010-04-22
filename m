From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 16:29:29 +0200
Message-ID: <m2hbn37e7q.fsf@igel.home>
References: <20100421195822.GX10984@baikonur.stro.at>
	<r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
	<20100422121408.GI3211@stro.at> <20100422124042.GA1433@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: maximilian attems <max@stro.at>, Tay Ray Chuan <rctay89@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 16:29:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4xPQ-00080M-71
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 16:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997Ab0DVO3e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 10:29:34 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:60128 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab0DVO3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 10:29:34 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 9A8DC1C0055D;
	Thu, 22 Apr 2010 16:29:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 6593D902C1;
	Thu, 22 Apr 2010 16:29:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id xhnTIBiDKzMw; Thu, 22 Apr 2010 16:29:31 +0200 (CEST)
Received: from igel.home (ppp-88-217-105-17.dynamic.mnet-online.de [88.217.105.17])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 22 Apr 2010 16:29:31 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id BFD14CA297; Thu, 22 Apr 2010 16:29:29 +0200 (CEST)
X-Yow: ..  I think I'll KILL myself by leaping out of this
 14th STORY WINDOW while reading ERICA JONG'S poetry!!
In-Reply-To: <20100422124042.GA1433@progeny.tock> (Jonathan Nieder's message
	of "Thu, 22 Apr 2010 07:40:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145534>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi maks,
>
> maximilian attems wrote:
>
>> ~/src/linux-2.6$ git name-rev a1de02dccf906faba2ee2d99cac56799bda3b9=
6a
>> =C2=A0a1de02dccf906faba2ee2d99cac56799bda3b96a undefined
>
> Thanks for pointing it out.  This is weird.
>
> The commit doesn=E2=80=99t seem to be part of any tagged release, nor=
 linus=E2=80=99s
> master:

$ git branch --contains a1de02dccf906faba2ee2d99cac56799bda3b96a
* master
$ git merge-base v2.6.34-rc1 a1de02dccf906faba2ee2d99cac56799bda3b96a
a1de02dccf906faba2ee2d99cac56799bda3b96a
git merge-base v2.6.33 a1de02dccf906faba2ee2d99cac56799bda3b96a
724e6d3fe8003c3f60bf404bf22e4e331327c596

So it has been merged beween v2.6.33 and v2.6.34-rc1

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
