From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH v3 4/4] api-builtin.txt: explain common command groups
Date: Sun, 03 May 2015 22:59:15 +0200
Message-ID: <55468C23.70306@gmail.com>
References: <554405D5.9080702@gmail.com>	<55456990.6000509@gmail.com>	<55456AD3.7090908@gmail.com> <CAPig+cT0aurG9gS2CrwMPG2B4xrAbhvwNJtAjYz7UYc4x1TiEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 03 22:59:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp0yy-0003Rk-1R
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 22:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbbECU7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2015 16:59:20 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:36616 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbbECU7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 16:59:18 -0400
Received: by wgen6 with SMTP id n6so133397024wge.3
        for <git@vger.kernel.org>; Sun, 03 May 2015 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GrQcj22kmBcdyop4/DU/h7qDAR79dHNkzkG4yWSJJF8=;
        b=SR3r+1twERfgsmR9PJoPPnGARifUIG6BWcPGekrN4ZTZRCkip6P0RCxJX/5RhrTRQ1
         wUBvmjN1B0lbYNBBMa/CKyUV6fSS/lhHpJoDn5nF9U6edpANMa0ynPn+NSVi9RGb7WjV
         DGOyTQqraKicf44/DvG68n2mJ/VSx8ioqxJ6/LwtLswTBbeSm5lM7Y8geKa7SIbFKDog
         /6+Ke8W1SaN+ScRqfiSveMYrkYH4Ytr/bMpL3K0CBZGP3Kxa2aRz1N2JpK6Zn55nU1tm
         Ayta4As3fOlPDk9Zpw0PJvxAN9mNR/HXtNf7IQQ+XklOK8VjTmR9rl2udJ8eqr1XquD9
         2Zuw==
X-Received: by 10.180.85.42 with SMTP id e10mr13915638wiz.17.1430686757634;
        Sun, 03 May 2015 13:59:17 -0700 (PDT)
Received: from [192.168.0.15] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id e10sm8121898wij.11.2015.05.03.13.59.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2015 13:59:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cT0aurG9gS2CrwMPG2B4xrAbhvwNJtAjYz7UYc4x1TiEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268293>

On 05/03/2015 10:02 PM, Eric Sunshine wrote:
> On Sat, May 2, 2015 at 8:24 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> Update api-builtin.txt to explain how to add the group information
>> for common commands.
>>
>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com=
>
>> ---
>> diff --git a/Documentation/technical/api-builtin.txt
>> b/Documentation/technical/api-builtin.txt
>> index 22a39b9..76baba8 100644
>> --- a/Documentation/technical/api-builtin.txt
>> +++ b/Documentation/technical/api-builtin.txt
>> @@ -50,7 +50,11 @@ Additionally, if `foo` is a new command, there ar=
e 3 more
>> things to do:
>>    . Write documentation in `Documentation/git-foo.txt`.
>>   -. Add an entry for `git-foo` to `command-list.txt`.
>> +. Add an entry for `git-foo` to `command-list.txt`. If foo is consi=
dered
>> +  a 'common' command, add 'common-x_group' as the third value,
>> +  where x_group is one of the existing themes:
>> +
>> +       git-foo        mainporcelain common-3_worktree
>>    . Add an entry for `/git-foo` to `.gitignore`.
>
> Unfortunately, this change breaks Asciidoc formatting by making the
> following ".Add an entry..." item get glued to the new "git-foo..."
> example. Fix by inserting a blank line after the "git-foo...". (And
> try formatting it yourself to ensure that it is working as expected.)
>

I'll look into that.

> Finally, all of your patches are whitespace-damaged and fail to apply
> to the code-base. Did you paste them into your email client or some
> such? If possible, try to send patches via git-send-email since it
> does a good job of protecting against whitespace and other types of
> damage.
>

I'm having a hard time configuring send-email through gmail,
so those patches were indeed pasted into plain text. I'll look into
making send-email work.

Thank you for the help,

S=C3=A9bastien
