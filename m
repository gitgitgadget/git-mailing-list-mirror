From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git notes and git-commit
Date: Fri, 10 Dec 2010 21:38:08 +0700
Message-ID: <AANLkTinmM5Nktd8AUH+ePobyMPkieB-2J0+pPUsX135p@mail.gmail.com>
References: <AANLkTi=q1F7WEgH+dLKTHOKhsNVuhU=OeyJ2AsP7oW2G@mail.gmail.com> <201012101513.43890.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 15:38:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR47R-0005aw-PJ
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 15:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab0LJOik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 09:38:40 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64850 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab0LJOij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 09:38:39 -0500
Received: by wyb28 with SMTP id 28so3514464wyb.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 06:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=X/K+NF2hWenAliza820nUsS8PIeslIuYsjW/vS8OFoQ=;
        b=aak/fxjYgtFIQAtUp3W8xjSmTCxmdKx9thWBFGjnsJHVsss7aEy4hPjIL4o8r4KNnh
         4PzC1ZUFJTFLmDX39j4RupcxaTVB8Mzaw3UlPkPJrBIXzawmPXglSXyUX0lKdC7lVLXP
         FFmZ8pLxOnwrYkXsxhR0HdBKsCDoGZJfGfG2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fdvMv1qSNiFZKPHKQsJ1ODpmA36c1hZU7vbb6xKJ12KU65W9PCiK8V9BHnwjNu6lVn
         minEt5wx0GKOGLC0B6MYtbHOd8SDJo2f60Yt44cRM4ZvQbYlnLLmIL8JifXC6bSzdhi+
         5b7PH8WDvTH69wWimMAKhXaBkqcLLsjjOVGBA=
Received: by 10.216.24.134 with SMTP id x6mr2302134wex.34.1291991918573; Fri,
 10 Dec 2010 06:38:38 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 10 Dec 2010 06:38:08 -0800 (PST)
In-Reply-To: <201012101513.43890.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163417>

On Fri, Dec 10, 2010 at 9:13 PM, Johan Herland <johan@herland.net> wrote:
> On Friday 10 December 2010, Nguyen Thai Ngoc Duy wrote:
>> Hi,
>>
>> I have never used git-notes before, just have had a quick look over
>> git-notes.txt so this may have already been discussed.
>>
>> Isn't it more convenient to write/update notes when editing commit
>> message? Jakub mentioned of "---" in the archive elsewhere. There's
>> notes.rewriteRef for commit --amend. But if I amend a commit, I might
>> as well change my notes. rewriteRef would not work with "git commit
>> -c" either.
>
> It seems your notes data is very much tied to your commit messages. If
> your notes needs editing every time you edit the commit message, I have
> to ask why you simply don't fold the notes into the commit message.

Both commit message and notes are "notes" related to a commit. Some
info, like todos, I'd rather leave them out of commit message. I
wasn't clear what I was getting to. But as you said below, notes can
be cleaned up without rewriting history, making it separate from
commit message. So basically they all are just notes (with different
purpose), which makes me think they should be able to be edited at the
same time.

> The same goes for rewriteRef vs. "git commit -c". If the notes should
> follow the commit message around, I have to ask why the notes are
> separate from the commit message in the first place.

Aside from "all editable at the same time" above, I think related
notes should show up when I write commit messages. Notes can give
helpful info for writing commit message, even if I don't update them.

> That said, there might well be good use cases for this (e.g. using notes
> to store data types - e.g. binary data - that cannot be part of the
> commit message), so I will not advise against implementing this, but if
> you do, please also consider that there are notes use cases where the
> notes are tied to the actual contents of the commit, and not the commit
> message (e.g. notes-cache).

Ah, I didn't know this. Thanks.
-- 
Duy
