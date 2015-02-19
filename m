From: Stefan Beller <sbeller@google.com>
Subject: Re: [Discuss] soften warning message after cloning "void"
Date: Wed, 18 Feb 2015 16:47:23 -0800
Message-ID: <CAGZ79kb+qnhG22rKu9yMoBJKbiapf1kLfAnsfZW87eUpYezuRA@mail.gmail.com>
References: <xmqqh9ui2481.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYu1k=iKRWTxVD9Q=C9F5J0d653czeR0NCy04wGobB=Vw@mail.gmail.com>
	<CAPc5daUzdiS0HkVbqZvQvSm_49FhQj++hicmDTb717Cd7hg8hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOFHG-0007Jf-E2
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 01:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbbBSAr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 19:47:28 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45690 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbbBSArY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 19:47:24 -0500
Received: by iecat20 with SMTP id at20so5763384iec.12
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 16:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oD3Q01pUHkjM6s+f2T+o1zNgvkpHrgN7eH3BbfJAwgU=;
        b=FR5YoeoMDhh6ghdicKtB8BDS6ua8GT/tYc1uH+Wv4T5TLNDnMDhGSFQs1HyqvQnH/i
         X8twTgJZGriIj1ZY8kmbeWP6KOgDJjD+0lxyAJnZq7TMZ5GFWeFAbDl1nTKUewc/U94X
         tdMneRJnNFkND+XDznQ+rFmM8vZbj99yAKAPohrxIHVvWvOtTAteQmyUMzR1hlUpYbla
         VxPxfm6HZc3db/9orjJofXXGWderS48CIwxc8lNWN1aTQc+sfmUWgSsGvq5jDtFhcg56
         YD0jdmZjGROuUssJeo8uv8Q949mouaNlrwxzMrwlmlAL0WU76Hzpggn5E5umAblJIkAG
         AZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oD3Q01pUHkjM6s+f2T+o1zNgvkpHrgN7eH3BbfJAwgU=;
        b=I7g5mzQrp/Yo1jLh1E/NF3sDKkjp1RWzbuXG5bP8FO/DfuSL+Zgm6VMf1+OGz8zMIg
         +94bKe32oxJYRqjG0iVF/P9EXoFbPbmce6g7UjDgM+SqnO68irQ/+z34ftSagavcPhVz
         5DVqwoN3YsnLQDwkBWyC/X3f8QF/1oP9JalykrrSrHIDZgcts2l1yBdW2kV64BFFpGHq
         D1mm7vA+r95yHMOSyJYTzT5azdUPBheGQtbtBjT4+dqmYewYDW0jiXjHWgzKIcOwNycM
         16UNokCUWsWueho8x6/xVSYyMLRH9DAcKhALqcrPIUWJNlKGOyszFpMbqX5hoIb4qvsE
         ay+Q==
X-Gm-Message-State: ALoCoQmw9B+P+33h9wco8EA21tZRXEeO4PLmOxxhvXlonGK0/AF9GBYVMNrWDzdxFFZU2MfPpZm6
X-Received: by 10.50.222.70 with SMTP id qk6mr6471773igc.47.1424306843379;
 Wed, 18 Feb 2015 16:47:23 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Wed, 18 Feb 2015 16:47:23 -0800 (PST)
In-Reply-To: <CAPc5daUzdiS0HkVbqZvQvSm_49FhQj++hicmDTb717Cd7hg8hA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264079>

On Wed, Feb 18, 2015 at 4:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Feb 18, 2015 at 4:13 PM, Stefan Beller <sbeller@google.com> wrote:
>>> +               warning(_("remote HEAD refers to nonexistent ref; "
>>> +                         "leaving the current branch unborn.\n"));
>>
>> Personally I find that more confusing, because I have an idea of
>> what checkout may refer to. The notion of an unborn branch is not
>> clear to me.
>> Maybe
>>
>>> -               warning(_("remote HEAD refers to nonexistent ref, "
>>> -                         "unable to checkout.\n"));
>>> +               warning(_("remote HEAD refers to nonexistent ref; "
>>> +                         "Checking out $branch instead.\n"));
>>
>> with $branch being master in the example above. I'd have no idea
>> how to come up with a good heuristic which branch to checkout.
>> (It would need to match current behavior)
>
> Checking out a random branch is absolutely the worst thing you can
> do.

I agree on that, but why did I see the master branch checked out?
(There was just one branch, so it's obvious which to checkout instead)
But HEAD being broken, I would have expected

$ git clone ...
remote HEAD refers to nonexistent ref, checking out nothing
$ git status
HEAD detached at (nothing)



> Personally, I would think that the best thing you can do is to
> educate your users not to clone from a void.

I disagree on that. The repository may be broken by tinkering
(why would you run git -C void symbolic-ref HEAD refs/heads/nosuch
anywazy?) and people want to clone it nevertheless.

> Create some history
> that is worth sharing, and then push into an empty repository.

I am not sure what you mean here.
