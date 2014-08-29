From: Maxim Bublis <satori@yandex-team.ru>
Subject: Re: [PATCH 2/2] fast-import: fix segfault in store_tree()
Date: Fri, 29 Aug 2014 15:40:00 +0400
Message-ID: <F3FA18F7-324F-4E57-A936-5A8FA986E1BC@yandex-team.ru>
References: <1409237674-74185-1-git-send-email-satori@yandex-team.ru> <1409237674-74185-3-git-send-email-satori@yandex-team.ru> <xmqqwq9s6w8z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 13:50:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNKhA-0003lB-CN
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 13:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbaH2LuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Aug 2014 07:50:14 -0400
Received: from forward-corp1e.mail.yandex.net ([77.88.60.199]:50529 "EHLO
	forward-corp1e.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751678AbaH2LuN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 07:50:13 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Aug 2014 07:50:12 EDT
Received: from smtpcorp4.mail.yandex.net (smtpcorp4.mail.yandex.net [95.108.252.2])
	by forward-corp1e.mail.yandex.net (Yandex) with ESMTP id C3BD96405D7;
	Fri, 29 Aug 2014 15:40:01 +0400 (MSK)
Received: from smtpcorp4.mail.yandex.net (localhost [127.0.0.1])
	by smtpcorp4.mail.yandex.net (Yandex) with ESMTP id 6CDA82C06E0;
	Fri, 29 Aug 2014 15:40:01 +0400 (MSK)
Received: from unknown (unknown [2a02:6b8:0:408:153c:f090:a9db:edaf])
	by smtpcorp4.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id KdGexe4kYV-e1Ki6XEK;
	Fri, 29 Aug 2014 15:40:01 +0400
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client certificate not present)
X-Yandex-Uniq: 6101ec87-6237-4329-a696-45ffd180ff60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
	t=1409312401; bh=Mudw4ue7ToiDCPOJhWdbUvwS3/YY7sgOiq0yKDzF0NE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	b=ofyaK5Sy4zAnxCMM1H8KrQwkAA76tnOfM0nEIY2ppr3xq90OGso6nfLL6Zs2njqts
	 wRpYuI8O9JGIo31oTh1BC6HEvMH2JvLsyldfmrUrO1cVDbdYNErlqhe7Le/QDJPFak
	 /nrZKxaAAxIUuIDFjGrXle2WBrPuhgLfGeMkWuvo=
Authentication-Results: smtpcorp4.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
In-Reply-To: <xmqqwq9s6w8z.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256142>


On 29 =D0=B0=D0=B2=D0=B3. 2014 =D0=B3., at 3:16, Junio C Hamano <gitste=
r@pobox.com> wrote:

> Missing =E2=80=98;'

Thanks, I=E2=80=99ll fix it. What a stupid mistype, I was writing some =
amount of Go code recently and it doesn=E2=80=99t use semicolons.
