Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F06F02018B
	for <e@80x24.org>; Sun, 19 Jun 2016 18:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbcFSSLQ (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 14:11:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33872 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbcFSSLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 14:11:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id 66so9902332pfy.1
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 11:09:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6LOagqEsQktDk50A/qG+CGL8swj82srxPw23WGs8VoA=;
        b=xiRHr+vTU5nPV5910bCg3NoM0dyD9wz2S+Sh0MWhf/TQQ2yhB9tHzBBDYVkahn8k8G
         IEywsDY80uq4xRc+No/NsMWqBQhL/ZgNKfsKU7GVLoeX0cK2ptfiofKJnYT2Xe8FxQzQ
         bJfOwvEVVx6ddgGm9T7F9sURACFsPucZNdee69COF4sMXwOsXQzKKgFVVCHQN6V490Md
         yJtxN2lHWCFe8Y3YHdFqN8o4/K6BzgQ4bUQMkgXTUKxxmx5rMg+rylBE54C+2BjjDPn4
         0mgCtn02VcTJj746KRj3RJGLTqH0MccpknzVawyki9ZcLv6FMPTbUGWO6Jo//JXkharL
         Caww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6LOagqEsQktDk50A/qG+CGL8swj82srxPw23WGs8VoA=;
        b=bKrzNFkZvwkTb8j8Uo/GmoV6ex+nZDWBQO04DS+xq1Kv90/okj5AWXiDGdv6xcB7Vu
         uJShudBsqVtNR6fW1UCxML9eRYZsmJL5+K0JTGvgxOY34TkIsLynzkD9bxPeQ6P6vha1
         Qqh3qqWd3gmO1UjW2dDkTqPiyUL56vc32qqzfqoKIcMB7moXNTYY5297rHpnfCYEcVXw
         IPzb7Nsfv7qVVGt+K00pbwUChE0jUAm0XDapri3jUS/didkzlQRa6Cca4+tPwR8uNEm0
         0zY411s9qRclQ8ZP3vFfNIp9DnwQwAPPfhgglo1e7juXeb9aW/C2tJJemgJtu/lJs4ol
         UCvg==
X-Gm-Message-State: ALyK8tLyp2XN9K7QyFZ+TrU2WuuaSDn2EfkWHfaHyECpm+TnPwLI76/MhVNZFG5Nk+i8zQ==
X-Received: by 10.98.70.11 with SMTP id t11mr16953811pfa.16.1466359773561;
        Sun, 19 Jun 2016 11:09:33 -0700 (PDT)
Received: from localhost.localdomain ([118.71.221.47])
        by smtp.gmail.com with ESMTPSA id wt6sm82448361pab.3.2016.06.19.11.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2016 11:09:32 -0700 (PDT)
From:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, LE Manh Cuong <cuong.manhle.vn@gmail.com>
Subject: Re: [PATCH] git-sh-setup.sh: fix missing double quotes variables
Date:	Mon, 20 Jun 2016 01:09:28 +0700
Message-Id: <20160619180928.16255-1-cuong.manhle.vn@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <xmqqvb15vz3y.fsf@gitster.mtv.corp.google.com>
References: <xmqqvb15vz3y.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It's really a good commit message, better than mine.

So must I make another patch or you will update the commit message?

PS: This is the first time I submit a patch to Git, so forgive me
if I made any silly questions.
