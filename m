Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B082200B9
	for <e@80x24.org>; Mon,  7 May 2018 01:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeEGBfT (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 21:35:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:35069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbeEGBfS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 21:35:18 -0400
Received: from [10.40.94.26] ([209.226.201.248]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2t0Q-1eMyzS2OQg-00sfwT; Mon, 07
 May 2018 03:35:01 +0200
Date:   Sun, 6 May 2018 21:34:56 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com> <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet> <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UsduLCSlLVIi0QpX7tqL+x/ZtI7CWR/ukdBOzCYeGm1cciTP+ie
 2ul/+W3VHj4L2G0mwOWchF9m22oHFguMv4hBB3rgop3wLw+H1nGZPjro/k8/ysAUSTqEWQA
 1VxqT97gngbojPs2LLnxTeKczInCfjZ35YIJstmHcb37tm6M/E/NwQPytm5VQSzQFbydjnA
 Mm6f3n2rz68RbYKHbPT/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OR2dI7tMqQw=:tRyCRysk8P0xrkwQQS2xs9
 7iF01whYKnwkQcoM1u7F6QBzMSZXpughw/CPzmgYglnp9PrqRtYZRGIJexfTcb1F2f9LgZyUA
 u1BWT2KLm5cp0RQiQkTE7T9ULDzSYUh7HvfCjUO67rW9ku/Pliik2u/FtuxVW2/OEcKh3qapu
 Idj3Dw+5/6VUX/nhtxHaEmbsyjpwXyx0qG0ho5Z2c7p9HLf8HL7AZLFwcLWTZUqRt4tKu66Ta
 89aX3JVDCxz5LyjjkIQxwGlk+umNZRqFOUFlkGHd0UJKQaoBmARYY6M9Xd4RyjrrJB6cQIEIA
 Ig+YIRJf5jhV9s+M25cgDQ5ZHCxNyaEDNphca0igxYtqp2FU8qKDp3rV3yJ5mKHhanUrXSsEz
 z4exvXy6o1G3AWZ7wwcdkjp7qaum/FtWMC/Afyq/CqgiTcV7+j23TDsUMlm1D+2Iqk3Gbe18t
 3XEWCeOY8KehmBQ5tlo2K1NUar4cm0oanYKWwGiMIcW1eijN9a8cLCZDuICV7rV6JPOLCvw7O
 jn/SvVttyh6UUsBUWGs/4NO4UcEtt/dI5dtQP7Wy7xhcmzuigNkFi92dWmcQMOJd9wEXFLiia
 IhgjfTu6WudGTlo+BuwLYYooUDl4ZjIXgpCu+PtfTOyTw5sn8Xg76jKRN80Q9+yzWa2jsg014
 gcCmlES69S9RwGaqNGLEX/FeJWORCTX+OXDfUAZ0ivtgbqhP22sLRAn19njbiA9ne6qgFNOe6
 BNeZ/ixrRZrmo9seHQDoSg7SYFIlZgO3BMlR7s+iy/WiaNxqjOY5BxkcEiTpYzUGs5wIpWaSG
 X6NObWv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Sun, 6 May 2018, Igor Djordjevic wrote:

> On 06/05/2018 14:10, Johannes Schindelin wrote:
> 
> > I think Todd's idea to shift it from a full-blown builtin to a cmdmode
> > of `branch` makes tons of sense.
> 
> I don`t know, I still find it a bit strange that in order to "diff
> something", you go to "something" and tell it to "diff itself" - not
> because it`s a weird concept (OOP, anyone? :]), but because we already
> have "diff" command that can accept different things, thus just teaching
> it to accept additional "something" (branch, in this case), seems more
> natural (to me) - "branch diff" being just another "diff" mode of
> operation.

You also have to call `git branch` to list branches. And to rename
branches. And to delete them. So why not also compare them at the same
time?

> What about that side thought you left out from my original message,
> making it `git diff --branch` instead?

I really did not like this, as all of the `git diff` options really are
about comparing two revisions, not two *sets* of revisions.

Further, if I put my unsuspecting user hat on, I would ask myself how you
can compare branches with one another? That is what I would expect `git
diff --branch` to do, not to compare two versions of *the same* branch.

So `git diff --branch` does not at all convey the same to me as `git
branch --diff`, and I find that the latter does match better what this
patch series tries to achieve.

I briefly considered `git branch --compare` instead, but then rejected it:
it would again sound more like I try to compare two separate (and likely
unrelated) branches with one another, and that simply does not make much
sense, and tbdiff would not help with that, anyway.

> But if "branch diff" is considered to be too special-cased mode of
> "diff" so that supporting it from `diff` itself would make it feel
> awkward in both usage and maintenance (in terms of many other regular
> `diff` specific options being unsupported), I guess I would understand
> having it outside `diff` altogether (and implemented as proposed `git
> branch --diff`, or something)... for the time being, at least :)

The branch diff is not even a special-cased mode of diff. It is *way* more
complicated than that. It tries to find 1:1 correspondences between *sets*
of commits, and then only outputs a "sort" of a diff between the commits
that correspond with each other. I say "sort" of a diff because that diff
does not look like `git diff <commit1> <commit2>` at all!

So I think it would just be confusing to add that mode to `git diff`.

Ciao,
Dscho
