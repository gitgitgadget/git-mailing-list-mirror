From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Wed, 12 Aug 2009 09:31:32 +0200
Message-ID: <4A826FD4.5080201@viscovery.net>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <1250005446-12047-2-git-send-email-pclouds@gmail.com> <1250005446-12047-3-git-send-email-pclouds@gmail.com> <1250005446-12047-4-git-send-email-pclouds@gmail.com> <1250005446-12047-5-git-send-email-pclouds@gmail.com> <1250005446-12047-6-git-send-email-pclouds@gmail.com> <1250005446-12047-7-git-send-email-pclouds@gmail.com> <1250005446-12047-8-git-send-email-pclouds@gmail.com> <1250005446-12047-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 09:32:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb8JZ-0006Yh-T3
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 09:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbZHLHbh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 03:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbZHLHbh
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 03:31:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33979 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZHLHbg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 03:31:36 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mb8J3-0004JN-AX; Wed, 12 Aug 2009 09:31:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0A954A4A1; Wed, 12 Aug 2009 09:31:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1250005446-12047-9-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125675>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> This series is useless until now because no one would use read-tree t=
o
> checkout. At least with this, you can really use/test the series.
> Porcelain design was originally "if you have .git/info/sparse,
> porcelains will use it, if you don't like that, remove
> .git/info/sparse" while plumblings have an option to
> enable/disable this feature.
>=20
> And I still like that behavior. How about we enable sparse checkout
> by default for porcelains and make a config option to disable it?

I would enable sparse checkout by default even for plumbing. Whether th=
e
checkout area is sparse should always be governed by .git/info/sparse.
This way, existing scripts and aliases should automatically work in spa=
rse
worktrees.

BTW, the name .git/info/sparse is perhaps a bit too technical in the se=
nse
that only git developers know that this feature runs under the name
"sparse checkout". Perhaps it should be named

   .git/info/indexonly
   .git/info/nocheckout

or so.

-- Hannes
