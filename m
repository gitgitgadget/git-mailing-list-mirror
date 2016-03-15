From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7] commit: add a commit.verbose config variable
Date: Tue, 15 Mar 2016 15:24:29 -0400
Message-ID: <CAPig+cTRWg9yB7eXhnbgbjjYfrJyn_A-_gQmbW8NL1DEbkLpkQ@mail.gmail.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
	<1458041486-7044-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPNAVxT2HVQyj0Wajth_y-P6Af4AcSZDzJDJP=vLHztwiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:24:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afua3-00039m-2J
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934901AbcCOTYb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 15:24:31 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35080 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932665AbcCOTYa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2016 15:24:30 -0400
Received: by mail-vk0-f41.google.com with SMTP id e6so34096768vkh.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=90s9zmr9XtWmvWy0QWw1XLazqwpWfquS5ApUhpT893c=;
        b=hz25tIdixeaBnH7fWmcNsrHK/bHZFsAa9y3BOcLHJ+4/HOzRdWZetC8zSCtBxU3+VD
         TnGKUuA0CKzcnvcRhXTcktecKAomTX0qf1hkwtDXuHdwYEgkHdFTMomeI9E2QFIJJ2QE
         qUz+vOo0KMQMVEYhZ9TDT8rC0vnKmn++PqdVKNWtqChpIjzVTCluM9RqPb72a5kI8oAN
         y36g9UAAjEasaoT1xwI4j1697ViDnWzeHizpWpWSM0oVL/CllcVYHSP0/DkA85/jC/st
         mALo9HnSn7CH4aCJ218DIGwkYawrqV32kqLp8XTa/pBsU11TsFK2cFwnRw2d3RJcEJQQ
         pPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=90s9zmr9XtWmvWy0QWw1XLazqwpWfquS5ApUhpT893c=;
        b=jkqISsRfPo18k8NYkT8xBB5Qi1aHClFeiFb7I0MwnUwwaBbMGZ2c2u91f+h7kZGxSk
         lhuIlRkg46KB6Z0Kke77w5gyj5pIwN/avA+VMOB2PDPbXXHPAQ9XJXuejUoi2O4dBRso
         x5KS1pIek4wLztmLsKjCxkjISGcreB2mreP9d2UYqs34z4kHBs4btIjYlglq0bSsL0mS
         o8Ct5W2tJ/0Zuziqr9c2fTzpoT5TncmHnkgacUvLXEDyXasXyn1ClW3iSstOFOb0INho
         1SYQyKTggta1yt0Ih/0teQsaYK3+fHoy9dGuMGK3V7QjwcV8vXJhodUTBpOx6uhIlnM8
         Ha8g==
X-Gm-Message-State: AD7BkJIpniFGDBDEqLsVyXqW8iCjMoRjlXHuEUop4AC6Xc6zDd+R+8jMjZ7r4KvKgrDGN1ESqnWmudQ2Zwi+UQ==
X-Received: by 10.31.168.76 with SMTP id r73mr33347660vke.117.1458069869389;
 Tue, 15 Mar 2016 12:24:29 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 15 Mar 2016 12:24:29 -0700 (PDT)
In-Reply-To: <CAFZEwPNAVxT2HVQyj0Wajth_y-P6Af4AcSZDzJDJP=vLHztwiw@mail.gmail.com>
X-Google-Sender-Auth: QZkG902sV4n8oWqmpRaRbg64Ga4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288897>

On Tue, Mar 15, 2016 at 3:00 PM, Pranit Bauva <pranit.bauva@gmail.com> =
wrote:
> On Tue, Mar 15, 2016 at 5:01 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>> You made 'commit.verbose' a boolean, so either verbose or not, ...
>> ... but note these context lines telling us that --verbose can be
>> specified not just once but twice (and who knows what the future may
>> bring).  This raises some not entirely rhetorical questions:
>>
>>   - What does 'git config commit.verbose true && git commit --verbos=
e'
>>     do?
>
> This is a nice thought which didn't strike me!
>
> As Eric Sunshine mentioned ($gmane.org/288811), it would react
> according to the multiple verbosity level and since its not currently
> defined in `commit` it will react as it is reacting when verbosity
> level is 1.

I get the feeling that you missed SZEDER's point which was that
git-commit already behaves differently when --verbose is specified
multiple times. (I hadn't gotten around to reviewing that part of the
code yet, so I'm glad that SZEDER saved me the effort.)

The new config variable, which is boolean, doesn't mesh well with
multiple verbosity levels. For instance, with a combination of
commit.verbose=3Dtrue and a single --verbose, the code will think that
--verbose was given twice and use verbosity level 2, which is not at
all intuitive and would be surprising for the user. So, SZEDER was
asking how this impedance mismatch can be rectified.

A possibly sane approach would be to make commit.verbose be a
verbosity level rather than boolean, and behave as follows:

1. if --verbose is used (one or more), completely ignore commit.verbose=
=2E
2. else, if commit.verbose is set, use it.
3. else, default behavior.

I'm not sure if this makes sense, but as a convenience, maybe also
recognize "true" and "false" as aliases for 1 and 0, respectively, for
values of commit.verbose.

And, of course you'd want to test these behaviors.
