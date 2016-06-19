Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD751FE4E
	for <e@80x24.org>; Sun, 19 Jun 2016 11:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbcFSLcE (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 07:32:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34983 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcFSLcC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 07:32:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id t190so9447350pfb.2
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 04:32:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OUSH0+KIxLvWv2HSkdhCW4mYkaxiN4t5ph/njt+PX9o=;
        b=tkqHuVPnJ91xmeYKyG09jvWfBtBfb7v/tNlgmtzjlECy5FPbQnQqhTe7dWm153k1I+
         kS+kaKtQpmZzP4A/XjfAp860ww8VgcEXINldVoI1bEysbpLO+vf69GLbUokxpJE7VW6s
         M5S0q22z0TFVUUfdN9+hw4UfvGgT65N5iRJcyw385sSG0fFxdEAtcjxIDGDlYrPWxyGy
         noy0HvPDvUttuYmZauRjyQWFH7hKAn/VD4hgoSuUMbFEHt8s5oH8o40s31pKRB/ehE2S
         3lZo/XMHaQynDO9/ezOdcHmQ+LLQzfT4Dhdr1PxH8Yzin+8jGRiL7NCi7N7R6zM90qyD
         e/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OUSH0+KIxLvWv2HSkdhCW4mYkaxiN4t5ph/njt+PX9o=;
        b=Ob4vEPrj9SSBDeJjzYmC8mK6Ji9liahYjFnU8RYIkpWyukoLUFBWU4FvlIOANYBhT/
         w0nYdljKmNKN9sDytk5TuVYG+EqAtLCa0kGqrq9SxAfDr8tctUO5yQsB1WdwLZXC3SbE
         4HSAdBQfVndYqSI4Tz1W9VYk1zbLbl/FMrtKG9Je7wOV3TMexAlRyJQL+7jrekpy1VPN
         OlDrLc2+nTU4Ir4TISoONKXTNtsclHrD1jwpaNjeItgmYgYD5PKBBXpkuKBYiz4h4rQx
         +LoYDJQgQuoydu80P09HoXo9d1QjiBP3gcbyQhlOKkBXVnNzd3fDB4vL58JxD3+eQa0C
         CsMg==
X-Gm-Message-State: ALyK8tKvHOMTImBYvYUvnPNEoIJ9tKcBJrumhjj8Zs9oeRXzCzJXNXyleQU+LxOOZc/hsg==
X-Received: by 10.98.30.133 with SMTP id e127mr15000572pfe.112.1466335920826;
        Sun, 19 Jun 2016 04:32:00 -0700 (PDT)
Received: from localhost.localdomain ([118.71.221.47])
        by smtp.gmail.com with ESMTPSA id 64sm52867270pfj.96.2016.06.19.04.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2016 04:31:59 -0700 (PDT)
From:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, LE Manh Cuong <cuong.manhle.vn@gmail.com>
Subject: Re: [PATCH] git-sh-setup.sh: fix missing double quotes variables
Date:	Sun, 19 Jun 2016 18:31:54 +0700
Message-Id: <20160619113154.3228-1-cuong.manhle.vn@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <xmqqinx5yijm.fsf@gitster.mtv.corp.google.com>
References: <xmqqinx5yijm.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> While I think enclosing the string in dq is an improvement (as I
> said already), I still do think your use of the v-word is making a
> mountain out of an anthill.

Well, sorry if that word is annoyed.

So, is this patch fine or I must re-phrase the title?
