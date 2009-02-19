From: John Tapsell <johnflux@gmail.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 14:24:05 +0000
Message-ID: <43d8ce650902190624q40bc4d96hbacd505350d72eb4@mail.gmail.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
	 <871vtudabm.fsf@iki.fi>
	 <43d8ce650902190152t6162593x8d0920be0e6d7a6d@mail.gmail.com>
	 <slrngpqpjt.j03.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 15:25:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La9qM-0007T6-Se
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 15:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZBSOYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 09:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbZBSOYJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 09:24:09 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:58416 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbZBSOYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 09:24:08 -0500
Received: by gxk22 with SMTP id 22so1033964gxk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 06:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=E9mAwwB6zigsaM8/KHhGjL/4837uhqCSC/JlNqgAh6o=;
        b=xJeaaPnkMEVP2aIponYAONpf5OcmyzzNJz9p1VoH3LUKaEuHEA2BM+pX5+YpX0xnRC
         JeMZWWwWpUD5q8deDGUgnolNAfJvetGYVNCJqjVCfr2ebDJANdUFMmW9OHggh9mtfFFs
         ymQG9dDTIWlIL7JnXGVnmvdroI6N7onfFfrdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=S4kRca6blEHjNTVfW4hP5mSFZfDFxZxc79jBDAvke7FYf2g5u9e6JQuZ0aO5ONq78d
         z8V55VFp69zCfYwsS/qWDX/gfdy9BY6S6UEOAFHJNYvTXXJ77ap2/f1J6phOFRFS3s6h
         zCa318zpIkBT2K0eDOfTd16GEeKrYnIwwp3oA=
Received: by 10.151.39.2 with SMTP id r2mr424492ybj.243.1235053445398; Thu, 19 
	Feb 2009 06:24:05 -0800 (PST)
In-Reply-To: <slrngpqpjt.j03.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110706>

2009/2/19 Sitaram Chamarty <sitaramc@gmail.com>:
> On 2009-02-19, John Tapsell <johnflux@gmail.com> wrote:
>> 2009/2/19 Teemu Likonen <tlikonen@iki.fi>:
>>> I think it's better to use aliases for this kind of personal things:
>>>
>>>    git config --global alias.my-rebase "rebase -i HEAD~10"
>
> perfectly reasonable
>
>> I'm trying to make git more obvious and easier to use, rather than
>> find any solution :-)
>
> I'm sorry I don't know what is obvious about any specific
> number, unless it is 42 ;-)
>
> Seriously, forcing *some* default simply because some people
> use it with that value does not make it obvious to anyone
> but those few.  I'm not even arguing about the number; I'd
> hate to have *any* number be the default.

Yep.  Some other people have come up with some pretty good ideas.
Maybe defaulting to 'origin' or something is the best way forward.

John
