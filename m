Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6DFE207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbdDZTi5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:38:57 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33779 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbdDZTiz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:38:55 -0400
Received: by mail-pg0-f47.google.com with SMTP id 63so4843664pgh.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1xwSIjE5rBRDv4RpsXoFvSBpC3PFdYmIyYTY7cY+R/0=;
        b=LghGEg5cz43Pr0+pscQPVDuc9/hv2WKuTQM082JmY8/LgVsDq7lOviv1W+KbfmXHgk
         RzGdBmSS/Bu4vgltTGJH+ejg/OpXLw1Bmh6x+/9CuIP7u2YKdjF8vwNCrnVrmOsco9/A
         4OgGixTREtJ3/Fnc1vckuvRfICdw+qUK6Whr11Smxhv3NFFVtcTAQMvTKOzx2G4pLla5
         j02Om00yER67Pil8W6tsPTs1QZQ3NQyzGnuTdMnqLZCzptFwYf1wfZZQb+Zus0Wgp7mk
         qN1zI0IiV/ULyLLqoeDKwovIkjntYzuwXg3lLUBND0JApXVdMOQRbmnr7XOdYUgQ9zkh
         hSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1xwSIjE5rBRDv4RpsXoFvSBpC3PFdYmIyYTY7cY+R/0=;
        b=czzKFZF57/govoFsd3VDYFslXY+pytx0ckFb3+K1YgEWI/2+uNuO5ZI0h5fU9xfohy
         /B0PnMcZ13dKQNd4s6tZq32d5StYzwxBtIQViqkgeOt+v6xK6jjWKpODWEpr4HJv6YW2
         XAiwMBN0GroSAu1/9PE10ENRdZ5nOIe31LfU1Zjg46Y6fQgTo4kpRHfUgHuJ/HUAXzxZ
         6QHFUN3/ctepn+Vuwd1+OLij5TM9jVExnWo+Jm9xlV1vtklYOL/KH6N656Gn4DguuApd
         /hgkD+V8dqjzMG2b20iUwBBLobavtHBJp23g+KYYG+CulZ3+NQ7XozHO5dFm4gGcp/6d
         nJSw==
X-Gm-Message-State: AN3rC/76aFQdWOLaiLay4oW85emBnWOIRmGxXdxkGJ7WX8YdYVSs8vVP
        O/KehgZNbxW4AQ5M4Q+Uc/8YGAZZPYqXQJI=
X-Received: by 10.99.126.23 with SMTP id z23mr1586029pgc.63.1493235534815;
 Wed, 26 Apr 2017 12:38:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 26 Apr 2017 12:38:54 -0700 (PDT)
In-Reply-To: <bbcbdf11-5065-8fcb-d78e-74db03814781@suse.cz>
References: <bbcbdf11-5065-8fcb-d78e-74db03814781@suse.cz>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Apr 2017 12:38:54 -0700
Message-ID: <CAGZ79kY2dmec17qdbpTqOx7Uro7X_UAyo0be5a08bdZyykA2nw@mail.gmail.com>
Subject: Re: [PATCH] Add --indent-heuristic to bash completion.
To:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 4:37 AM, Martin Li=C5=A1ka <mliska@suse.cz> wrote:
> Hello.
>
> The patch adds BASH completion for a newly added option.
>

The looks good, though the format is unusual. (We prefer the
format to be inline instead of an attachment)

Thanks,
Stefan
