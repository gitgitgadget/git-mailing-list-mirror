From: Maxim Bublis <satori@yandex-team.ru>
Subject: Re: [PATCH] contrib/svn-fe: fix Makefile
Date: Wed, 27 Aug 2014 21:36:15 +0400
Message-ID: <6CB16507-1C40-45CE-9D12-227A0171C183@yandex-team.ru>
References: <1409057062-72857-1-git-send-email-satori@yandex-team.ru> <53FC5404.7050403@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:41:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMhE2-00064Y-8M
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 19:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933776AbaH0Rlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2014 13:41:32 -0400
Received: from forward-corp1f.mail.yandex.net ([95.108.130.40]:46901 "EHLO
	forward-corp1f.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932511AbaH0Rl3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 13:41:29 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Aug 2014 13:41:29 EDT
Received: from smtpcorp4.mail.yandex.net (smtpcorp4.mail.yandex.net [95.108.252.2])
	by forward-corp1f.mail.yandex.net (Yandex) with ESMTP id E2FED2420143;
	Wed, 27 Aug 2014 21:36:17 +0400 (MSK)
Received: from smtpcorp4.mail.yandex.net (localhost [127.0.0.1])
	by smtpcorp4.mail.yandex.net (Yandex) with ESMTP id A576D2C06B8;
	Wed, 27 Aug 2014 21:36:17 +0400 (MSK)
Received: from unknown (unknown [2a02:6b8:0:408:8d02:cccf:e15a:4cda])
	by smtpcorp4.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id XCPROOD5IN-aHKikbPn;
	Wed, 27 Aug 2014 21:36:17 +0400
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client certificate not present)
X-Yandex-Uniq: 869533e9-1a03-458e-b447-04c6bceffac2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
	t=1409160977; bh=8X2zwSey+YyhjSvjttyt22VgAI0eceuxF5y6/F+Vxcw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	b=tWZAMo+E2mSLY0XvLhHlCw9fCs1T6e5Rfm3JQnl/RHBgaOAshGE1dDHJh6CSXoIEy
	 Ukvo1sMn9YbF2sJ+GF8lbHY4a4i/GevJdfLpV/k8sS/NdVAGNY6wbbuXzdjAUuz7/s
	 3fi7p8h9ujyu89EcbRe+CF++m86FlIoaJq9Mtlu8=
Authentication-Results: smtpcorp4.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
In-Reply-To: <53FC5404.7050403@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256016>


On 26 =D0=B0=D0=B2=D0=B3. 2014 =D0=B3., at 13:31, Torsten B=C3=B6gersha=
usen <tboegi@web.de> wrote:

> On 08/26/2014 02:44 PM, Maxim Bublis wrote:
>>=20
>> +
>> +ifeq ($(uname_S),Darwin)
>> +	CFLAGS +=3D -I/opt/local/include
>> +	LDFLAGS +=3D -L/opt/local/lib
>> +endif
>> +
> Should it be possible to disable this by using NO_DARWIN_PORTS
> like we do in the main Makefile ?

I think so, thanks for pointing me on that. Though I hope it wouldn=E2=80=
=99t be too much "copy-paste=E2=80=9D
from main Makefile to support all options in both Makefiles.