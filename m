From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/5 v2] Worktree/Gitdir at root directory
Date: Fri, 12 Feb 2010 11:21:21 +0100
Message-ID: <4B752BA1.9080105@kdbg.org>
References: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Sm/Do28gQ2FybG9zIE1lbmRlcyBMdcOtcw==?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 11:21:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfseP-0004kZ-Be
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 11:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab0BLKVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 05:21:23 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:37226 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751134Ab0BLKVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 05:21:22 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D8A41CDF9A;
	Fri, 12 Feb 2010 11:21:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139678>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> So here we go again. Changes are:
>=20
>  - Support DOS drives as root path (Thanks Hannes)
>  - Fix one "broken" test that I was too lazy to do last time
>  - t1509-root-worktree.sh will refuse to run under root permission
>=20
> I did not test it on Windows, so an Ack from someone who actually tes=
ts it on Windows
> is really appreciated.

I don't see any regressions in may tests on Windows, but I actually don=
't=20
know what to test (the chroot test doesn't work on Windows). I did test=
 on=20
the root of a partition

    T:\> git init
    T:\> cd foo
    T:\foo> git add bar

and it works as expected.

You should address my comments to 3/5, please.

-- Hannes
