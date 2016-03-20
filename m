From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 20 Mar 2016 21:52:06 +0530
Message-ID: <56EECE2E.4080004@gmail.com>
References: <56E3BE3E.9070105@gmail.com>
 <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> <56EAC49B.6020909@gmail.com>
 <33EDD26C-ED5A-42EE-B523-240AEF5C51B7@gmail.com> <56EEC6EE.10602@gmail.com>
 <A0465058-2171-4C00-8D45-C610046C496D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Kevin Daudt <me@ikke.info>, philipoakley@iee.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 17:22:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahg7O-00017M-Ty
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 17:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbcCTQWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 12:22:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34793 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbcCTQWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 12:22:11 -0400
Received: by mail-pf0-f193.google.com with SMTP id n5so25881055pfn.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7Q2ipZNXTPrVIZQxy24Wzmc23Q0DH7X21mKhWElN3EI=;
        b=WuTHXCTCGd4qlySC9M1EBJZ/IVhVWrJoe4OEywUA/15p2odN0dSeE0CI4gmzJf+sWZ
         HZE2xFYrUwpyxsIg4m6z89JIJaXpqOJCuiAjossso7YkOSTv+Z+SslQAGdGq81zprjkx
         6e5HQUUO2AaRd9/Lh+Dz+gXoqgI6zBjD0RyvcbT/hFB76Kil2OTAVasyEnSBKW31WRe6
         W7hem/q/raHOgX3eiZrnbR7GsnbRlw/A2Jm2e0Xvu0kQ/X9o57khVr+50JOHvi/9u+dX
         m5K6V/TgLwOyFcLDjBqNmazeMldS3g3n1syaI8E8UHcXu8zFf2UgEgxqDhhWLxaB268e
         hGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7Q2ipZNXTPrVIZQxy24Wzmc23Q0DH7X21mKhWElN3EI=;
        b=Mr/55NBPW3P0iiuZPb1yh+HgZhWpWdWvNp6GGAlvYgAnPjSuv1KraAg/fQuYy6Z4pn
         4hw/1iceR5p/alxvjW2Yl9ElFhaiCMfgyyNvmhgUwBQu4sOdmg52K5UcPmk42+px4cob
         r7a5npJ4MBmN2duB0QnG8Mjw4H7I6YBJB2Aw79TfWN5HQcUWVouYZL+lGAdcI/RwyL2o
         hvjswhJy88t36/m6pqQ6kc+JWJ2njDAR3MyRWNEnUetjtIRdp3JMXl24lZ8DLiwHivB3
         3sYP3OcWn3LZfT2sMQxhrxk8jot9/wfy8fVnameQg+cag2uooeYdTGKZVyadsJFAWGfu
         mRBw==
X-Gm-Message-State: AD7BkJKtxzESQKaOo2rA0U13VN5otW6CrDGlR65tzGI8MPay1gkphEAureXT6sy14Tq3bA==
X-Received: by 10.66.63.41 with SMTP id d9mr38833579pas.1.1458490931229;
        Sun, 20 Mar 2016 09:22:11 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.159.75])
        by smtp.gmail.com with ESMTPSA id f12sm34450563pfd.87.2016.03.20.09.22.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2016 09:22:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <A0465058-2171-4C00-8D45-C610046C496D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289363>

On Sunday 20 March 2016 09:38 PM, Lars Schneider wrote:
> On 20 Mar 2016, at 16:51, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>
>> On Sunday 20 March 2016 09:09 PM, Lars Schneider wrote:
>>> Hi Sidhant,
>>>
>>> that sounds about right to me. In what language do you plan to implement the 
>>> wrapper?
>> I'm comfortable in programming with C, so I think I can use that. Otherwise,
>> I'm also comfortable with python and familiar with bash, if they are required.
>> Would C be the right choice though?
>> Also, I've made a draft proposal for the project and uploaded to the GSoC
>> application site. Should I send it to the list as well for RFC?
> Although I like Python a lot, I don't think it would be a good choice. AFAIK Git
> core does not depend on Python and therefore you can't really expect a Python
> interpreter in every Git environment (e.g. it is not part of Git for Windows).
>
> The wrapper could certainly be implemented in C, although I don't know if this 
> would make things harder then they need to be. My initial thought was to use a
> scripting language that is known to be shipped with Git (Bash or Perl). I
> think Perl might even have an advantage as it offers very good regex/string
> processing functions (disclaimer: I am no Perl expert at all...).
Okay, I'll get started with Perl right away, shouldn't take long.
> Please post your draft proposal as plain text RFC to the list.
>
> Thanks,
> Lars
>
>
>> Thanks,
>> Sidhant Sharma
>>> Best,
>>> Lars
>>>
>>> On 17 Mar 2016, at 15:52, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> So to sum up, the list of tasks for the project would be:
>>>> 1. A wrapper is to be implemented around (called 'ggit') that will scan the
>>>> arguments for potentially destructive commands. When none are found, all the
>>>> arguments will simply be passed through to git.
>>>> 2. If such a command is found, 'ggit' will:
>>>>   a. Show what the command is actually going to do.
>>>>   b. Ask the user if they are sure they want to execute it.
>>>> Eg. "You are about to do X which  will permanently destroy Y. Do you want to
>>>> continue?"
>>>> 3. For all commands that are entered, 'ggit' will also show a brief summary of
>>>> the command what it will do when executed, explaining it's intended usage.
>>>>
>>>> Is the list correct, or did I miss something?
>>>>
>>>>
>>>> Thanks and regards,
>>>> Sidhant Sharma
