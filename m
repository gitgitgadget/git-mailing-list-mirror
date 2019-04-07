Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FFD520305
	for <e@80x24.org>; Sun,  7 Apr 2019 22:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDGWX6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 18:23:58 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:25580 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfDGWX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 18:23:58 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id DGCghSunVgI7iDGCghT12x; Sun, 07 Apr 2019 23:23:55 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8
 a=Xguq9_k2nrMNsBd0bIcA:9 a=28BE5-r2zy6yqmcv:21 a=vuliQgO2VwxuxqzZ:21
 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22
Subject: Re: [PATCH 2/2] describe doc: remove '7-char' abbreviation reference
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20190406132747.16376-1-philipoakley@iee.org>
 <20190406132747.16376-3-philipoakley@iee.org>
 <87bm1ha8ek.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <44d40686-e72a-43dd-4798-b02f41ce92ae@iee.org>
Date:   Sun, 7 Apr 2019 23:23:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm1ha8ek.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfIo8dpM/QxizWECqiQwINP2rt3sKpV+mRQlPTz2V0EhiTiCV1/JFV9/kNxHI2wY4tSNqYWaeM0DfRpA43hUkB4KHKYN0K96zJWDpI9WWABJ85OZoE2IW
 09x0sIKguWhK/mBtcVUrVMbYNVPxGJtTcJp8UWgG9yux/nw9fxJye02oVCgZojzd/YQwWIlJV0N+T+gX+CCLHnXJGjuLUPHRo9cPnScyvmhCmDJW7a2Yj/Lj
 sDNMX+74ce0Q6ebXj98bajoFTu1x9MMSPxYtGQts2kXuWY0ra7/QBswGlqz1uL2nQxLp4X80NmHrxm3duHnWAGkSXzrbWDxx7AIsKFYr8+c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 07/04/2019 21:05, Ævar Arnfjörð Bjarmason wrote:
> On Sat, Apr 06 2019, Philip Oakley wrote:
>
>> While the minimum is 7-char, the unambiguous length can be longer.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> noticed while looking int the Git-for-Windows patch thicket -
>> was looking for the ~n^m style!
>> ---
>>   Documentation/git-describe.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
>> index ccdc5f83d6..a88f6ae2c6 100644
>> --- a/Documentation/git-describe.txt
>> +++ b/Documentation/git-describe.txt
>> @@ -139,7 +139,7 @@ at the end.
>>
>>   The number of additional commits is the number
>>   of commits which would be displayed by "git log v1.0.4..parent".
>> -The hash suffix is "-g" + 7-char abbreviation for the tip commit
>> +The hash suffix is "-g" + unambiguous abbreviation for the tip commit
>>   of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
>>   The "g" prefix stands for "git" and is used to allow describing the version of
>>   a software depending on the SCM the software is managed with. This is useful
> Both the old/new version are subtly wrong. Whether the new one is better
> is another matter.
>
> First, there's more places we mention the now-incorrect 7 characters, at
> least these (one of which you're fixing). Found by grepping for ' 7 '
> and '7.*abbr':
>
>      Documentation/git-branch.txt-181---abbrev=<length>::
>      Documentation/git-branch.txt-182-       Alter the sha1's minimum display length in the output listing.
>      Documentation/git-branch.txt:183:       The default value is 7 and can be overridden by the `core.abbrev`
>      Documentation/git-branch.txt-184-       config option.
>      Documentation/git-describe.txt-65---abbrev=<n>::
>      Documentation/git-describe.txt:66:      Instead of using the default 7 hexadecimal digits as the
>      Documentation/git-describe.txt-67-      abbreviated object name, use <n> digits, or as many digits
>      Documentation/git-ls-tree.txt-93-Object size identified by <object> is given in bytes, and right-justified
>      Documentation/git-ls-tree.txt:94:with minimum width of 7 characters.  Object size is given only for blobs
>      Documentation/git-ls-tree.txt-95-(file) entries; for other entries `-` character is used in place of size.
>      Documentation/gittutorial-2.txt-44-
>      Documentation/gittutorial-2.txt:45:What are the 7 digits of hex that Git responded to the commit with?
>      Documentation/gittutorial-2.txt-46-
>      [...]
>      Documentation/gittutorial-2.txt-52-name), and that the contents of a Git object will never change (since
>      Documentation/gittutorial-2.txt:53:that would change the object's name as well). The 7 char hex strings
>      Documentation/gittutorial-2.txt-54-here are simply the abbreviation of such 40 character long strings.
>
> It was never correct that we'd pick 7 characters, we'd *try* that before
> e6c587c733 ("abbrev: auto size the default abbreviation", 2016-09-30)
> but would pick a longer one if it was unambiguous.
>
> Whereas "unambiguous abbreviation" isn't correct either, and arguably
> less correct. At least 7 is what we *still* pick as a fallback in lieu
> of the auto-sizing, but just "unambiguous abbreviation" implies that in
> a repo with some 10 objects we might show just one character, or that
> we'd post-e6c587c733 pick say 7 characters in a repository where it *is*
> unambiguous but where we've auto-sized to 12.
>
> I've been meaning to follow-up on
> https://public-inbox.org/git/20190204161217.20047-1-avarab@gmail.com/
> where I among other things wanted to just have these instances all say
> "commits will be abbreviated as described in XYZ in linkgit:<something>"
> and summarize what happens there.
>
> I don't mind if this goes in, I mainly wrote this E-Mail as a brain dump
> since it jolted my memory on the topic, and so that I could dig it up
> later & see how I intended to follow-up on those #leftoverbits
I had had a look at most of the other '7 ' references and decided that 
most of those I saw were about the minimum abbreviation settings, but it 
looks like I maybe missed a few - like the gittutorials.

  I was aware that I was being slightly economical with the truth, but 
was just looking for a way of implying 'variable length' and I punted on 
the long explanation as the particular reference was way down the 
document. If anyone has a suggestion for a better phrase I'd be happy 
And I could add it to the tutorials as well).

Philip
(added Junio, given his follow up email, though we still need a term for 
this.)
