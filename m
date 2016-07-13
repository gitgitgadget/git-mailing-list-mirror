Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD6920196
	for <e@80x24.org>; Wed, 13 Jul 2016 21:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbcGMVHu (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 17:07:50 -0400
Received: from mout.web.de ([217.72.192.78]:60519 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbcGMVHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 17:07:49 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jul 2016 17:07:48 EDT
Received: from [192.168.0.100] ([138.246.2.138]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MfYn9-1blRWh2BDP-00P1h9; Wed, 13 Jul 2016 23:02:12
 +0200
Subject: Re: [feature request] Warn about or prevent --amend commits that
 don't change anything
To:	Junio C Hamano <gitster@pobox.com>
References: <d2c3365d-6da9-dd58-ae7d-4a2020c6b513@web.de>
 <xmqq4m7t1h8v.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
From:	Bergi <a.d.bergi@web.de>
Message-ID: <ef62d73d-ec85-993d-7bdd-d8214a55699a@web.de>
Date:	Wed, 13 Jul 2016 23:02:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqq4m7t1h8v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qRvJLKz3AuOrhaxUbLSndOvfdHDJmZ8dOH4pNi6d0Zgq8wbDDGk
 PM0v9cJzGoUyahKpBE2a4/eBW5Vv1W3E2jp0Y8w1nu3u2mWG+3JPMiR+2caEOxvTr35hUmj
 sATYa1WWjBcsZTN14/zEosbeMr9NyUlkkrcWGXuN5J7yGLkMC/LnwUqT46+HXFeUoKv3QPG
 9z4uHBcBBIqJrh+mW73QA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7xdm9UaMj+M=:C6nJLeGXPb7JiN4mIpvAKZ
 JmCm0WEa/TBtDU1/s/eeWPO0Upfmym/ijalMrhRsz0LQ21gsU7Lm7ysqNPXTET3i/Q4+dnvFv
 ZTExc4K71IFcQYwUQJemcfUpXQhB9SMxkeSrGpppklnxADDNlp4JpDtoUTThvx58Ihu3PqFn/
 tXTQIkKVO1pO4pc5vg4wI8feFF1t5zIB7iVUtJ0IRzDNYsG4qyXwE3KdRIKXr0HtVs2h8ybBQ
 vObtDphAiIHD+EsNhMnxkAKqHLKOdoVScfQhScdeR2Ns7+0Drh+4n2b0x/pu6z4zJKRwcqATr
 o6nJ1dsCsu9N4N1FheZTtmSG0QhTljigO1fgF+9UvntKJ/YlWG+rNMp6KoE6DboWC0ATsHfMN
 5cUVZ8ZdKRsNqNZgWASdSD5THjKFrBLuAiixBQ460ZR/FurdBbWtyl+s6HJyJWXGIrwxSBcmQ
 Um7/pLIFldPjpenZm5J2qltcyrj6wbb28QQjdXabEu2jj1BwfolzLo1kXJjpNg2o+arTXftCM
 82Tz4AiE3uvPe2vXwC431bgyE1tPu4fOP5VQTpsJYtyqbx4s7qIKRvVaqnKr5UjzBQk7EHkeV
 LXwuCDqKPCjCkqj2sgrqtEWrHXI9e9ggZMzse8eXDKA8M55WcKqZQqidu7QThNL/hMgvhTtRJ
 rbuhZW5bdWJbCPsL6rup3ayd/ttLpY2XEvsdUFOlbSJADX++EPTlYQCITCddXzy5Rez7gBWCE
 Z6sFzGze4EPqxmwKhE6DOjIIvGi2JFCUbx36BOVjLEFhihkln/vKj5rERGUdNypFznKc756Iy
 AQZJkK4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano schrieb:
> Bergi <a.d.bergi@web.de> writes:
>
>> when nothing is staged in the index then `git commit` warns about this
>> fact with either "nothing to commit, working directory clean" or "no
>> changes added to commit".
>> However, `git commit --amend --no-edit` will happily record a new
>> commit that differs in nothing than its commit date from the original.
>
> What kind of "mistake" are you afraid of?

The particular mistake that happened to me was that I `git push -f 
origin`'ed the newly created commit (which worked as expected, 
overwriting the original commit) and then leaving my PC in the belief 
that I had successfully pushed my changes.

> I can sort of see that "git commit --amend" might want to see two
> summary diffstat output at the end, unlike "git commit" that shows
> what changes were recorded relative to the parent.  In addition to
> that "final result is different in this way from the parent" output,
> you might also want "this is the change you made by amending" and
> knowing the fact that you can notice you didn't add anything by the
> latter being empty _might_ give you an additional peace of mind.

Yes, that would be incredibly helpful as well, but is not what I am 
after here.

However `git commit --amend` already shows me that I still have "changes 
not staged for commit" when editing the commit message, so that would've 
been enough for my use case.
The problem is that I used `git commit --amend --no-edit`, which did 
neither warn me about missing staged changes nor existing unstaged changes.
If nothing is staged and the user does not intend to edit any metadata, 
git should be able to deduce that the user (me) did forget something.

> But is that the kind of mistake you are worried about?  IOW, you
> thought you made and added changes X, Y and Z to the index before
> running your "commit --amend", but you forgot the "add" step and did
> not add anything?

Yes, exactly.

> If so, […] your "you need --allow-empty if you really do not want
> any changes to the tree" would not [help much] either, if you added
> X and Y but forgot to add Z.

A good remark.
Maybe in that case it could warn about unstaged edits in the case of 
--no-edit but still succeed.

> So I am sensing a slight XY problem here.

That might well be, I'm just here to tell my story, it's the designers 
that need to decide at which step I went wrong and which parts could be 
improved.

Kind regards,
  Bergi
