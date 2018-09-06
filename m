Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CBF51F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeIGAIO (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 20:08:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:41707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbeIGAIN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 20:08:13 -0400
Received: from [10.2.0.3] ([217.235.91.60]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Md3li-1gGDdS0ttK-00IFHR; Thu, 06
 Sep 2018 21:31:12 +0200
Subject: Re: [PATCH v3] Allow aliases that include other aliases
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, pclouds@gmail.com
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180906101658.1865-1-timschumi@gmx.de>
 <20180906145942.GB1209@sigill.intra.peff.net>
 <xmqqy3cezcz5.fsf@gitster-ct.c.googlers.com>
From:   Tim Schumacher <timschumi@gmx.de>
Message-ID: <4f814d67-c384-6d1e-a988-97cc25e32475@gmx.de>
Date:   Thu, 6 Sep 2018 21:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3cezcz5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NLS6sXAksTcYdDlphe7BD5z/dt7E4xgI2QF7H2j/+hzVcmKhMdv
 EZibJGNAz/15d23W7+a21cqi4ROGj8LMOOQYpVkBGewOn879+HAu5QppE/LC5l/KEzTsi5w
 9fPSc4KYThj95Yhb070QlqD87olg5+Ql9ILv+hDamdYFeV6SfBUxGRzdJaS/vhu9Mn3hglU
 lcP0kuxn/Wd+3JJcgEJ6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fRaj5HYQoNc=:BOpLXzG9Q/UySq9nLafQsB
 uA4Wyxba0JfnMWa8mHGh4LWJxGfEsYIcLUJcGkV9hZFkoRJVs7kSkr3Vry0D8bv5fLqxsY9hj
 jelYO8v2iVudmVpOoVa+gpG4PdZZ4l+rCHJfivti9U7Xe5JrQhLbmCbIrwMU8M3cDMy1osaRA
 Idb2HS+ky7c1iBLeueZpf7Ah1LnOSQlCGBgh5UL0AGw639axzIjc9xFv0QBawFv1+AD/3fnmZ
 ddiYhCBJvLKk3G9L04oV09FIs3v89R+aGYkm1XVuDlOjJ+xJF8Ug04tiyIaUhbRl3a5XgMipW
 6Ee9GJH91lF+PGonWGDYs8iY4fi9P3fkKPdZ4HII3MKdnFaDLl1wkvragXt68o4wvS4XYcsKe
 fqc/iAXilNlxiPyHHwCCnp7hYL8Wfsp70UVmtE5iewTuamWOSppq9Cc02zGuVFZvs1VCRMwie
 C/EQbaJF/FCxNXLWpsNx9dhNtpkGjIv8DXiv1Dqo8rnOlsXIiZYOKOBdI36mYvuDagocDBiwQ
 wQcVg72ro5lnfoTd82Zj+sM0ZD4mOb4fVllP8ayU5n0gnIFkDMi2fo+mqZGBi2OVSUmY4TtT5
 mrK6/aJpj0MWMjIjDMkJ7YGJrKBR8bhHlwDLr5DRi3/jx6+g2GxN/Vzwi/fxZaM0INzozbIQa
 zZBSTXDRmWFovvh9gwSyE80Kyj2rWnqZYL4OyT1H/GKOO8SbASMwKRb4AkcIFiHfm0nuBtQcw
 fQVb2oDwk54rlrpotPaRt55405ULCj2Wf/IAYWTsG7d88VrlETxwtrb6ZGVK2cL45REIU358U
 lRidVH6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.09.18 20:40, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Thu, Sep 06, 2018 at 12:16:58PM +0200, Tim Schumacher wrote:
>>
>>> @@ -691,17 +692,23 @@ static int run_argv(int *argcp, const char ***argv)
>>>   		/* .. then try the external ones */
>>>   		execv_dashed_external(*argv);
>>>   
>>> -		/* It could be an alias -- this works around the insanity
>>> +		if (string_list_has_string(&cmd_list, *argv[0]))
>>> +			die(_("loop alias: %s is called twice"), *argv[0]);
>>
>> I pointed this out in my response to Ævar, but I want to make sure it
>> gets seen. This call assumes the list is sorted, but...
>>
>>> +		string_list_append(&cmd_list, *argv[0]);
>>
>> This will create an unsorted list. You'd have to use
>> string_list_insert() here for a sorted list, or
>> unsorted_string_list_has_string() in the earlier call.
> 
> Correct.
> 
> Also, normal users who have never seen this loop that implements
> alias expansion would not have a clue when they see "called twice".
> 
> I actually think the caller should also pass cmd to run_argv() and
> then we should use it (and not argv[]) in this die() message.

Could we just save the first element of the original argv for that
purpose? Or alternatively, use the first stored element in the
command list?

> When
> the original command was foo that is aliased to bar, which in turn
> is aliased to baz, which in turn is aliased to bar, especially that
> "git foo" invocation was in a random script written six weeks ago by
> the user, it would be a lot more helpful to see
> 
>      "alias loop detected: expansion of 'git foo' does not terminate"
> 
> than
> 
>      "loop alias: bar is called twice".
> 
> given that 'bar' is not something the user called, or written in the
> script she wrote six weeks ago.

Indeed, printing the command that the user called is a better message
than the command that is the entry-point of the loop. I'll change it
in v4.

> 
>> It's unfortunate that string_list makes this so easy to get wrong.
>>
>>> +
>>> +		/*
>>> +		 * It could be an alias -- this works around the insanity
>>>   		 * of overriding "git log" with "git show" by having
>>>   		 * alias.log = show
>>>   		 */
>>> -		if (done_alias)
>>> -			break;
>>>   		if (!handle_alias(argcp, argv))
>>>   			break;
>>> -		done_alias = 1;
>>> +		done_alias++;
>>
>> I don't think anybody cares about done_alias being an accurate count.
>> Should we just leave this as-is?
> 
> Good point.  The only caller treats it as a bool (i.e. "should the
> failure be reported as failure to expand an alias cmd which resulted
> in (updated) argv[0] that is not a git command?").
> 

As the string-list has its own counter, I guess the done_alias variable
can be reverted to a simple 0/1 value.
