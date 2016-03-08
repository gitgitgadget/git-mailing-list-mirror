From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Tue, 8 Mar 2016 17:19:23 +0700
Message-ID: <CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info> <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
 <20160304115634.GC26609@ikke.info> <CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
 <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com> <CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
 <xmqqlh5ungct.fsf@gitster.mtv.corp.google.com> <xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 11:20:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adEkE-0006nY-KB
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 11:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbcCHKT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 05:19:58 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33339 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbcCHKTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 05:19:55 -0500
Received: by mail-lb0-f180.google.com with SMTP id k15so12255146lbg.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 02:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ynkZ1R5LPeifqK6D1cWnHHe6stIs47gOQJmDKAXwxzg=;
        b=qIWlEEjXRJMZv5PVyBLzkApf6ENEAOTV933p2RQzWJ9FtJk+tqHv0XYjxTsyod1zb4
         JIYwHP0wMDfN6reYeUydVZ1iIgVtykegTwapNG5ILAe83OQl9w5AVNHb49MeirXNOHIR
         VWbAOLlqTZhB2qVw+Hd67IMTwcJXT4tKSLIH5ApCUOcxLYKzM8K/6e7ZUp1sJA+NK1KE
         4lXpD5HAbZxoHXooRPMEf/VPXEqBJEXwMB1lbclmbXOPsB/uG00TN4YdJ/FPwx5kVhfL
         7yElko3oonWAGh/CgvYqHtKYBM2JLee/P0TzqTEK6XB4UrAHGNN/ZFFE+Xs16sNmR6dn
         YOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ynkZ1R5LPeifqK6D1cWnHHe6stIs47gOQJmDKAXwxzg=;
        b=YWLn7IXNgEiz/n2A8DjQzObUTr132C2KVtZjxUTnQUQ53xNhbXeLXqw0kqVh9K5GXm
         d7H0qq4eOKzPYQ2X0JsIdT4kQgKtqwBqWLAphhywQ1Pqqn/YHXFzraE3aEEbLCDxiwRB
         7ZAVvKcKpbm5ycbghMtvWO8P0sCFKrXnzySwkkgI0XEC3WUCpKk5Oztzc/Ypf9bms0tZ
         XfZy23ANS8RNbB2oOza58Chic7mRO1TOR8a87bflKXJGXGIMKs2LoGfuKH6BVhAl9Psb
         3kR65BScPfNKs6I2mSpU6Lwsprt9o+j2FPM75KRVPtXkNVaFLZJoxxxXMe5yuVDYQbF3
         JIvg==
X-Gm-Message-State: AD7BkJKKlw1QwdAUXdN+A/10TzutGYdVqZkz94eWjGk0skuuLRvPyLKWkDOJ37mbRSzi7zx2B+8xmg9R1Z/REA==
X-Received: by 10.25.212.213 with SMTP id l204mr9579145lfg.118.1457432393736;
 Tue, 08 Mar 2016 02:19:53 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Tue, 8 Mar 2016 02:19:23 -0800 (PST)
In-Reply-To: <xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288424>

On Tue, Mar 8, 2016 at 1:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> We need documentation update to settle this one before 2.8 final
>> ships, as we seem to be seeing more and more end-user confusion on
>> the list.  I tried to come up with a trimmed-down example, which is
>> shown below, but I suspect that the code is not exactly working the
>> way it is described in that (1) dir/file1 is ignored and (3)
>> !dir/file3 entry makes difference.
>>
>> Where did my example go wrong?
>>
>> FYI, if I prefix '/' to all the .gitignore entries in the example, i.e.
>> making it
>>
>>     *
>>     !/dir
>>     /dir/file2
>>     !/dir/file3
>>
>> instead, then dir/file1 and dir/file3 do get shown as unignored.

Arghhh.. bug!!!

The difference between "dir" and "/dir" is, the former is basename
matching while the latter is pathname matching. When we check
dir/file1 after we enter "dir", we do try to check rule "!/dir" (or
"!dir") before rule "*". In the pathname matching case, it works
thanks to a60ea8f.

In the basename matching case (i.e. rule "!dir"), the code does not do
the right thing. It blindly checks the base name of dir/file1, which
is "file1", against the pattern "dir". The right thing to do is check
the "dir" in "dir/file1" part against pattern "dir". Failing that, we
fall back to pattern "*" and excludes dir/file1 as well.

>> If it is documented somewhere, then I can update the example and
>> declare victory (but then the text that accompanies the example
>> still needs to remind the readers why the leading '/' matters.
>
> I also found that having an extra slash at the end of the
> "everything underneath 'dir' directory is included", i.e.
>
>      *
>      !/dir/
>      /dir/file2
>      !/dir/file3
>
> breaks it.  dir/file1 is ignored, dir/file3 isn't but the latter is
> only because there is an explicit !/dir/file3.  This is contrary to
> this rule in the documentation:

This is pretty much the same. But instead basename matching unable to
deal with nested rules, the trailing slash means "check if it is a
directory". Again, the code tries to check if "dir/file1" is a
directory instead of "dir".

I haven't dug back in history, but my impression is it has been so
probably from the beginning of "!" introduction. This has nothing to
do with nd/exclusion-regression-fix, which is more about

    dir
    !dir/file

than

    !dir
    dir/file

Although the first patch in that series happens to fix the pathname
matching case in this example.

I don't know. It seems to me I should fix this anyway, by making both
"NODIR" and "MUSTBEDIR" code work well inside a directory. That should
fix it. I hope I don't have to turn dir.c up side down for that. Last
time I looked, it wasn't easy, which led to hack/avoid it with 57534ee
and that was eventually reverted.
-- 
Duy
