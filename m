Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD711F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbdFINaU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 09:30:20 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34434 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdFINaR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 09:30:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id v14so7702229pgn.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NPzRRMXcOGm+0+XmKA1SQuk/ESuA++oLe9YIbQALS5I=;
        b=Hp2pKql7p1TgD+1aQAiYZlNEt6KxxacR/4X0uf0hsUhTQs5nxa3Ny0G7un7n0MYIJ9
         u+418i7C3WjKZSVt/Q9rwK71FyF2Q2kRQ161cOyPX6dAzlg5ucMFA1euIiGCrI3Zz91+
         thQO6+O+AOUiatYd2QeIl6hqNp80HdnDfS5h2kFZSrqCckEAcWde/I4gBnB4kvP9p5gD
         JeqfnFN1sbFsMSOdxsyKWgmdCrAzG6RoH1Q/xbq/nBlXHW2dztBqI3q0HJv1W1hO42+X
         aQ2cB+XtUQQzS/JYHnsldUqjw1GC4yYyS88zA1hCRTR5xJglrW72+pU8HUFLK49AiW/N
         PULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NPzRRMXcOGm+0+XmKA1SQuk/ESuA++oLe9YIbQALS5I=;
        b=WpmUBK1/BZ+ucm1Octe6rSBOGeNWETHDLtLhT3rZoshzIoAvrhmqx+lRH/7AFAFZSB
         GhyAmh7rDO7OaW9YuS2dCZV6oy6/uF1dbsE6N5T69uK/4vtIvifYaM1yLbGx35fbbMan
         +m6HbFnRt7WJO0XvbpibaB663StPSISmDVNd0NCb0U3LAj9y6GcoZE+ppNP0UkHqH2Xw
         VLH/dZ72ptxj8Et7xhwVX43xxu9Xki1n6wyQ8gT4/1eTiKcVeGSG+Uq4WTXj1tJahcyi
         +Rpdu2TMV9nGhv4spn3QXk9Wqk9gfn1I5lay2eu9M0Drps7AwWWD3X7CviX+58NGtlSX
         KhAw==
X-Gm-Message-State: AODbwcCZDu9SoFgn52bzjNrhOU+wZgYQuPxjxnqoqe6/ZFzKvR4YNOFT
        faY37tcUUKwBBg==
X-Received: by 10.98.107.129 with SMTP id g123mr42288995pfc.219.1497015017191;
        Fri, 09 Jun 2017 06:30:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id e18sm3359874pfk.118.2017.06.09.06.30.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 06:30:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        =?utf-8?Q?R?= =?utf-8?Q?en=C3=A9?= Genz 
        <liebundartig@freenet.de>
Subject: Re: [PATCH] docs: suggest "Helped-by" rather than "Thanks-to"
References: <20170605105341.35096-1-adam@dinwoodie.org>
        <CAGZ79kYZ2yTHxxRUjFZpFWsOWwmh6RBXRd0_a1K9kMTo4exD6A@mail.gmail.com>
        <20170606125743.GE25777@dinwoodie.org>
        <xmqq7f0o8ywn.fsf@gitster.mtv.corp.google.com>
        <20170608084324.GG25777@dinwoodie.org>
Date:   Fri, 09 Jun 2017 22:30:15 +0900
In-Reply-To: <20170608084324.GG25777@dinwoodie.org> (Adam Dinwoodie's message
        of "Thu, 8 Jun 2017 09:43:24 +0100")
Message-ID: <xmqqbmpx70go.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

>> Thanks for an interesting list.  Your replacing (totally
>> unconventional) Thanks-to with more common Helped-by is certainly an
>> improvement, but I wonder if we should encourage people to be
>> "original" in this area by having that "You can also invent"
>> paragraph in the first place.
>
> I would expect we could never come up with a list that will cover every
> possible scenario. I suppose the question is whether it's worse for
> people to feel like it's encouraged to come up with non-standard options
> or for them to feel they can't deviate from a given list if none of the
> available options suits them.

I do not think we want to even aim for a canonical "this is the ones
you must choose from" in the first place.  I felt that the current
text overly encourages to be "creative" there.  I am wondering if an
update like this, that explicitly says that "Helped-by:" is the
catch all for other kinds of help, would be sufficient?

 Documentation/SubmittingPatches | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 558d465b65..b49372b875 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -305,7 +305,8 @@ the change to its true author (see (2) above).
 Also notice that a real name is used in the Signed-off-by: line. Please
 don't hide your real name.
 
-If you like, you can put extra tags at the end:
+If you like, you can put extra tags at the end.  Here are the ones
+that are commonly used in this project:
 
 1. "Reported-by:" is used to credit someone who found the bug that
    the patch attempts to fix.
@@ -317,9 +318,11 @@ If you like, you can put extra tags at the end:
    detailed review.
 4. "Tested-by:" is used to indicate that the person applied the patch
    and found it to have the desired effect.
-
-You can also create your own tag or use one that's in common usage
-such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
+5. "Mentored-by:" is often used by new contributors to give credits to
+   a more experienced member of the list after privately getting help
+   polishing the patches from, before showing the patch to the list.
+6. "Helped-by:" is used to give credit to others involved in the
+   discussion of the patch in other meaningful ways.
 
 ------------------------------------------------
 Subsystems with dedicated maintainers
