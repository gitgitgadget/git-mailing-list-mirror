From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: Storing permissions
Date: Sat, 16 Apr 2005 21:01:35 -0400
Message-ID: <118833cc05041618017fb32a2@mail.gmail.com>
References: <20050416230058.GA10983@ucw.cz>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 02:58:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMy6j-0001YX-66
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVDQBBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 21:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVDQBBg
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 21:01:36 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:32081 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261228AbVDQBBf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 21:01:35 -0400
Received: by rproxy.gmail.com with SMTP id a41so853766rng
        for <git@vger.kernel.org>; Sat, 16 Apr 2005 18:01:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TxocqRJgSb00as2Gu4qgkx618u6NsBVnJcqOHkDdPUWTC2M2xiSB3n0f/QoFLJW2gEps/hyUoKG4azCiemP2F1DdMet7btO4yEF8lTrcDhlNxrJY7Oi7mQI6Fz4wi9tEBsK65MCutex4ghHvjPXGREdeV9+lO601jOmn7LTvr6k=
Received: by 10.38.152.65 with SMTP id z65mr2530445rnd;
        Sat, 16 Apr 2005 18:01:35 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Sat, 16 Apr 2005 18:01:35 -0700 (PDT)
To: Martin Mares <mj@ucw.cz>
In-Reply-To: <20050416230058.GA10983@ucw.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Does it really make sense to store full permissions in the trees? I think
> that remembering the x-bit should be good enough for almost all purposes
> and the other permissions should be left to the local environment.

It makes some sense in principle, but without storing what they mean
(i.e., group==?) it certainly makes no sense.  It's a bit like unpacking a
tar file.

I suspect a non-readable file would cause a bit of a problem in the low-level
commands.

Morten
