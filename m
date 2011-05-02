From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Mon, 02 May 2011 17:01:58 +0200
Message-ID: <4DBEC766.8020008@viscovery.net>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com> <1304340923-15927-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 17:02:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGudZ-0002iC-On
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 17:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087Ab1EBPCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 11:02:07 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36852 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759775Ab1EBPCF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 11:02:05 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QGudL-0006OD-Mq; Mon, 02 May 2011 17:02:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 65FCD1660F;
	Mon,  2 May 2011 17:01:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1304340923-15927-1-git-send-email-pclouds@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172596>

Am 5/2/2011 14:55, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> .gitignore support both positive and negative patterns. One may negat=
e
> the other. Current code works well if both patterns target files in
> the same directory.
>=20
> When a pattern targets a directory and an opposite pattern targets
> some files/directories within that directory, we need to descend in
> the directory until we're clear which ones are matched and which are
> not.
>=20
> excluded_from_list() fails to handle this case. It too eagerly decide=
s
> the fate of the whole directory without looking further in.

This has been debated just recently, and I don't think the current
behavior is broken. See

http://thread.gmane.org/gmane.comp.version-control.git/169913
http://thread.gmane.org/gmane.comp.version-control.git/157190/focus=3D1=
57196

-- Hannes
