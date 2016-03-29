From: Stefan Beller <sbeller@google.com>
Subject: Re: weird diff output?
Date: Tue, 29 Mar 2016 11:16:57 -0700
Message-ID: <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
	<CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
	<xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:17:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akyCQ-0007c6-Ow
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 20:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbcC2SQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 14:16:59 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37230 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbcC2SQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 14:16:59 -0400
Received: by mail-ig0-f179.google.com with SMTP id l20so21884540igf.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Zdp5c7ZLncXocysO3ghMzxV9f6EhpSE6ro13IqLY+Zs=;
        b=ZFqfuxB+Uz8OWiN08aLiPxrWxVPBXK9Og1iKeDnMnGN1wSW4gXnn6EbmgO4Dr6Aftf
         BnxN3JiA4790LfW4oUpg5y3SaZ7HArWdJmTo2qV9KQ8TeweNmNGO7+4MUlY8CPNU7Ipn
         6C4pw0Vc1p+3EwWqV00LnL7sgJ4MOv67UKQ8jhunnnBfFmE0CUl+AO5iR0NQBEDd68SD
         5N/5T81aMY6VZJTIdISHfC+xGpOTAlbu05nwxDpJKduo4wSvRYX84BFH+b4a0hyN+hmp
         lwmaag9BluGaINqbgskKVLHAT57MoGdGf5R8F859XG+V1yg6/au5bGy3GdgT+Kq/rXsc
         2adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Zdp5c7ZLncXocysO3ghMzxV9f6EhpSE6ro13IqLY+Zs=;
        b=lwpgU4CYbhPFsTISYxwnQTGueG7AIZi8iEcoulNaE/Y9EmNejhNOTeOmZPZSEhloHN
         r6qUcEmJWPkkQLSKACbXj43CYqLDEqa6uTK6pyiZ2K1RR4mwjf8YCQfgaL0mSosl4VMx
         F2emhC7rkUqxwnEnXHdoAzMh0As/ssMlKdTLKlNVD+SSuUesEbQZfOuEc+meJjC9wJZT
         qPADyRdlFJge+Je61Sn5CwvcdnhWIqtuZLCDhp+bRwCPWJ9FaCqcSBF3KS78pd7cjlYO
         AmNgrsZhUYTre4PfcFq890sploflwzxzD4O8Pr1K2gjUUwPNCR0XqpdbOKyRJ37yv3EN
         ZsYg==
X-Gm-Message-State: AD7BkJLaLRKQwzJXGuMBt1p3sP2SXdJjSPz6vuYHu72xtmGkLC0RxJIYeKEJcvmbbvfqOgvvUZta7sKg4J2rMs47
X-Received: by 10.50.72.107 with SMTP id c11mr4667555igv.85.1459275417872;
 Tue, 29 Mar 2016 11:16:57 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 29 Mar 2016 11:16:57 -0700 (PDT)
In-Reply-To: <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290154>

On Tue, Mar 29, 2016 at 10:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I thought this is an optimization for C code where you have a diff like:
>>
>>     int existingStuff1(..) {
>>     ...
>>     }
>>     +
>>     + int foo(..) {
>>     +...
>>     +}
>>
>>     int existingStuff2(...) {
>>     ...
>>
>> Note that the closing '}' could be taken from the method existingStuff1 instead
>> of correctly closing foo.
>
> That is a less optimal output.  Another possible output would be
> like so:
>
>       int existingStuff1(..) {
>       ...
>       }
>
>      + int foo(..) {
>      +...
>      +}
>      +
>       int existingStuff2(...) {
>
> All three are valid output, and ...
>
>> So the correct heuristic really depends on what kind of text we
>> are diffing.
>
> ... this realization is correct.
>
> I have a feeling that any heuristic would be correct half of the
> time, including the ehuristic implemented in the current code.  The
> readers of patches have inherent bias.  They do not notice when the
> hunk is formed to match their expectation, but they will notice and
> remember when they see something less optimal.
>

We have 3 possible diffs:
1) closing brace and newline before the chunk
2) newline before, closing brace after the chunk
3) closing brace and newline after the chunk

For C code we may want to conclude that 3) is best. (appeals the bias of
most people) 2 is slightly worse, whereas 1) is absolutely worst.

Now looking at the code Jacob found strange:

>  cat > expect <<EOF
> + expected results ...
> + EOF
> +test_expect_failure  ... '
> + ...
> + '
> +
> +cat > expect <<EOF

This can be written in two ways:

1) "cat > expect <<EOF" before the diff chunk
2) "cat > expect <<EOF" after the diff chunk

We claim 1) is better than 2).
This is different from the C code as now we want to have the
same lines before not after.

To find a heuristic, which appeals both the C code
and the shell code, we could take the empty line
as a strong hint for the divider:

1) determine the amount of diff which is ambiguous, i.e. can
   go before or after the chunk.
2) Does the ambiguous part contain an empty line?
3) If not, I have no offer for you, stop.
4) divide the ambiguous chunk by the empty line,
5) put the lines *after* the empty line in front of the chunk
6) put the part before (including) the empty line after the
   chunk
7) Observe output:

>       }
>
>      + int foo(..) {
>      +...
>      +}
>      +
>       int existingStuff2(...) {

> test_expect_failure ... '
> existing test ...
> '
>
> + cat > expect <<EOF
> + expected results ...
> + EOF
> +test_expect_failure  ... '
> + ...
> + '
> +
> cat > expect <<EOF

This is what we want in both cases.
And I would argue it would appease many other kinds of text as well, because
an empty line is usually a strong indicator for any text that a
different thing comes along.
(Other programming languages, such as Java, C++ and any other C like
language behaves
that way; even when writing latex figures you'd rather want to break
at new lines?)

Thanks,
Stefan
