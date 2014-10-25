From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/technical: signature formats
Date: Sat, 25 Oct 2014 10:30:25 +0200
Message-ID: <544B5FA1.2050804@gmail.com>
References: <cover.1413990838.git.git@drmicha.warpmail.net>	<13b090185cb5a36cddf8c1ba4fcd6fe52e109084.1413990838.git.git@drmicha.warpmail.net> <xmqq7fzshqrb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 21:53:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi7PL-0005bf-Nc
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 21:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbaJYTxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Oct 2014 15:53:48 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:60351 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbaJYTxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 15:53:47 -0400
Received: by mail-la0-f51.google.com with SMTP id q1so965203lam.38
        for <git@vger.kernel.org>; Sat, 25 Oct 2014 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Q72SpnClUhjorg+KTqM++dISTw5TI/W+WSBYfcZSaLI=;
        b=Wo4d49yg1VXVLovlFisTmkRP5wBFliIGlS9EXbSp5H2+WSmE93ok6AehDzjYnCNqac
         EVF7aFaLKVdlotrpzn2O3RYtXpXn3tmoAJU9j9VkQmEMoanLOQQc52mdBJQDYp89+AF2
         8vKdzUebyCkZL9gquky2SItSkKDTLp3lEkQ/304I94iFrhRTOCKrxTcO25DW3+EjtFC5
         HsnSIDsTk/5uJ5e0QaN8lj0YlcKXnYmLO6fD4wLyPBEiVUAUhNh/fCvkRosdqYGBrK6S
         V4biHWKOe+/c9bBG0JbfQpQi1ImvPIXUsChT9ZpLHOXnbEnGO4mC8X1iGa2oXQL3GMVf
         JimA==
X-Received: by 10.152.228.140 with SMTP id si12mr9566238lac.66.1414225829891;
        Sat, 25 Oct 2014 01:30:29 -0700 (PDT)
Received: from [192.168.130.235] ([158.75.2.130])
        by mx.google.com with ESMTPSA id u14sm2678666laz.13.2014.10.25.01.30.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 25 Oct 2014 01:30:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq7fzshqrb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 2014-10-22 21:02, Junio C Hamano pisze:

> A mergetag is not fundamentally a "signature" in the above sense,
> though.  It is just a dump of the object content in a regular object
> header field (hence indented by one SP), and its contents having PGP
> SIGNATURE is merely a natural consequence of the object recorded
> being a signed tag.  So the description of it in the same place as
> description for signed tags and signed commits feels a little bit
> out of place, but I do not think of a better place to describe it.

Does this mean that you can merge annotated (but not signed) tag,
and have it (as description of merged branch) in 'mergetag' header?

--=20
Jakub Nar=C4=99bski
