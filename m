Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB2320966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933394AbdC3PTL (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:19:11 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:64499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933048AbdC3PTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:19:10 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MMbDq-1cmUaA0jxW-008Khp; Thu, 30 Mar 2017 17:19:00 +0200
Subject: Re: [RFC PATCH 0/5] Localise error headers
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
 <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
 <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
 <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
 <xmqq1sw9piz5.fsf@gitster.mtv.corp.google.com>
 <20170121142048.ygbwc65un4whhtwn@sigill.intra.peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <76f61fea-3d24-ec55-0cbc-64ee3d030dcf@grubix.eu>
Date:   Thu, 30 Mar 2017 17:18:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170121142048.ygbwc65un4whhtwn@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:pgP7JAqeQS0n3TDrdK4qYTYbK+ghpWLDeqhX7Fz7UHQBdIZlVBh
 zNU2wqS/bRwNXcxCLFlH7MHQ2ciZ+BF6kBB1JNzu9NosAlYbpPvVH782AVMxT+nH5pyH7Wz
 AarHuWtAJDqWPQCUZE8CHsT7O2sxmoPXLqrZrpfOIvIbyiqFpYaFYsUJIA+rSSDqq6u+T8o
 NyccIf0GEHMLQhIiQl9HA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:65eYH8tVLwc=:enlraWWHvTHuuqESPShj9b
 EqdqVGTDLnFht6Oo1zdRUV+EmetGVWHMckC8HhzpWdTK2VjL44e9RlvTUzUpvZZz/wL+a8qWG
 zmaD1OLeil8CDcB8j/Rj/mBgMiFs1S422XBqA4g0VvpowrWz4VMwGUTg7lILTHD2U5XpRjOsU
 yYOdNlpmQtDgoM2FTKZUSQ8WSuQW4o0KmS2eMas03bTqragQAbpLPlbMLcIDgt90BBuhqUhae
 uHe57FNkS4ftNxXSo5yFfX8ujMwpX4cg7sO6AMC6znukG1NJtb1zYj2NrEpURsvc5P8XMM8r6
 reGGafyiuicrTu8scP45P4ecgk3zmc38IxMpOxxAZkhkxlIX5QpniGOFdX+6sU/pSWGl+0rYM
 rmrEztE1Cvm/6msP4oX1JvzPp8rvlKhJMMLXffaQ89vlDl69hj9YtJQYcNg05kthMLuxlA9qx
 Uthd/QdAC+q0rcjNIjtnBxQ+q40VXJWMtu1WNQVtCnEVtX0IvWh95u3cZA8cwiJMMhfZe+vZK
 rpY1nve7eqXk3BfEIyzJhpNPEj5mHyGO1XTj5wHLJDrXU2p3vKuc4Td+Wr9NQlAtRZ1kO5NeW
 LF4dUJ+Xs1P5AiXyu1d6bqKRiDrfZEuJcESuSs9vyiMbU3v+nQ/cEt6YQuLeo+EFcBessyJ6u
 oK7dsxrgiASe+PXYV+iI5t+aEEdCVxPniVBnuvAIyzBz6K3jHVkYzDFiyFCAXmoqti7ZgjKWp
 tQtW7c0rcbA7l/gD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King venit, vidit, dixit 21.01.2017 15:20:
> On Wed, Jan 11, 2017 at 10:08:46AM -0800, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> Yes, I would think die_errno() is a no-brainer for translation, since
>>> the strerror() will be translated.
>>>
>>>>     apply.c:                die(_("internal error"));
>>>>
>>>> That is funny, too. I think we should substitute that with
>>>>
>>>>     die("BUG: untranslated, but what went wrong instead")
>>>
>>> Yep. We did not consistently use "BUG:" in the early days. I would say
>>> that "BUG" lines do not need to be translated. The point is that nobody
>>> should ever see them, so it seems like there is little point in giving
>>> extra work to translators.
>>
>> In addition, "BUG: " is relatively recent introduction to our
>> codebase.  Perhaps having a separate BUG(<string>) function help the
>> distinction further?
> 
> Yes, I think so. I have often been tempted to dump core on BUGs for
> further analysis. You can do that by string-matching "BUG:" from the
> beginning of a die message, but it's kind of gross. :)
> 
> -Peff

I read back the whole thread, and I'm still not sure if there's
consensus and how to go forward. Should we let the topic die? I don't
care too much personally, I just thought the mixed tranlations look
"unprofessional".

Michael

