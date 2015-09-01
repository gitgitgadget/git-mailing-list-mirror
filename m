From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 0/3] submodule--helper: Have some refactoring only
 patches first
Date: Mon, 31 Aug 2015 22:09:49 -0400
Message-ID: <CAPig+cQ33MXQAVbGb2c5ceQMe=CTtMZQmNWdvZfctE3QHuoEeA@mail.gmail.com>
References: <xmqq1tejuscs.fsf@gitster.mtv.corp.google.com>
	<1441068029-19158-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWb1H-0001we-1y
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 04:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbbIACJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 22:09:50 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34312 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbbIACJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 22:09:50 -0400
Received: by qkct7 with SMTP id t7so26767843qkc.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KF+qHGxJ06HSl6mFwBJgGHxg1lvyLFeXY4ikUaMuKcU=;
        b=xoSJ3XZz8m4Kvqbugtz3jh4KQms+EpYqvBmEQRBZQC1+pwgbV/66DAM12TsVOlug12
         ikdx1iObhzbS/f4UZwip2f6ZmwH0zW8e2SP8x9cGyKLVpm+iyuhbwrY+8pB6EnL1cjCm
         GOY1t5PH6GbrP6lwX/KghITAgfDO726E6mI3TjYBukBqg78bRhFB8MOmICjyX/moz7jt
         dM5K9gjXrz1gcUglh6WcQYvoDqfKSUwMBgOcy9GLA5YSNkcmNVhXKyLsepzs3zbwz4w+
         7ov6lJt6Wqh9D3h4GAWFjOHpICLXW6z0ZSyBalzZfwKY+zF4Ztzae7AFr+pkkoQzh13C
         21wQ==
X-Received: by 10.129.41.209 with SMTP id p200mr17680278ywp.131.1441073389463;
 Mon, 31 Aug 2015 19:09:49 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 19:09:49 -0700 (PDT)
In-Reply-To: <1441068029-19158-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: o4zRbVBjNLxbogKa7UUEHsYCF8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276959>

On Mon, Aug 31, 2015 at 8:40 PM, Stefan Beller <sbeller@google.com> wrote:
> * Implemented different error messages as suggested by Junio
> * Implemented all of Erics suggestions,
>   including renaming to module-with-dash-now

In the future, please include an interdiff showing changes between
versions. Thanks.

> Stefan Beller (3):
>   submodule: implement `module-list` as a builtin helper
>   submodule: implement `module-name` as a builtin helper
>   submodule: implement `module-clone` as a builtin helper
