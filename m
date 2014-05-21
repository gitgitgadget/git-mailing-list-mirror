From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v4 4/5] t4205, t6006: Add failing tests for the case when
 i18n.logOutputEncoding is set
Date: Wed, 21 May 2014 16:38:17 +0100
Message-ID: <537CC869.1020104@ramsay1.demon.co.uk>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com> <cover.1400678003.git.Alex.Crezoff@gmail.com> <12b22fd98d687b0484d7d5e5f122d770ca56908d.1400678003.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?B?Tmd1eeG7hQ==?= =?UTF-8?B?biBUaMOhaSBOZ+G7jWMgRHV5?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 17:38:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn8b4-0004TB-JH
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 17:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbaEUPiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2014 11:38:22 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:56471 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751658AbaEUPiW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 11:38:22 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id BF6D318C94A;
	Wed, 21 May 2014 16:38:25 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 8969518C36E;
	Wed, 21 May 2014 16:38:25 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Wed, 21 May 2014 16:38:24 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <12b22fd98d687b0484d7d5e5f122d770ca56908d.1400678003.git.Alex.Crezoff@gmail.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249802>

On 21/05/14 14:20, Alexey Shumkin wrote:
> Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
> length with an appropriate padding. This works for non-ASCII texts wh=
en
> i18n.logOutputEncoding is UTF-8 only (independently of a printed comm=
it
> message encoding) but does not work when i18n.logOutputEncoding is NO=
T
> UTF-8.
>=20
> There were no breakages as far as were no tests for the case
> when both a commit message and logOutputEncoding are not UTF-8.
>=20
> Add failing tests for that which will be fixed in the next patch.
>=20
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
> Reviewed-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Hmm, I didn't really review these patches. I simply noted a problem
on my system and provided you with an extended bug-report and
assisted you in fixing it up. So, if it even warrants a mention in
the commit message, then 'Helped-by:' would be nearer the mark.

Thanks!

ATB,
Ramsay Jones
