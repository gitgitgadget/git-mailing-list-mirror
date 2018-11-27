Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98FA61F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 23:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeK1Kgk (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 05:36:40 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39427 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1Kgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 05:36:40 -0500
Received: by mail-ed1-f44.google.com with SMTP id b14so20522243edt.6
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 15:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vAJpT/Amc2fZjrhgK72JL6hvQ+duqjksEVSQEYwg7O4=;
        b=qeo4yYB47MXbRfZyzoq171JDokZ5LNHWah24HF9cnJm70Ln3J7YhUbI2TXnFZG2wFy
         kcT2dIWg98BLQSuwdS7yI9y9DPdya9YqwV4kdhu1sXK65d1xg15Gelmq8yH9+MIy8i+R
         GHT3O85fXp/KO5omHsZ49li2GyyNtDMfC7Z0HNABg8lHF4lt+2bvUT0egNif320ay2v6
         b9S5iQj5ExQ0W2YLmdkzbxVkmq1kK7GyOLqHvhy9mjWyWgG0P0ImrZiHVhVK0mhE/t08
         FBeNrLU7A1SqXnUx2o9JsWk2k11Fh945QXij8o2R7DGnBElTn+I43CTkCMFckpqC1j0d
         igYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vAJpT/Amc2fZjrhgK72JL6hvQ+duqjksEVSQEYwg7O4=;
        b=uB24dspTBuP+U9w4Dl+i7+kyotkQQgPHnQAvqqEm8Qtt6tbSGlXxApZeq5UcltSqkW
         Gbjxh56KSqlhBFdfkYxVwBF+CO8coFs7BFM+nuM86lRSlZ5caXwYzSeC0QkgQ8W6CP0O
         poWVkj74/8V4qaZXh8OOxrTEpZYSaACj8Pwg4RMT0TVwG12OzIS7eFzuqB68P8rMUKKQ
         6CBclNs5r2ZmttnRquXpv9D5cql/BdfFaMkLdr6H6v4A7l9hCBIAdJKH9JRZmWX2S7QV
         vgvO+KCjebTVBBy9AR/8toOfKE59KLCNSLdjpJmr/wUDaoSf783Dxo4a8vqw5tocva+d
         gvqg==
X-Gm-Message-State: AGRZ1gJXYa3pRfnvOvYRZfkzQD2+FVuij7UPral6e5EuYEMHKr+fQBxv
        mWDBapVjmeX0bNujee2m1XALtOlD
X-Google-Smtp-Source: AJdET5dmwcVo8XODc/Q5hOCzIWuRM+u/v7K5D2r+yV1ESTIcOb4iL8RLlZitJGkl2JtWgkwgJGiPlg==
X-Received: by 2002:a17:906:5202:: with SMTP id g2-v6mr25089620ejm.139.1543361826318;
        Tue, 27 Nov 2018 15:37:06 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id t26sm1382155eda.22.2018.11.27.15.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:37:05 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Will <william.duclot@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: Git pull confusing output
References: <758FA299-0842-4462-8CF6-D7210D26A6C7@gmail.com> <CAGZ79kbDHyzFF-HtDcD=rOLZB+RFRnVqZgXb9uwm=9_m-6E0QA@mail.gmail.com> <1A9DD0D0-A1CD-44B8-A44A-35D795DA18D1@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <1A9DD0D0-A1CD-44B8-A44A-35D795DA18D1@gmail.com>
Date:   Wed, 28 Nov 2018 00:37:04 +0100
Message-ID: <87h8g2ytwf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 27 2018, Will wrote:

> On 27 Nov 2018, at 19:24, Stefan Beller wrote:
>
>> The different phases taking each one line takes up precious
>> screen real estate, so another approach would be delete the line
>> after one phase is finished, such that you'd only see the currently
>> active phase (that can be useful for debugging as in "The phase of
>> 'Writing objects' takes very long" -> slow network connection).
>
> I like this idea
>
>>>> Pushing to github.com:williamdclt/some-repo.git… done
>>>> 1ca9aaa..4320d30  master -> master
>>>
>>>
>>> I’d be more than happy to work on this (`git push` is an example
>>> amongst so many other), but want the mailing list’s opinion on it. Am
>>> I wrong in thinking that this output is not something users want, am I
>>> fighting windmills or maybe just being ignorant?
>>
>> I think this would be a useful patch, but it could get complicated
>> quickly: push uses other low level git commands to prepare the
>> packfile to be sent to the server, currently it only needs to pipe
>> through the output of the low level command (or even have the
>> low level command directly write to the terminal).
>>
>> The output of those low level commands should not be changed
>> when run on their own, I would assume.
>
> Agreed. I didn’t expect it to be so subtle, but I’ll look into it
> and see if that’s something within my reach.

It's not *quite* the same topic, but a related WIP patch that got
dropped (and it would be great if someone looking at this area could
pick it up) is
https://public-inbox.org/git/20180902085503.GA25391@sigill.intra.peff.net/

I think it's also worth looking into making the progress code able to
emit stuff like:

    Counting / Compressing / Writing objects A% (X_1/Y_2) B% (X_2/Y_2) C% (X_3/Y_3)

That would allow for splitting up some of these cases where our progress
bars are overly verbose across multiple lines without losing info by
completely erasing the line, and would also support other cases where
sometimes we do this stuff concurrently. See e.g. my recent commit-graph
progress patches for something that would benefit from this type of
thing.

It would need a patch to the progress code to make it able to juggle N
number of progress bars with some format to stitch them all together.
