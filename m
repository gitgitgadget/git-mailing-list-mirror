From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Thu, 05 May 2011 08:28:01 +0200
Message-ID: <4DC24371.7060906@viscovery.net>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com> <1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 08:28:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHs2l-0004fc-8K
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 08:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921Ab1EEG2E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 02:28:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60278 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750788Ab1EEG2D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 02:28:03 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QHs2c-0008WF-4I; Thu, 05 May 2011 08:28:02 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D31431660F;
	Thu,  5 May 2011 08:28:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172804>

Am 5/5/2011 0:00, schrieb Micha=C5=82 Kiedrowicz:
> +# Define NO_LIBPCRE if you do not have libpcre installed.

This makes libpcre a requirement with an opt-out. But I can imagine tha=
t
there are many platforms where libpcre is not installed. We would have =
to
add NO_LIBPRCE=3D1 to many platform configuration sections. But how can=
 this
setting be countermanded if someone does install libpcre on such a plat=
form?

Wouldn't it be better to make this an opt-in (USE_LIBPCRE)?

-- Hannes
