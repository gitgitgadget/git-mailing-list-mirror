From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Wed, 10 Mar 2010 08:26:16 +0100
Message-ID: <4B974998.5030708@viscovery.net>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>	 <4B9504C9.5000703@lsrfire.ath.cx>	 <fcaeb9bf1003080632o622c8c79x85b816edcf893bc3@mail.gmail.com>	 <4B967C36.90309@lsrfire.ath.cx> <fcaeb9bf1003091627p65ad6e60u4bbae2eb4e859f13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 08:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpGJH-0006ip-O1
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 08:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab0CJH0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 02:26:22 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:9783 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753189Ab0CJH0U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 02:26:20 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NpGJ7-0006Po-1x; Wed, 10 Mar 2010 08:26:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C0EE01660F;
	Wed, 10 Mar 2010 08:26:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <fcaeb9bf1003091627p65ad6e60u4bbae2eb4e859f13@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyen Thai Ngoc Duy schrieb:
> On 3/9/10, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>> OK, forking out is easy, but replacing printf() calls with calls to =
feed
>>  the columnizer shouldn't be _that_ intrusive, either.
>=20
> Well, also fwrite() and write(). If disliked "if (blah) feed_it();
> else printf(as normal);" construct. But we can wrap it to
> feed_or_printf().

How about merging this into color_fprintf and friends?

-- Hannes

--=20
"Atomic objects are neither active nor radioactive." --
Doc.No N3035 (Working Draft, Standard for Programming Language C++)
