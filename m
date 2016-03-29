From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: weird diff output?
Date: Tue, 29 Mar 2016 16:05:57 -0700
Message-ID: <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
 <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
 <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com> <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 01:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2iM-0001rV-Q7
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758383AbcC2XGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:06:18 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36477 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbcC2XGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:06:17 -0400
Received: by mail-io0-f172.google.com with SMTP id q128so44032247iof.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3+7KQVyiRTkdOyz3YT/P+24HoVeF3Xg8MLhYh+kj/as=;
        b=wM2rPrYy0aOhMA0Lor+rUogBQg5VUSz6vtJA5/O8f/mZGwNhorM9SotM1VslFXgVnM
         TgtCTT3UtUZM/3XfGRZffuyumnW8MTfrED/RFBBllrD2FwBYK+KmMWLlwPi3WrbEKLww
         kGgOu1dAkTgh9pmeF7xIl2Va+kWurMklRvjwgzKkKX3AGLx7enTNdjDPWfdkQO5fX1/g
         xF137xLf4tZG+E2JXywhsFqTbyK0EcHA4ruu0pYqnNBTJkyWgo+Q0eQZBG2X5So/Q/fV
         wRNvvK8fHXU5eLIkcMSlFiKMIQ+RlJktYtXpvLhJCxT5Z2PIuewHEPPFkc6pS44meVG8
         iqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3+7KQVyiRTkdOyz3YT/P+24HoVeF3Xg8MLhYh+kj/as=;
        b=RGntdR81gLN7s9Am3vSH2CSbNgY6wb7CZEMSMdjH4r3zc7Okkjc0uZi79VCfp/AOTr
         6G9PZKNYaoZ3Etszfiza9+qzGsI+uUpKX+8K8aANPxjFFo2cRtauI6SwSADGM0oUqZCA
         zRFjlEB9orVv1KcUoKrftjjxSR9mXQtQ1OQncMU930A60pTxKYn1ZzNgKurbPA/3LWZC
         is407HzeAaDECAqeFBxfFuVLCArRGy/lZtMRZ1FYKt6RnSBs5W+MBkAv0OIlaRSFwt8Y
         X41BsysBJEDpveuxyHjB26K4YFCtOhAVSmrXHbKn6ER9trTlwxkNyUWiv3WU93Y9q6Tn
         pFyQ==
X-Gm-Message-State: AD7BkJI/Q+1MpxlE/uPH+pfZHgRGXz/9bDTdg2UKwD/5iii5x2wLTOlTes/diDGpbySAhNIxkkM1RBq+ZCMhcw==
X-Received: by 10.107.170.17 with SMTP id t17mr6883251ioe.71.1459292776632;
 Tue, 29 Mar 2016 16:06:16 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Tue, 29 Mar 2016 16:05:57 -0700 (PDT)
In-Reply-To: <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290220>

On Tue, Mar 29, 2016 at 11:16 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Mar 29, 2016 at 10:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> I thought this is an optimization for C code where you have a diff like:
>>>
>>>     int existingStuff1(..) {
>>>     ...
>>>     }
>>>     +
>>>     + int foo(..) {
>>>     +...
>>>     +}
>>>
>>>     int existingStuff2(...) {
>>>     ...
>>>
>>> Note that the closing '}' could be taken from the method existingStuff1 instead
>>> of correctly closing foo.
>>
>> That is a less optimal output.  Another possible output would be
>> like so:
>>
>>       int existingStuff1(..) {
>>       ...
>>       }
>>
>>      + int foo(..) {
>>      +...
>>      +}
>>      +
>>       int existingStuff2(...) {
>>
>> All three are valid output, and ...
>>
>>> So the correct heuristic really depends on what kind of text we
>>> are diffing.
>>
>> ... this realization is correct.
>>
>> I have a feeling that any heuristic would be correct half of the
>> time, including the ehuristic implemented in the current code.  The
>> readers of patches have inherent bias.  They do not notice when the
>> hunk is formed to match their expectation, but they will notice and
>> remember when they see something less optimal.
>>
>
> We have 3 possible diffs:
> 1) closing brace and newline before the chunk
> 2) newline before, closing brace after the chunk
> 3) closing brace and newline after the chunk
>
> For C code we may want to conclude that 3) is best. (appeals the bias of
> most people) 2 is slightly worse, whereas 1) is absolutely worst.
>
> Now looking at the code Jacob found strange:
>
>>  cat > expect <<EOF
>> + expected results ...
>> + EOF
>> +test_expect_failure  ... '
>> + ...
>> + '
>> +
>> +cat > expect <<EOF
>
> This can be written in two ways:
>
> 1) "cat > expect <<EOF" before the diff chunk
> 2) "cat > expect <<EOF" after the diff chunk
>
> We claim 1) is better than 2).
> This is different from the C code as now we want to have the
> same lines before not after.
>
> To find a heuristic, which appeals both the C code
> and the shell code, we could take the empty line
> as a strong hint for the divider:
>
> 1) determine the amount of diff which is ambiguous, i.e. can
>    go before or after the chunk.
> 2) Does the ambiguous part contain an empty line?
> 3) If not, I have no offer for you, stop.
> 4) divide the ambiguous chunk by the empty line,
> 5) put the lines *after* the empty line in front of the chunk
> 6) put the part before (including) the empty line after the
>    chunk
> 7) Observe output:
>
>>       }
>>
>>      + int foo(..) {
>>      +...
>>      +}
>>      +
>>       int existingStuff2(...) {
>
>> test_expect_failure ... '
>> existing test ...
>> '
>>
>> + cat > expect <<EOF
>> + expected results ...
>> + EOF
>> +test_expect_failure  ... '
>> + ...
>> + '
>> +
>> cat > expect <<EOF
>
> This is what we want in both cases.
> And I would argue it would appease many other kinds of text as well, because
> an empty line is usually a strong indicator for any text that a
> different thing comes along.
> (Other programming languages, such as Java, C++ and any other C like
> language behaves
> that way; even when writing latex figures you'd rather want to break
> at new lines?)
>
> Thanks,
> Stefan

This seems like a good heuristic. Can we think of any examples where
it would produce wildly confusing diffs? I don't think it necessarily
needs to be default but just a possible option when formatting diffs,
much like we already have today.

Thanks,
Jake
