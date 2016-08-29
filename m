Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BFED1F859
	for <e@80x24.org>; Mon, 29 Aug 2016 02:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756206AbcH2CSH (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 22:18:07 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:36789 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbcH2CSG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 22:18:06 -0400
Received: by mail-yb0-f174.google.com with SMTP id e31so43794121ybi.3
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 19:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rq6EpP3JS1bdLrT9StxoVTC74E5mqNfbndfWgaMsahU=;
        b=d+wQXqG3cSwYwsfR5MMXJUsx8WJcA55781Z6XHfnGgoYgd7MSi9hPIpIzmTZxtkiOW
         aitfVHVeppU4vrrY3yqNi5CLptSfacwBfQb+EggZZQOUIhu+lwchdzMfoLi5u2nAormY
         K+iIP4bK6iGSJCXL0W8V42QuyvjQenMsEJLR5p638dhRdIYnCwZJ1fKu71AruGQWppGT
         duqvHCE9a5Z+bqkFV1CqUxj5SNtWHmxEsk8RkL1GQy0ZPKQdxcv10/fCB5boYtVEl+Fz
         F0/25b3tOGdc/2vmf/OE6J1Hl97kVlljtZIgDLFm3pWZF33UoXyGRua2FuMfSPxVbyLl
         6OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rq6EpP3JS1bdLrT9StxoVTC74E5mqNfbndfWgaMsahU=;
        b=DFcuZ49DSRzVAJuUf0VtBQkcGRmQjF5vycHGDWq8qnsSjAv5YVBxPX4Xwz2B2Hm+wP
         PSECnottGzxRt8BdaXnQczEPRkotR7BhyVxg7LcnzPtIuYx6hG6X1zQRkMjvqz+q7xNT
         pT8wPgZXOemGAtsND1DyrnoIuQySIIbHgC7bbrN7bWbMDvwTcCX9FxIiUixPSyK3rec/
         oMWkD213nCdPEvn1KL72BlljH1Bger9o258pody6aN8bX4eTDnB5AHWKo0+PTLzxs7d+
         c2SiHRkjBlJKbmjVCoinI7zcZYHV0p8KMOn9w2Q0yXkGBj010pRiV7wi0JjHl9V26K38
         PRdA==
X-Gm-Message-State: AE9vXwP431XC5JvYQH6ZONfKWzON4h0TTsp09TQbIEi3QmHH+na6E5czq6bqfbD3qXEHiL/z7nRnR0lji4vuQA==
X-Received: by 10.37.197.211 with SMTP id v202mr12661073ybe.15.1472437085789;
 Sun, 28 Aug 2016 19:18:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Sun, 28 Aug 2016 19:17:45 -0700 (PDT)
In-Reply-To: <51671371-C59A-4304-99B2-B2C2256C4001@student.ethz.ch>
References: <5EA7D232-5D41-4653-9E35-21C502C79C92@student.ethz.ch> <51671371-C59A-4304-99B2-B2C2256C4001@student.ethz.ch>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 28 Aug 2016 19:17:45 -0700
Message-ID: <CA+P7+xqA_3a8EPZ=2Y5pgkL+N=_F1v5pfyzErwest9aoKZC37w@mail.gmail.com>
Subject: Re: Feature Request: Branch-Aware Submodules
To:     Hedges Alexander <ahedges@student.ethz.ch>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2016 at 8:12 AM, Hedges  Alexander
<ahedges@student.ethz.ch> wrote:
>> On 25 Aug 2016, at 19:45, Stefan Beller <sbeller@google.com> wrote:
>> [1] https://github.com/jlehmann/git-submod-enhancements
>> which has some attempts for checkout including the submodules.
>> I also tried writing some patches which integrate checking out submodule=
s
>> via checkout as well. A quicker `solution` would be a config option that
>> just runs `git submodule update` after each checkout/pull etc.
>>
>
> I see. The quick fix is almost what I=E2=80=99m looking for, except that =
it leaves
> the repo in a detached head state. Could the submodule update be made
> automatically and intelligently pick the branch?
>

You probably want "git submodule update --rebase" or "git submodule
update --merge" See git help submodule under the update section, or
even a custom command variant where you can write your own bit of
shell that does what your project expects.

Thanks,
Jake
