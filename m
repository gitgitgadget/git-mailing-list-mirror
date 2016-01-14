From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: Worktree "gitdir" file being mangled after upgrade to 2.7.0
Date: Thu, 14 Jan 2016 08:58:02 -0500
Message-ID: <CANoM8SUB5hfZHkLenDEq1O1wFrZno1OUUSH2uwDfihC0z+tUkQ@mail.gmail.com>
References: <20160113234753.GA26473@gmail.com> <xmqqh9iglwf3.fsf@gitster.mtv.corp.google.com>
 <CACsJy8D2Bz42kvBD1e=0oqxrYDry7_wCOy5Fi3oS-sGJxux4-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Erik Johnson <palehose@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 14:58:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJiPy-000132-UT
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 14:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbcANN6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 08:58:23 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36501 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbcANN6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 08:58:22 -0500
Received: by mail-oi0-f47.google.com with SMTP id o124so106250962oia.3
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 05:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L1kKGx8W+sV+dHt2jClJXpjC6+8Ex89ysy63ryBnUOU=;
        b=awfle6DmbkqR5wBS9RB1VRv0gmQ3uaa9EvX2SNZQt6G3MyMRqGaZpYHgRbaqcib75G
         7YKqunh/qZy2iM9EzxCByXDx6n69S8H06KKO9IV2di3jdE9HzVUaMBYhmLtpno0vu+8I
         M1FRsUeKOiiLV8KWu6CubYZ33g8c2vhlL8PKfCmc+esKc0nuhqJ8Gui4aOi4t/u0DHdn
         78fmnLVp+doxt6z6vUyezGFWXJ3bAGp+DWgXtjd1DwITHnYkBRFrhxEEtw130kmBQJj0
         Nhxq0LUEbHt0iQ9JEW/1JyqzKKSjIK1b4USDO2SgpGb+c/hGXCvTGY6G2oZb5EbqO2sX
         Fwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=L1kKGx8W+sV+dHt2jClJXpjC6+8Ex89ysy63ryBnUOU=;
        b=cCZ3OWpqmRDVP1VI1jO4C+u9IuojeAxOYG7b8uJ0pvrXqx0WVISotQWOK7eu3xWp1j
         XlrnaZoTa5nCF8ZjI9BdJ0BtIx32CVIeTefE1e/k6i4Ck7c96U5MaRAMyzXS/8ZXvr5g
         6CfqxR3wZJO/AWfqbJv0ZOZ+RlMLYkFHB53TmoH5GHUFGRYOGh4WUg5/CZEwRA8GIJq/
         +14tPkV18ThKuQgTbg/nKG1jS+mgoa+B8ZmZS3CNMmL7ezV1vsEFrHY3p3pWbgsQw0xd
         /QJtouqb8NkAXVGk3L8PTFx2XSiLcJK3zu+MYStghlYz9CsZ9JyKdtBWFhS+PiRBn+6H
         mOyA==
X-Gm-Message-State: ALoCoQlUptE0itlQa7f0Il6IjSQ9WBzFFlKexyc29p3Bm89F/2rrzIMOAY9GVaqT6nE8VweSqU9mx7J9j5kaGt/SxalGLQFx8g==
X-Received: by 10.202.201.77 with SMTP id z74mr3319621oif.24.1452779901437;
 Thu, 14 Jan 2016 05:58:21 -0800 (PST)
Received: by 10.76.80.168 with HTTP; Thu, 14 Jan 2016 05:58:02 -0800 (PST)
In-Reply-To: <CACsJy8D2Bz42kvBD1e=0oqxrYDry7_wCOy5Fi3oS-sGJxux4-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284034>

On Wed, Jan 13, 2016 at 10:29 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jan 14, 2016 at 9:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Erik Johnson <palehose@gmail.com> writes:
>>
>>> Since upgrading to 2.7.0 last week, eventually I'll get to a point when
>>> I run 'git worktree list' where several worktrees are incorrectly
>>> reported as pointing to my main git checkout. Further analysis of the
>>> files in $GIT_DIR/worktrees/worktree_name/ shows that the gitdir file
>>> for the worktrees which display incorrectly contains ".git" instead of
>>> what it should contain (i.e. "/path/to/worktree/.git".
>>>
>>> This was reported a couple days ago on Github:
>>>
>>> https://github.com/git/git-scm.com/issues/650
>>>
>>> Since the audiences for the mailing list and Github don't overlap
>>> completely, I figured I'd report it here to get this issue in front of
>>> as many eyes as possible.
>>
>> Thanks for relaying.  Duy, Michael, I think this is your area?
>
> The only place that a relative path can be written is
> update_linked_girdir() unless i'm mistaken. That function is being
> deleted "soon" because it causes another problem

`git worktree list` command does not modify the worktree gitdir file,
so this is only a symptom of the problem.  If at all possible, we
should move to get Duy's fix into the 2.7.1 release.  This problem
almost makes git worktree list useless.

> --
> Duy
