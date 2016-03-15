From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v7] commit: add a commit.verbose config variable
Date: Wed, 16 Mar 2016 01:43:40 +0530
Message-ID: <CAFZEwPP5AXHCmAg62wVNy_8FuOQxPdYofeb5b=m3g-ugiJkTyw@mail.gmail.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
	<1458041486-7044-1-git-send-email-szeder@ira.uka.de>
	<CAFZEwPNAVxT2HVQyj0Wajth_y-P6Af4AcSZDzJDJP=vLHztwiw@mail.gmail.com>
	<CAPig+cTRWg9yB7eXhnbgbjjYfrJyn_A-_gQmbW8NL1DEbkLpkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 21:14:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afvLo-0003f1-K2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 21:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbcCOUNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 16:13:53 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35978 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbcCOUNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 16:13:51 -0400
Received: by mail-yw0-f173.google.com with SMTP id g3so35764258ywa.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1zv/7W7dd69yHLGp5Dc3nEvFSSa3IWcUiZRCEdjiHjw=;
        b=pRdXO8zxSatq/c1VU9BJm7unwoMc5gmi0ZKjkdUReYjLOV06KcS5cKgNsJogi+Xmlr
         7agZXl2NBz6xBgAjr+pPERpu/vRD4vdWKc5YWw5flcawyK0s8mpvl2MWQd+GKDUpKG/K
         gcwmmh6XKnQgOnoGu1UVuNXWK7Wm5VbdrD3lMpenDXnD5OZ6VVvRsj80HSHaNyIedii6
         X9kIhhzEqvrUdwt5vdej/LVr1A+fft5SWDnr45YnsJvv7YvSyp24NxD+iCfXM0WbTFiX
         h4SQqum+Ughnb22dfQPsBsOgL+89EYuEIXJNi5OJIfIr9N7IeYa93cYlu9lahC4LJpLn
         +S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1zv/7W7dd69yHLGp5Dc3nEvFSSa3IWcUiZRCEdjiHjw=;
        b=YmOxXm2urYGBtNYlSyVMNAxrG0PX0O97jhDAnAThCXM0pQnTpxxU8tDPOyHUklXwK/
         v3CP+lcAHyzvIGlLNIIlP4H3ZEfKSzrzbJpA7kz27fiAKVT2NBXe/gTHcbTmefusBQwe
         lKa36NZ0K2qVRSDJ5bPQM7oG5LxrK1Ck9TI+ix1JGo1MOXghQQundZrB7rSJHnrYsruG
         Ysdb0Xk41SWfhPFfBg2prFoB8gAhF4ghMbKwv+avU0t6iyooQi2i+L2e8+CuVciVtH9p
         yYlTiOUlcAbxT0oHS0dihEjXcAfaccBMU07T9YUKN1+QFNAC9QltZZ0glpKB2YPWIany
         5O+g==
X-Gm-Message-State: AD7BkJKMp15yN14AS4JCTf2H3uVfasA3kDvZtjNE5YyUFKItuiEzWbaav2rVZ/XTC/83MPgMC7bPbYrtzdVvGw==
X-Received: by 10.129.37.3 with SMTP id l3mr16109802ywl.128.1458072821008;
 Tue, 15 Mar 2016 13:13:41 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Tue, 15 Mar 2016 13:13:40 -0700 (PDT)
In-Reply-To: <CAPig+cTRWg9yB7eXhnbgbjjYfrJyn_A-_gQmbW8NL1DEbkLpkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288906>

On Wed, Mar 16, 2016 at 12:54 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> As Eric Sunshine mentioned ($gmane.org/288811), it would react
>> according to the multiple verbosity level and since its not currently
>> defined in `commit` it will react as it is reacting when verbosity
>> level is 1.
>
> I get the feeling that you missed SZEDER's point which was that
> git-commit already behaves differently when --verbose is specified
> multiple times. (I hadn't gotten around to reviewing that part of the
> code yet, so I'm glad that SZEDER saved me the effort.)

My bad! I missed SZEDER's point.

> The new config variable, which is boolean, doesn't mesh well with
> multiple verbosity levels. For instance, with a combination of
> commit.verbose=true and a single --verbose, the code will think that
> --verbose was given twice and use verbosity level 2, which is not at
> all intuitive and would be surprising for the user. So, SZEDER was
> asking how this impedance mismatch can be rectified.
>
> A possibly sane approach would be to make commit.verbose be a
> verbosity level rather than boolean, and behave as follows:
>
> 1. if --verbose is used (one or more), completely ignore commit.verbose.
> 2. else, if commit.verbose is set, use it.
> 3. else, default behavior.
>
> I'm not sure if this makes sense, but as a convenience, maybe also
> recognize "true" and "false" as aliases for 1 and 0, respectively, for
> values of commit.verbose.
>
> And, of course you'd want to test these behaviors.

This seems a good approach to me. I have two ideas of implementing it.
First one to introduce a new variable `config_verbose` to store the
value read by the config. Till then the value of verbose can be set
through command line options. Depending on the situation as you
described, it can then make the modification. Another approach would
be to swap the places where the configuration file is read and where
arguments are parsed. I personally think the first approach as more
appropriate as in the latter one, there might be some parts of code
which can break. As for the part of alias, I can use the method
git_config_bool_or_int() which takes care about aliasing for me. I
will also write tests for this behavior.
