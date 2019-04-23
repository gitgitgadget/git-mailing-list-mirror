Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A581F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 11:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfDWLpu (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 07:45:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54945 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfDWLpu (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Apr 2019 07:45:50 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id ECE7621C82;
        Tue, 23 Apr 2019 07:45:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 23 Apr 2019 07:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=p8qDIWzXV6RDqPPVTfSMhRF4PhF04eyARCwlPAeC7
        Xc=; b=dnwIlqv0sUPjGijWdwoD6kUWRVE5dcl+RkWUgQG8YawcQvPLQjdJXvHr0
        SdD8kQ0dlKi0y0Th54pFScmEw3P9J6O4wXHCZmJvRuOrfvIM46nLUhJ7QsePWjmz
        y+cu3ybdxoxNygY0ACLIPAaHD/6HqQI6V+9BPGC5K15GovralYCadRdUg17+DMmL
        Vsry8tIlYpBwlculFAQogGTdoNVlZ+K7/8Yze/keMZoL/jAXeieNL6RLP/98DJz/
        IkFpc5GLDskeUFvGZGfpmFv314ihbISE4mYKYvBRz+YNJFJGuhHJ31hxOaBe+muY
        D40airInSzH/rJTlT6LOC+oDz3rlg==
X-ME-Sender: <xms:7Pq-XO_R1hOaRXOb9HJAOdDawIi_-LddrDM-UXrLyqB4LSTtqjC_Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthekre
    dttdefjeenucfhrhhomheptehnughrvgifucflrghnkhgvuceofhhlohhsshesrghpjhgr
    nhhkvgdrnhgvtheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgrrhgtrdhinh
    hfohdpghhnuhdrohhrghenucfkphepieejrddvgeehrddvvdeirdeffeenucfrrghrrghm
    pehmrghilhhfrhhomhepfhhlohhsshesrghpjhgrnhhkvgdrnhgvthenucevlhhushhtvg
    hrufhiiigvpedt
X-ME-Proxy: <xmx:7Pq-XJYiFRy1U633a0ntuo62RlJkzPEk8u-3cUnbenfQqRNmqPZcTw>
    <xmx:7Pq-XMtH3JWTtfsgd6xDNUw3exMTb4gSRa4gjRxqjh0eCc4FHn1sfQ>
    <xmx:7Pq-XNmVZKqzr0LTYtZpGiI3T4m7hC0wgw3cpRuJlKPlL9C8H5ljXA>
    <xmx:7Pq-XGeFRTQgz2zatV2jxxF8MOVtL9GVNhYabjp0tOFjHFeiIGUHYA>
Received: from angharad.local (cpe-67-245-226-33.nyc.res.rr.com [67.245.226.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id 679E6E424F;
        Tue, 23 Apr 2019 07:45:48 -0400 (EDT)
Subject: Re: gettext, multiple Preferred languages, and English
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
 <CACsJy8C1w0zJm71KFb21MC+c2NAGnRLDtE3KNK21hO7U4Ax7Hg@mail.gmail.com>
 <9d7a2fb4-8bab-2d28-1066-fbace688a5cc@apjanke.net>
 <875zr6szik.fsf@evledraar.gmail.com>
From:   Andrew Janke <floss@apjanke.net>
Openpgp: preference=signencrypt
Autocrypt: addr=floss@apjanke.net; prefer-encrypt=mutual;
 keydata= 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
Message-ID: <0ef2b667-fedd-da66-c87a-452f70ffc570@apjanke.net>
Date:   Tue, 23 Apr 2019 07:45:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <875zr6szik.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/22/19 1:47 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Apr 22 2019, Andrew Janke wrote:
> 
>> On 4/21/19 8:35 PM, Duy Nguyen wrote:
>>> On Sun, Apr 21, 2019 at 6:40 PM Andrew Janke <floss@apjanke.net> wrote:
>>>>
>>>> Hi, Git folks,
>>>>
>>>> This is a follow-up to https://marc.info/?l=git&m=154757938429747&w=2.
>>>
>>> This says the problem with "en" detection has been fixed. Would
>>> upgrading gettext fix it?
>>>
>>> You would need to upgrade something (git or gettext) and if it's
>>> already fixed in gettext I don't see why we need a workaround in git.
>>
>> From reading the bug report, that does sound like it would fix it. But
>> from what I can see, that fix hasn't made it out into a released version
>> of gettext yet. I haven't downloaded the development gettext to confirm
>> the fix.
>>
>> Looking at the gettext ftp site at https://ftp.gnu.org/pub/gnu/gettext/,
>> it looks like gettext does not make frequent releases, and the last
>> release was two and a half years ago. Who knows when the next release
>> will be. And then it'll take longer to trickle down into Linux
>> distributions and such.
>>
>> From your release history at https://github.com/git/git/releases, it
>> seems like Git is a lot more active in making releases than gettext. So
>> including this fix in Git would get it into the hands of affected users
>> sooner. And it seems like a pretty low-risk change to me.
>>
>> Then once the new gettext release is out, their fix is confirmed, and it
>> makes it out into common distros, the workaround could be removed from Git.
> 
> What does Linux distro release schedule have to do with this? Your
> initial report and the linked-to bug on GNU savannah only talk about
> this being an issue on OSX. Is there some more general issue I'm
> missing?
> 
> People have reported issues with OSX's weird language selection in the
> past. I think it makes sense to do whatever we need to hack around it as
> long as it's some well-understood and OSX-only hack.
> 
> I'm paranoid that the suggestion of adding an en.po *in general* would
> break stuff elsewhere. I'd be surprised if the project linked-to
> upthread that used that hack is as widely ported as we are, and that
> includes a lot of i18n implementations, not just GNU's.
> 
> Ultimately setlocale() is *supposed* to be a well-understood thing. You
> set your preferred locale, programs have translations, the OS takes care
> of it. I'm concerned that us trying to be specifically smart in git will
> backfire (e.g. it's been suggested in the past to have core.language or
> whatever..).
> 
> But it looks like we don't need to go there, this seems like a
> workaround needed for some specific OSX version.
> 
> That can just live behind a flag and be detected in config.mak.uname,
> no? And then we'd do whatever hack digs us out of that specific hole on
> OSX, e.g. maybe generating an en.po *just* there, and just for that list
> of known broken version(s) of OSX.
> 

Good point. I had forgotten this was OS X-specific; Linux release
schedules are not relevant. (I don't know enough about language
selection on Linux to know if would ever be relevant there.) There's no
more general issue you're missing; as far as I know this only happens
under OS X's multiple-Preferred-languages setup.

Yeah, adding the workaround only on OS X sounds like it would work, and
would be the more conservative thing to do. Generating a stub en.po just
for OS X, and maybe just for affected versions of OS X and gettext,
sounds sensible to me.

The bad behavior is due to gettext's interaction with OS X's language
selection, so whether it happens is probably going to depend on both the
version of OS X and the version of gettext you're building against. So
if you want to generate it selectively, I think you'll need to check the
version of gettext (in the expectation that a future version of gettext
will fix this), as well as maybe the version of OS X. This
multi-language-selection behavior seems to be by design in OS X; I
wouldn't expect it to change in the future. But it seems like some older
versions of OS X are not affected by it.

I can reproduce the bad-language-selection behavior on OS X 10.12,
10.13, and 10.14.
I cannot reproduce it on OS X 10.11, which is the oldest version of OS X
I can get running these days. (I'm not sure if that's due to different
OS behavior, or if I'm just doing something wrong on that box.) All my
testing was done with git 2.21.0 and GNU gettext 0.19.8.1.

Cheers,
Andrew
