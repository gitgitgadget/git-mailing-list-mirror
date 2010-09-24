From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCHv2 02/16] t4017 (diff-retval): replace manual exit code
 check with test_expect_code
Date: Fri, 24 Sep 2010 22:49:57 +0000
Message-ID: <AANLkTinBFgMvd6QKtHHPM0_ksKXKAaE8fBKpfKbi5sbk@mail.gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:50:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzH5h-00010C-D6
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183Ab0IXWt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:49:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52290 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab0IXWt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:49:58 -0400
Received: by iwn5 with SMTP id 5so2738574iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Zuj5nD0beqQBAgWy56Kh7Cw/sEgcsVkpt8nbhWH2Rng=;
        b=dZazG5Ls/Uuh+7P4SXNaUqYvamIchzOKoLVKxCTGPLVoVd4ZLUKHruEz1mV3ZPgTCn
         jcHOx1w89Wem23s2HBU2cv2k1YCKAhZglaF03nZgtvQ5wN4gTn99Iq8x1s6KDRBPH73O
         AsIRBJ1KhyznE2EF5BW8M9Ur5nzPKLKrk3d0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Cw3/h9nQbnh8kuU0DlBhpFWBUhyX8YBo5oEa23cJW1EQCR1gn8DT0+u8FVnuy0kUTW
         qsdRJFati06Ksov4dxPs0JYA1KZjRGHyOXY0iRgYTZin+JvcNmhB9igNkGeKNPlHPzHZ
         L7nyTxWeUQmsZ5m95kKxHhnjc2yYS5i6IA3jE=
Received: by 10.231.149.207 with SMTP id u15mr4607273ibv.13.1285368597923;
 Fri, 24 Sep 2010 15:49:57 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 15:49:57 -0700 (PDT)
In-Reply-To: <1285366976-22216-3-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157093>

Looks good.
