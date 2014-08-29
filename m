From: Maxim Bublis <satori@yandex-team.ru>
Subject: Re: [PATCH 1/2] t9300: test filedelete root
Date: Fri, 29 Aug 2014 15:37:25 +0400
Message-ID: <2F10795B-457A-493F-BF0F-CCCF0E64CF9C@yandex-team.ru>
References: <1409237674-74185-1-git-send-email-satori@yandex-team.ru> <1409237674-74185-2-git-send-email-satori@yandex-team.ru> <xmqqa96o8cxa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 13:37:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNKUq-00017X-Sx
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 13:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbaH2Lhd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Aug 2014 07:37:33 -0400
Received: from forward-corp1f.mail.yandex.net ([95.108.130.40]:37431 "EHLO
	forward-corp1f.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752110AbaH2Lhc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 07:37:32 -0400
Received: from smtpcorp4.mail.yandex.net (smtpcorp4.mail.yandex.net [95.108.252.2])
	by forward-corp1f.mail.yandex.net (Yandex) with ESMTP id 0F7BB24200DC;
	Fri, 29 Aug 2014 15:37:27 +0400 (MSK)
Received: from smtpcorp4.mail.yandex.net (localhost [127.0.0.1])
	by smtpcorp4.mail.yandex.net (Yandex) with ESMTP id 4FF9A2C06E0;
	Fri, 29 Aug 2014 15:37:26 +0400 (MSK)
Received: from unknown (unknown [2a02:6b8:0:408:153c:f090:a9db:edaf])
	by smtpcorp4.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id DWi1ldrKqL-bQKKlDkt;
	Fri, 29 Aug 2014 15:37:26 +0400
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client certificate not present)
X-Yandex-Uniq: ba9f8865-41d3-4df9-894c-31225d860040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
	t=1409312246; bh=a9QpXtRWJimN7hzuWu/uPP2g4Hhg6m3uV15jtn+kpqI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	b=dfWSll4r42xgIVKUJdGj9u1cR3p4GwXsLpePVQArIK6YCRsBd+SuvW5yCqWU6LOra
	 p8hRyZwFJFPncAnsL4stKm5YqbynLffg05PLJ+gRQBcZ/VY5l9MF6vfejPmU+kOXlB
	 G1ERSL1oigWMDLk3sMRBLfF7C+jHhTrD8h3wZo4I=
Authentication-Results: smtpcorp4.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
In-Reply-To: <xmqqa96o8cxa.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256141>

On 29 =D0=B0=D0=B2=D0=B3. 2014 =D0=B3., at 2:30, Junio C Hamano <gitste=
r@pobox.com> wrote:

> You may have been concentrating on the "delete root" case, but as
> long as you claim "We add a series to test filedelete command", it
> would be sensible to test more typical cases of deleting files, not
> the entire tree as well, no?  Perhaps add three paths in the initial
> commit e.g. hello.c, good/night.txt and good/bye.txt, first remove
> good/night.txt and validate the result, then remove good/ directory
> and validate the result, and finally remove the whole thing and
> validate the result, or something like that?

Sure, I=E2=80=99ll add more tests for filedelete command.

> In a patch series that introduces a demonstration of existing
> breakage and then fixes the breakage in a separate patch, mark the
> test that shows the known breakage with test_expect_failure and then
> turn that line into test_expect_success in the later patch that
> fixes the breakage.

Ok, thanks.