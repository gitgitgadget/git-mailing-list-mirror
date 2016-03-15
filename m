From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v7] commit: add a commit.verbose config variable
Date: Wed, 16 Mar 2016 02:39:51 +0530
Message-ID: <CAFZEwPOK1hH8CuFc6TohDc5xq7GXpp0DBnQi4QQ6m+8dspUbeQ@mail.gmail.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
	<1458041486-7044-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPNAVxT2HVQyj0Wajth_y-P6Af4AcSZDzJDJP=vLHztwiw@mail.gmail.com>
	<CAPig+cTRWg9yB7eXhnbgbjjYfrJyn_A-_gQmbW8NL1DEbkLpkQ@mail.gmail.com>
	<CAFZEwPP5AXHCmAg62wVNy_8FuOQxPdYofeb5b=m3g-ugiJkTyw@mail.gmail.com>
	<xmqqlh5j7am8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 22:09:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwE1-0000Wp-No
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbcCOVJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:09:54 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34222 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbcCOVJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:09:52 -0400
Received: by mail-yw0-f170.google.com with SMTP id h129so37750786ywb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8vrCQGitVcrfeqQKx3r7rg/ymXZXXzqpVKDvQLjAdCs=;
        b=bsxVBy3YvU+J+J7Uo4/RxXw2TkEDYuszk1rR3+3KTh/bb2rc0rshQS7hOGgyy2Ofc+
         0PYtCn9zvL3nxiLk0//NywqEpon/6NbtZiM2CEiQN9DFpFHIEUZEMLgHCsPJjJoKXrtf
         0VD3LGP9JEdxP6AT7qjAcnVxxEcLe46ZLgRnQZOYVC2ZOx5k9XqOW9whPeQasOU8Lesy
         yApFgbMf9QSAaJOLlFnqSow3H6pyuv3Xo89mTVjMocPZ4DITUoUN8lDaqUUrMSV9TrcM
         1JnFUhbKN1fpQmoQI1W1eXVkKipcR+O2F40MQRRsyGD78JWANdwSWAeKE6btxIwIlD9y
         YbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8vrCQGitVcrfeqQKx3r7rg/ymXZXXzqpVKDvQLjAdCs=;
        b=LumAF3uqfCCdxB9xYQ2YF+ACuEgMAaGuFIt/orwNHUzA0XVzsoAEA/S6rIQorhcYfI
         EiO8AgJTRjkHRfu6ouq0ejxqRYYPCZ7vYjgI/RiF1AUSoJBRk3X4SMSIjjPyarbiW7vB
         Wmd5TKqy1lhvbiKmFwtcu4G9JSOeaF/LmET0m0VO5g01TxKhH8uuMlUHehGx/OsoQ//7
         13gNw9kGCylQ65NPoi3HA3xb612TIfMEnyTDSNG6Xt3ZW84DHHaW2tFBfxkV1QUimPTf
         2SYemzwoAYoebNA/5LlwbJkCQroFZfx0am5f+g72GZadLQ1Q7GF+MSeIlBYc3pfYW6gJ
         3Mmg==
X-Gm-Message-State: AD7BkJJodLhmO+FomjP7z4HGTl9496hZjSbBB/CCiLnyNMpQ/uAuvKM5ai7xOlNXexAG9PyKOgyo9Id7WTX9tw==
X-Received: by 10.129.94.7 with SMTP id s7mr79410ywb.93.1458076191408; Tue, 15
 Mar 2016 14:09:51 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Tue, 15 Mar 2016 14:09:51 -0700 (PDT)
In-Reply-To: <xmqqlh5j7am8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288911>

On Wed, Mar 16, 2016 at 1:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> First one to introduce a new variable `config_verbose` to store the
>> value read by the config. Till then the value of verbose can be set
>> through command line options. Depending on the situation as you
>> described, it can then make the modification. Another approach would
>> be to swap the places where the configuration file is read and where
>> arguments are parsed. I personally think the first approach as more
>> appropriate as in the latter one, there might be some parts of code
>> which can break.
>
> Changing config-first-and-then-command-line is likely to break
> things, unless you do a lot more work to avoid breakage ;-)

I had guessed this correctly! :)

> Wouldn't it be the simplest to do:
>
>  * initialize opt-verbose to "unspecified";
>  * initialize config-verbosity to "unspecified";
>  * let git_config() update config-verbosity;
>  * let parse_options() update opt-verbose.
>
> and then
>
>  * if opt-verbose is still "unspecified", then overwrite it with
>    config-verbosity.
>
>  * if opt-verbose is still "unspecified" after that, then neither
>    the command line nor the configuration gave you verbosity.
>
>  * otherwise opt-verbose at this point has what verbosity level to
>    use.
>
> ?
I just realized that both of our approaches breaks the condition with
no-verbose.
If commit.verbose is set to true and --no-verbose is passed, then it
should not give verbose output.
But I suppose that is the reason you are saying "unspecified". If
`opt-verbose` is 0 then it would mean --no-verbose is activated. If it
is still "unspecified" then there would not be any such option. But
now the question is how do you set a variable as "unspecified". I can
set `opt-verbose` as -1. But then I am still not convinced for the
requirement of another variable `opt-verbose` as I believe that the
`verbose` and `config_verbose` are quite enough for this. First
`config_verbose` will read from configuration file. Then `verbose`
will read from command line options. If `verbose` is unspecified then
it will use `config_verbose`, else if `verbose` is 0 it will ignore
`config_verbose` else if `verbose` has a value greater than 0 then it
will stay as it is. Or is there something else which I forgot to
consider?
