Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981D01F404
	for <e@80x24.org>; Mon, 18 Dec 2017 02:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757872AbdLRC6m (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 21:58:42 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40005 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757685AbdLRC6m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 21:58:42 -0500
Received: by mail-qt0-f194.google.com with SMTP id u42so18428223qte.7
        for <git@vger.kernel.org>; Sun, 17 Dec 2017 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jUXkYJtwVMkuPpOxMaSNblOfXyisP+VkjRbaEVq74ag=;
        b=t/+gYCZNS0kmq+jYA2Mo86SyZ+S6v17jrXIKHDvkKa7FvZL/DBCItFNV5KzOFj+S/C
         FJuWzM5ijh2tENIxNH0DqICCHzUbmwWMHH6TF3v/RNtipDJwnB9RM7HXMx4VUhMeRnD2
         68t9UG++dgjzaMx6myJRdvwlOUD2ma6J4aMgALG1o8NQZCnxDzCiPgeRzdxK400PpsGn
         SVpZhy+wkjZGbvI6rmCqHzuSdzMSKFRH1vecq1/QdyRvzNI/JHx7wt0DWRX4yhXEcKqM
         GMO8Z9GJ0RZThKqgOEVtvNDRqC26Zmy85eiTeOXC/Z4DmUEpWcYfKfNrUSG2MV0zN3xX
         /QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jUXkYJtwVMkuPpOxMaSNblOfXyisP+VkjRbaEVq74ag=;
        b=it2YcIJL2g+jOP+IAFGomCvbLUKBrdhYc9geZfSPF9BH+Osb/U5sbZVmyjthvxXXnK
         cVdcvbb9MXFjbEK8EDF6/FMLejZkk95gs33yHRHs0cenjKjxgSx862h84Xus8QROkfuA
         J4TKcqEz3yEwGNFGG2L7TJr02BF8J2qW7ahfLIYX4FlTjpq3JezW0i74mrcB/WtuBkgK
         21qEeNIrZjV0CU428AYkTnKshhJbDoo4NjbosKu7Rxs/jjyDrAqb/Am+8XMgJfXbKP+J
         M7Prtdo17GMPWyi3WKs6LpQsOAr/jDdk2qlc0lGNdUq4zLjkFW1JanGsVLamgBcKxKjc
         pF9w==
X-Gm-Message-State: AKGB3mIrPiiQeRWDZVBwxwW0AMAMRTEAsxIjwsZkHejgzfr5Qam43G/k
        3vSkbIg1lgqsZKba+b6YVjWBHxWx3B00sj0ZZWM=
X-Google-Smtp-Source: ACJfBos3xy4wS9J+PovGFryCUTwmd2Z+X4+9094m8AxEoJU3nfPjYeLDeVhZG6swBvVOZWAzRy6xZMKGoyUPUFJUs7w=
X-Received: by 10.200.35.28 with SMTP id a28mr35628064qta.51.1513565921444;
 Sun, 17 Dec 2017 18:58:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Sun, 17 Dec 2017 18:58:41 -0800 (PST)
In-Reply-To: <7aff934e-c26a-8259-17e0-436104f377cf@urbanec.net>
References: <20171211004848.13048-1-git.user@urbanec.net> <7aff934e-c26a-8259-17e0-436104f377cf@urbanec.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Dec 2017 21:58:41 -0500
X-Google-Sender-Auth: 0CSoAnnqiQCWc1sb67nq83lwP8c
Message-ID: <CAPig+cRSPyR9dwbA7rHhYGorKQFr2Kh64PQtgQK3nxoQXvUGhw@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Make push remote combobox full width
To:     Peter Urbanec <git.user@urbanec.net>
Cc:     Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 17, 2017 at 8:49 AM, Peter Urbanec <git.user@urbanec.net> wrote:
> Just wondering if I submitted this patch correctly and to the right place.

You sent it to the right place. Unfortunately, Pat hasn't been around
much lately, so the git-gui project is apparently slumbering.

Junio has accepted a few patches for git-gui recently[1,2,3]; whether
he's interested in doing the same for your patch is unknown.

[1]: https://github.com/patthoyts/git-gui/pull/17
[2]: https://github.com/patthoyts/git-gui/pull/16
[3]: https://github.com/patthoyts/git-gui/pull/15
