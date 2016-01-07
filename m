From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: how to fetch entire heirarchy of refs from a remote?
Date: Thu, 7 Jan 2016 15:25:31 -0800
Message-ID: <CA+P7+xpUW6as6aary+33V6sMo=BysFHpng6XeRRpXh2vXNKd=g@mail.gmail.com>
References: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
 <xmqqpoxd2d74.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 00:25:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHJwJ-0002JQ-4W
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 00:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbcAGXZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 18:25:51 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37591 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbcAGXZv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 18:25:51 -0500
Received: by mail-ig0-f181.google.com with SMTP id h5so25047593igh.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 15:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zieAu1LRNA+uHcs+9HF/MhGM2XdaEJMpJYBvMSsDLcc=;
        b=s9Uxu9lvW3DWKJht2He6EHwe8JBedcH2sCrfzcGQNBidqf1YuAI8ysA/4svyICcyYu
         a5Mbfx1RbeClk4BsKSMbzCC5iPQZ2WgkXggM2Bgc9s2p91jTTN1cyz+LWW0GpwS9NqVF
         nkN22Sk8dtJ9ZM9rDRpBW4G2/jii3j4JIYSegZnbls0AYmXwnz5XprLY9cHXg7JfXOki
         6XP+0VNOE8O6p5QF4VqPor9AL1P6NL3Wn9LE0qGznBINl3fNc0exog0pfolhJ8YHtCdq
         1ni1G5zvsxA5diqPLvYraHpN6JTFfCkELTgv7jbi6m2sCz2h1uIBKvMfEHsAaVQ9ItRq
         smRw==
X-Received: by 10.50.36.74 with SMTP id o10mr17296621igj.73.1452209150499;
 Thu, 07 Jan 2016 15:25:50 -0800 (PST)
Received: by 10.107.63.130 with HTTP; Thu, 7 Jan 2016 15:25:31 -0800 (PST)
In-Reply-To: <xmqqpoxd2d74.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283517>

On Thu, Jan 7, 2016 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> refs/changes/98/47298/3
>> refs/changes/98/57298/1
>> refs/changes/98/57298/2
>> refs/changes/98/73598/1
>> refs/changes/99/44099/1
>> refs/changes/99/69299/1
>>
>>
>> Is it possible to specify a refspec such that all of these will be
>> fetched? I tried doing
>>
>> +refs/changes/*:refs/changes/*
>>
>> but this doesn't work since the * can only be one portion of a refspec
>
> I am not sure if I follow.  With refs/heads/*:refs/remotes/origin/*
> (e.g. following git://github.com/gitster/git for example), I am
> reasonably sure you would get my refs/heads/jk/notes-dwim-doc and
> other topics you authored without the slash between jk and
> notes-dwim-doc getting in the way.
>
>


Infact, even running

git fetch origin +refs/changes/98/73598/1:refs/changes/98/73598/1

does not end up placing anything into refs/changes?

Is it because it happens to not be known by git? That seems rather
short sighted...

Regards,
Jake
