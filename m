Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079B620966
	for <e@80x24.org>; Thu, 30 Mar 2017 19:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934720AbdC3Tth (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 15:49:37 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36837 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934152AbdC3Ttg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 15:49:36 -0400
Received: by mail-pg0-f45.google.com with SMTP id g2so48077728pge.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ou/xayQUaw9OtWzZzkejF8YqFXgV1K0IyT5VMKgN/uY=;
        b=UDR5xtJv0kyYER7kvkQBxu1To9nhOijfpQ2/OQDiC3EKFj9c+adKlsuWaPHegGu2MX
         brjyYuka3ZOm/t9EyTq9tphMix0IfratfFFBzO4FxTGKe9eF+fOegY9cANEV+c8EtSKv
         auH8k4hQtwFT3h3nj4lRGo8Cri4z3DBl2V/twsiqrW9rm+bJtcpWZaEIUid67ZmZaQV9
         dkJgqajZiEznHcwn71iDqKBJffUyf2GjlejJbpvlkaLAHNlZn7lxE30Bl9aa0zoEnq/R
         tGdoGR9an41D+pem88SJpJbL6dxUEHZ1RmwtZA/A275ivORbFaJaULnYqMWfqwe1AJ89
         EAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ou/xayQUaw9OtWzZzkejF8YqFXgV1K0IyT5VMKgN/uY=;
        b=UU/DHeSYb1df0KerqOAXmxZ2pi63dfySJ9l9KKjon8/326gxQ3mXMZ3W61bvk84KFb
         FxcjHY/c8RRdpuj5vEqju2SLdu8IbBm9WtTOSlO8jIYZZ4PsdX4+OywpnzVD5s4//jD9
         vIUFtx6yxC4dswgw0F0fn20y7NI8ISSq7LNG6BACNEVfjhsXUd8B/jlc+WhsLBkGzDuo
         Ai+Q/A6Chl2KYZtnjOrGA51/AtOPII3YX+tQGgkpV2rTHRQiiAi5ppNxcVw4ZvDGwCTo
         F+nJh4Onih6n5+2UKzuY0fIFhd59+sPvV6fV7zhnMvh2LklVhWTMswIwlXWtdkK1bdLt
         6JRA==
X-Gm-Message-State: AFeK/H0D8vPNXdT0eBERyI/6Oyxe49DdYl24R6H/358ePtBri72Oxkkz7j9+AnnRj6CI8RTJNQYjN4CT26T5Gg==
X-Received: by 10.99.120.74 with SMTP id t71mr978670pgc.184.1490903374801;
 Thu, 30 Mar 2017 12:49:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.166.8 with HTTP; Thu, 30 Mar 2017 12:49:14 -0700 (PDT)
In-Reply-To: <CAKxAQzeHCpL+v=HxrVYBhb_MppSK2ffQs6f_wJCEaJEYrWCu2Q@mail.gmail.com>
References: <20170327194813.6876-1-johannes.schindelin@gmx.de>
 <87642eee-7eca-447d-b726-2fa87d212288@googlegroups.com> <alpine.DEB.2.20.1703292356480.4068@virtualbox>
 <75e7cd5c-2813-454d-aa14-53cf1d5e6f80@googlegroups.com> <56935015-3f5e-4cb6-a4f8-7c5c47eeade3@googlegroups.com>
 <CAKxAQzeHCpL+v=HxrVYBhb_MppSK2ffQs6f_wJCEaJEYrWCu2Q@mail.gmail.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Thu, 30 Mar 2017 15:49:14 -0400
Message-ID: <CANoM8SVLHRtRbW6AD9CNxEOs7KYTpvSCvLquCBchH=mjdE2w2w@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git for Windows 2.12.2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, git-for-windows@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forwarding to the lists, as my original message was rejected for html.

On Thu, Mar 30, 2017 at 3:44 PM, Andrew Witte <zezba9000@gmail.com> wrote:
> Just updated back to git 2.12.2 and git-lfs 2.0.2 and everything worked
> fine. Wish I could have gotten more info when it happened as its happened on
> a different computer as well. Will keep an eye out.
>
> Also another note that I really don't like with Windows for Git since 2.12
> is that It packages git-lfs with it. When I use the cmd it overrides the
> other git-lfs install I have. I have to manually go and remove the old
> git-lfs file in "program files" for things to work correctly.
>
> On top of this git-lfs needs to be registered in the environment vars
> because this is what the main git-lfs install does and apps Iv'e made like
> Git-It-GUI (https://github.com/reignstudios/Git-It-GUI) invoke git-lfs
> directly for some stuff. Because of this issue, the app will think a newer
> version is installed thats different from what the normal git cmd reports.
> Also doing git clone outside of the windows cmd with only git for windows
> installed doesn't invoke git-lfs correctly as its not registered in the
> system environment vars.  In short I don't think it should be shipped with
> the installer as it just creates confusion.
>
> On Thu, Mar 30, 2017 at 8:41 AM, Michael Rappazzo <rappazzo@gmail.com>
> wrote:
>>
>> I suspect that this is a problem in the windows credential manager.  I
>> tried this on:
>>   - git 2.12.2.windows.1 => failure
>>   - git 2.12.1.windows.1 => success
>>
>> More Details:
>> I have a perl script which uses (a copy of Git.pm) to invoke the
>> credential manager.  While debugging that script, I dumped the hash that I
>> read from the credential manager:
>>
>>     $git->credential($cred, 'fill');
>>     print Data::Dumper->Dump( [ $cred ] , [ "cred" ] );
>>
>> In 2.12.2, this produces output like this:
>>
>>     $cred = {
>>       'path' => '',
>>       'protocol' => 'https',
>>       'username' => '',
>>       'host' => 'some.host.com',
>>       'password' => ''
>>     };
>>
>> In 2.12.1, this produces output like this:
>>
>>     $cred = {
>>       'path' => '',
>>       'host' => 'some.host.com',
>>       'protocol' => 'https',
>>       'password' => 'my.password',
>>       'username' => 'mrappazzo'
>>     };
>>
>> While debugging this, I did something to get it to work on 2.12.2.  After
>> downgrading to 2.12.1, I manually removed the credentials from Credential
>> Manager (in Control Panel).  After successful authentication, they were back
>> in the credential manager.  I then upgraded to 2.12.2, and I was able to
>> successfully authenticate.
>>
>> To try to recreate the problem scenario again (in 2.12.2), I cleared the
>> credentials in Credential Manager.  Reattempting to authenticate gave the
>> credentials prompt.  The output of the perl hash was missing the password
>> again (thus, reproducing the error condition).
>>
>> I hope this helps.
>> _Mike
>>
>>
>> On Wednesday, March 29, 2017 at 10:06:03 PM UTC-4, Andrew Witte wrote:
>>>
>>> I'll try to get more info tomorrow.
>>>
>>>
>>> On Wednesday, March 29, 2017 at 2:59:10 PM UTC-7, Johannes Schindelin
>>> wrote:
>>>>
>>>> Hi Andrew,
>>>>
>>>> On Wed, 29 Mar 2017, Andrew Witte wrote:
>>>>
>>>> > The git 2.12 GCM for Windows is broken. I tried doing a git clone and
>>>> > got "*remote: HTTP Basic: Access denied*".
>>>> > I downgraded to git 2.11.0 and everything worked fine.
>>>>
>>>> Could you test v2.12.1, too, and open a bug report at:
>>>> https://github.com/git-for-windows/git/issues/new ?
>>>>
>>>> I am particularly interested in any details you can share that would
>>>> help
>>>> other developers like me to reproduce the issue.
>>>>
>>>> Thank you,
>>>> Johannes
>
>
