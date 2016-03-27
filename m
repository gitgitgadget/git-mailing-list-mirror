From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 3/3] commit: add a commit.verbose config variable
Date: Sun, 27 Mar 2016 12:48:05 -0400
Message-ID: <CAPig+cRU+JJabUdNTVDtZsrmWgn0TWetxhCFpyR+=5LK-w-7XA@mail.gmail.com>
References: <01020153b478cfab-5309f834-7617-4a7f-a3e9-93f0dcf4a6be-000000@eu-west-1.amazonses.com>
	<1459079497-19121-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPOhTC_LjUPHMN0PJsc94gvmHgmQL2Xe63oRGOiEMR2jjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 18:48:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akDrQ-0006Lx-Qw
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 18:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbcC0QsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2016 12:48:10 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34822 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcC0QsH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2016 12:48:07 -0400
Received: by mail-vk0-f67.google.com with SMTP id e185so12504797vkb.2
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=pOXuZ6Es9DUnTohrVYr2uOTQTkwcBfc9YsYfx8Pa/yE=;
        b=hMGLDnBIofNZomcOdBsM5UP5BjHn0y88wIKLkSNjv/PNgCETMcHWwG2KEVusBMy+TS
         XwjoWMC1b6jV2glMOO0ga6w8YjoFWfE+dhtl+yK5X0UVUBtHCR5TsZ4gYSQoDQNsftJA
         WVLO4/KuGSHTEO7lPlVlIKJuyqBYSHFYidDsQCEX1xca5AJJ9CjFHv2uJsqJfHONrZe7
         x7SD83BjTPSn1TbNfJgXh/4fb3BlUHIAr26++6IJPIrCMTgRNN5Xz0+qIZ225xwmtYGO
         LiY7hUE+ZmvNbcZN2tsiBQN4TXTZI8BRS+N8yCrocsdZiU6QLJebKDAyN4epBEvtJK1/
         Wzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=pOXuZ6Es9DUnTohrVYr2uOTQTkwcBfc9YsYfx8Pa/yE=;
        b=Pn8pYKPLfZW0u8geA0Z9uYOKc4/haPZh/YBtJADk1amDydZDygUYqGsuUDf6qd5yWk
         YTIOUgIVjUWdS0mWYMQW+VM9n1DTqDTF6H6YeyXF1hT0/phHBHtKp1KVJDz6sCSC9qbF
         FY5bzb2FG+QX6fjsr4uDUCp3inldXP6ibEZc1CQOkEZ3POw/PQABA04WUejPZ3I5TGiJ
         9Xq3A0jZZFV2bVmF0e33ynI3iU7x39kb071v9vzrwfNvAN4rTq/5ImAD505eQ1d82gmb
         hBArz47te26zz7xVXds1GRi/XTSLPRpFdnK0H7uanT1LbFlTmuhXWMXNQzbmRSjaQV9j
         QsnA==
X-Gm-Message-State: AD7BkJL+0/nD/GL20x/luSFVWRbav44txvm6krsT1rr3mQSFRtLIxCN3tCLFJeEkH2u0lNRhV4uP4z/bpv14kw==
X-Received: by 10.31.141.2 with SMTP id p2mr12387939vkd.37.1459097285778; Sun,
 27 Mar 2016 09:48:05 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 27 Mar 2016 09:48:05 -0700 (PDT)
In-Reply-To: <CAFZEwPOhTC_LjUPHMN0PJsc94gvmHgmQL2Xe63oRGOiEMR2jjQ@mail.gmail.com>
X-Google-Sender-Auth: ffUh5tanVCX3TEELbpozN-a6e2k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290014>

On Sun, Mar 27, 2016 at 7:59 AM, Pranit Bauva <pranit.bauva@gmail.com> =
wrote:
> On Sun, Mar 27, 2016 at 5:21 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>>> +test_expect_success 'commit.verbose true and --no-verbose' '
>>> +     git -c commit.verbose=3Dtrue commit --amend --no-verbose &&
>>> +     ! test -s out
>>
>> Please use the test_must_be_empty helper instead, because it has a
>> nice, human-readable name and it complains with a helpful error
>> message if something goes wrong, whereas 'test -s' just fails
>> silently.
>
> Thanks for pointing it out. I was unsure whether 'test -s' is a good
> choice but used it since I did not know any other alternative.

=46or these particular tests, it would be more stylized to use:

    test_line_count =3D 0 out

which would keep them consistent with other tests in the same file whic=
h use:

    test_line_count =3D 1 out
    ...
    test_line_count =3D 2 out

however, that's a minor point.
