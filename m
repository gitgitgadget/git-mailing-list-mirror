From: David Turner <dturner@twopensource.com>
Subject: Re: ag, **, and the GPL
Date: Tue, 18 Nov 2014 12:57:36 -0500
Organization: Twitter
Message-ID: <1416333456.27401.1.camel@leckie>
References: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthew Kaniaris <mkaniaris@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 18:57:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqn27-0005VN-Pn
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbaKRR5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:57:40 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:52344 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbaKRR5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:57:39 -0500
Received: by mail-qg0-f41.google.com with SMTP id j5so3061536qga.14
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 09:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=fed0YfE4/6C+mwQzJoffmhrlnvNoRr2LymlOVHngYcA=;
        b=Mrue2uWBK0VHiSph38Tp15wN+vFaRq5c8Ri05FXqRnzlgNGQL5i7ERgCDMrioE1Dmi
         zooQl+gha4IoTHUnG/O/fA/ej8HNsvkz1LO+1a0lahX7pX8l0cAyiuvDjPru+xl2LK/o
         yobn38X0uaPEcJxWiZGpYHUDbSXQ2h4lzItW0lw/qyHtK7a0eRIZnFSuxJM+bfTtXPR7
         6uMPdWcpqqrIrhUL+XoGog/wvL4Dc0XK7Hao33+tVVNIJL7vzc5lhbqZWaebOJQnvcOU
         drJYLbL8IzRz0XHQoHrGXHhyxXR1zI9Bq5O5Pzpj+e2WKhPbey8bwdtyV4nlrBxJiXRI
         ewuw==
X-Gm-Message-State: ALoCoQkKBwTTH/f/yj1LHK6Ab9nRHlBrwMsz0DmwJHbJjc1dQMdhZFBbblOSjgZoBs94vVP617Ee
X-Received: by 10.224.13.145 with SMTP id c17mr15785352qaa.96.1416333458350;
        Tue, 18 Nov 2014 09:57:38 -0800 (PST)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id m39sm37477965qgd.28.2014.11.18.09.57.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2014 09:57:37 -0800 (PST)
In-Reply-To: <CACr0F2iGY_vxWzsNaPQNJ2cLUDRZPS70i79EhyA9OkA7qLaUQQ@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2014-11-17 at 20:50 -0800, Matthew Kaniaris wrote:
> The Silver Search (https://github.com/ggreer/the_silver_searcher), is
> a small, open source, cross platform searching utility written as a
> replacement for ack.  One of the major benefits of Ag (and a source
> for much of its speed) is that it obeys .gitignore.  However, Ag
> currently treats gitignores as regexs which produces incorrect results
> for e.g. **.  I'd like to add support to ag to obey the .gitignore
> spec but I'm not keen on implementing yet another fnmatch clone.  Ag
> is licensed under the Apache License Version 2.0 which to the best of
> my understanding is incompatible with the GPLv2.  Would you grant me
> permission to reuse wildmatch.c (and necessary includes) for use in
> Ag?

I already implemented this without using any git code at
https://github.com/novalis/the_silver_searcher.  The patch was rejected
because it slowed down ag slightly (or perhaps because it was overly
complex). 
