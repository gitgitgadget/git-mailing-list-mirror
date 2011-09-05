From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Special characters in file name
Date: Mon, 05 Sep 2011 15:16:32 +0200
Message-ID: <4E64CBB0.7020902@viscovery.net>
References: <4E60C6D0.7090609@intland.com>	<loom.20110902T143646-347@post.gmane.org>	<20110903144617.GA17893@elie> <20110904000933.195d5bf4@zappedws> <4E64BD3D.6060900@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <zapped@mail.ru>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?VGFqdGkgw4Frb3M=?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 15:16:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Z2W-0006WZ-Jm
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 15:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598Ab1IENQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Sep 2011 09:16:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35438 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241Ab1IENQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2011 09:16:35 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R0Z2O-0001UH-HJ; Mon, 05 Sep 2011 15:16:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 46F3A1660F;
	Mon,  5 Sep 2011 15:16:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <4E64BD3D.6060900@intland.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180741>

Am 9/5/2011 14:14, schrieb Tajti =C3=81kos:
> Thanks four your answer. However, it didn't help. After setting the
> core.quotepath option to false I get this:
>=20
> diff --git a/<E1>rv<ED>zt<FB>r<F5> b/<E1>rv<ED>zt<FB>r<F5>
>=20
> Is there a solution?

This is because the output goes through the pager (less), which treats
non-ASCII characters.

Tweak your settings (LESSCHARSET) or use a different or no pager.

-- Hannes
