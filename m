From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Re: Apply commits from one branch to another branch (tree structure
 is different)
Date: Sat, 15 Mar 2014 01:31:15 +0530
Message-ID: <CAD6G_RSmpfhTr_qtdaChR9TqMZgn8BAuSNDmK5B3HJDZMyoM1Q@mail.gmail.com>
References: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
	<CADeaMWpw4gx00QpUJ7u49sQvu7KbhvhH14TMdHXBRXq4wCNDZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Brandon McCaig <bamccaig@gmail.com>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 21:01:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOYID-0006hP-Iv
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 21:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbaCNUBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 16:01:17 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:37281 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbaCNUBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 16:01:16 -0400
Received: by mail-yh0-f41.google.com with SMTP id v1so3117407yhn.28
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u8CoW9rKO4G0I9Dcp1c65mMkfDLPykuuZfIkNr768Cc=;
        b=hG0xjccomvqMnsgCFbme+6Qj0B0tUraEdHIxdDpJOLq8Ke/0VIGgKMLoWJFNlhZJug
         B9KOKZtZubt4tV3sg15/kH2TIMFx+/w/xNejy9BlF1HqbziT1juYHImiFky1ncUjqddD
         phBqVLe30jVyYmxC00iyrdCmJNhOSQsEl5YtFNFK/AHfLHXj+H9bhhcC2ywBzca1PnHZ
         ZuTnOrqmlN9g+PzdPDMnVl41YHjeKzrelav3YkBrRywJRBiN7BR3KfNDTxvUPUU4SEzv
         eRzS6NUMUJq+3g84geN2y/PoZLblJlgkE6bf2LFyXM6YDjpylzFRXucYyM81RLIxdFhG
         arZA==
X-Received: by 10.236.69.230 with SMTP id n66mr5309226yhd.124.1394827275455;
 Fri, 14 Mar 2014 13:01:15 -0700 (PDT)
Received: by 10.170.34.215 with HTTP; Fri, 14 Mar 2014 13:01:15 -0700 (PDT)
In-Reply-To: <CADeaMWpw4gx00QpUJ7u49sQvu7KbhvhH14TMdHXBRXq4wCNDZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244106>

On Sat, Mar 15, 2014 at 12:48 AM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
> On Fri, Mar 14, 2014 at 1:39 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>> Suppose developer send 10 patches on branch1 where are changes in terms
>> of <dir>_<version>/ then I need to apply on my local repo branch1, till now
>> is fine then I need to apply same 10 patches on to my branch2 where source
>> tree <dir> which is quite question here how can I do.
>
> You might be able to use the subtree option in recursive merge. Try
> something like:
>
>     git cherry-pick -X subtree=foo <commit>
>
> This tells git to apply the changes to the "foo" directory in your
> current branch (branch2).

How do I do this?

Suppose I'm in branch1 with two commits on foo_v2 and I need to apply them
on branch2 where in foo.

thanks!
-- 
Jagan.
