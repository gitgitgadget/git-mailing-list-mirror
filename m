Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8131FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 13:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbcFTN7l (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 09:59:41 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34105 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbcFTN7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 09:59:40 -0400
Received: by mail-wm0-f46.google.com with SMTP id 187so7012040wmz.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 06:59:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=+b3aU5jFNZZbIDESnHrAAw3Ofm8aUOA6oNUCWhspbp8=;
        b=EzlEaK++Judc1q6llD1OZuyF1faL/wDQ0h/zJEglqoK+cupnRUehGIHNmWyY7BxuJD
         NJxfBRTl1nAKxZbEyCCmhwuzE0Pw2zFNvRJXGp/jGKtjidcx9inl9aqY6ZA1J8YbAjhh
         wZgubp8swBXvex9n8edWuFs1ChjfvP8kC2qSHU+7fdKIjIXrFTighY82cNhYXKCN7TGe
         IkqbIvJ5sskEkunZT7X1emyhEEUgBRICWWOZDPdloe7ibCVLwrUkUwyd8QYORnTEAMO/
         jkxub7tbkVoZ7L6xRGwdKb1yQ78lJd69xS9Q8Jl+4NxVZ02tvore1N+8FkawySMTYE2G
         JjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+b3aU5jFNZZbIDESnHrAAw3Ofm8aUOA6oNUCWhspbp8=;
        b=jOSFKXc5eqe/SLQstZEawg57LVAVZSAxp62Edv6Msu1JfIJ/i65awuSFz79BSNHB0U
         VfPZbLuKUyhG1eO+uS6s6+jtCZp0P48im0qohw6AzFMnbsDc0gTT2oZr/bqvfwS/UtOV
         7Ox66FvnwrzXyB5yeKoaoBpfHFmyj9aH2mIM0GArhnHaEEFTJGpy5VSyHL44QecTbmTg
         8uSR0gX/MuUJ4tVhE0sWjqjHjg2GiUk6Qk1qI2TPLvmo1F6OY9wEv7nEYOVgRl/l7n2B
         5bK7O+8Xub//+NoFjSrT/EkPi518IkbYBww0jPFbRFjpZRr2CixZDMhOWw1kAjDXoDcW
         jXAw==
X-Gm-Message-State: ALyK8tLdSOpnRSBVNXzgX2syKNj5fbeehmoPtb5fqfWlFPFVGXVBV7UHzJ2Du309r2/CIGiPN4dwyiZez+GWOQ==
X-Received: by 10.195.2.228 with SMTP id br4mr17063417wjd.59.1466431178554;
 Mon, 20 Jun 2016 06:59:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.113.74 with HTTP; Mon, 20 Jun 2016 06:59:19 -0700 (PDT)
From:	Mathieu Giorgino <mathieu.giorgino@gmail.com>
Date:	Mon, 20 Jun 2016 14:59:19 +0100
Message-ID: <CAGdHL45Sw7FFsja5Xnvc5jh1E1v3x3Rgaq6GPTiT3NjrZUPmaA@mail.gmail.com>
Subject: git stash doesn't always save work dir as-is: bug?
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Is there a reason this e-mail never received an answer ?

http://permalink.gmane.org/gmane.comp.version-control.git/234153

Isn't this a bug ?

Thanks,

-- Mathieu
