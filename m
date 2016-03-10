From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Thu, 10 Mar 2016 07:26:00 +0700
Message-ID: <CACsJy8D=OjLBN-EXyKM4NnGhSGftYX+RAaR9fg8ML3QWAAb+iQ@mail.gmail.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info> <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
 <20160304115634.GC26609@ikke.info> <CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
 <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com> <CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
 <xmqqlh5ungct.fsf@gitster.mtv.corp.google.com> <xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
 <CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
 <xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com> <CACsJy8AUs-DAo-GceO9ND9RPVeDOfm_UM4ZuaeNWDwBVMu+dnQ@mail.gmail.com>
 <xmqqk2lbil7k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:26:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adoR3-0004Zk-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 01:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbcCJA0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 19:26:34 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33390 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933532AbcCJA0c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 19:26:32 -0500
Received: by mail-lb0-f181.google.com with SMTP id k15so90682747lbg.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 16:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kb/QfEcHY/XFnFKGjsjQ5sl0BhBIn0dRcAW+nknI83k=;
        b=CCJ2mjxtBFpozECWD85ifbVLnK8Yz8sc0DlPTJbAgedqUgzJAPwzwKusK3cHEi1Nr9
         bMkZuCe7Ds7YB8MO+YlBl/CJWBHRoA2Jrk+dm4vTbs9qVy6g5WOwvTIjNh8HnAEx87FE
         VueaqSDoSnVWW7NuuD+1frT/5NSphz5p3n0xyXQBReQx8NDloU5MlfmL30HWjkZ/aMSn
         tWWzgKm8LkgqrqKj3tfHO1V192ON4NqkM56zJVDLW5q541xl6YwHaFd4OlgIs1MXsFKF
         EHMpvbCpRG+oqJLFQN+BN9CrGspmF92xQrnUb6q49BJrp1r90qI4K6ZEt7AYOFuZdgrz
         Gyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kb/QfEcHY/XFnFKGjsjQ5sl0BhBIn0dRcAW+nknI83k=;
        b=j8tFFe7zbN1FCEgmNn5LABjSPrVklsFDFkSQ1WjZoyL0ZaW+M6pJAdM62ZW41dZHZ1
         xRC2YokFR8qbcpO3YpbuMe0oGb2zFi4cVpQIeN4FLB3icW8XZkIzB0qEqlNIbhwe5V9r
         L9Q8JsEVAaBIRxhFLc6z9wuUBnxR3k0lh4nrfU++o6Z2yhdrALkOh8xmS72udcleR4eN
         CWJonw/X+h0xzbszEUfJxbl5GziP18OekE56rushiYfjP8aajHvXIrf6HrugWm+Itp5b
         xZjYE+6Ql2HPQuMlAx5N4EsYkobjpyvtw3Qy4ncWnS2tlVKarkZyRt8hJo8bjyOlN6se
         ThGg==
X-Gm-Message-State: AD7BkJL8UEnE/1CddMm7/MWrJnAyv7IG4RvCZOyIkzAjTuZAqUWU7TaY+WPStlVZU372OeDjNyEngcaoqjND0Q==
X-Received: by 10.112.209.99 with SMTP id ml3mr181127lbc.26.1457569590302;
 Wed, 09 Mar 2016 16:26:30 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Wed, 9 Mar 2016 16:26:00 -0800 (PST)
In-Reply-To: <xmqqk2lbil7k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288589>

On Thu, Mar 10, 2016 at 1:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Mar 9, 2016 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
>>> index 3ded6fd..91d1ce2 100644
>>> --- a/Documentation/gitignore.txt
>>> +++ b/Documentation/gitignore.txt
>>> @@ -148,7 +148,43 @@ excluded, the following conditions must be met:
>>>     be in the same .gitignore file.
>>>
>>>   - The directory part in the re-include rules must be literal (i.e. no
>>> -   wildcards)
>>> +   wildcards and has to start with a `/`).
>>
>> Technically '/' can just appear anywhere in the pattern, except at the
>> end. But because the patterns in question must look like this
>>
>>     dir # or any pattern, even "*"
>>     !dir/someth*ng
>>
>> even if there is a slash at the end (and is ignored), we are still
>> good. Not sure how to phrase that though.
>
> Post 2.8, we'd be correcting this properly anyway, we should aim for
> the simplest-to-explain way to work around the limitation in the
> current code, that will still work once the bug is fixed.  I am not
> sure if "Technically it can be other things" helps, unless it makes
> it a lot easier to use.
>
> With that in mind, do you think we need to find a better phrase to
> loosen what I wrote that is overly-strict?  That is, is "must begin
> with '/' to anchor it to the level .gitignore appears" too strict to
> make it too hard to use?
>

If we can name rules from the syntax part, then we can simply say
"patterns that meet rules x and y".

A bit off topic, but these two paragraphs may need rephrasing, I don't
really understand what it's trying to say

 - If the pattern does not contain a slash '/', Git treats it as
   a shell glob pattern and checks for a match against the
   pathname relative to the location of the `.gitignore` file
   (relative to the toplevel of the work tree if not from a
   `.gitignore` file).

Not sure why "relative to the location of .gitignore file" matters. We
basically just take `basename $path` out and try to match it.

 - Otherwise, Git treats the pattern as a shell glob suitable
   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
   wildcards in the pattern will not match a / in the pathname.
   For example, "Documentation/{asterisk}.html" matches
   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
   or "tools/perf/Documentation/perf.html".

Perhaps "Otherwise" can be stated explicitly that "if the pattern does
contain any slash, besides the trailing one". The "wildcards not
matching /" is also true for the "pattern does not contain a slash"
rule above. We can make it a generic note about wildcards and remove
this "otherwise" rule, maybe...
-- 
Duy
