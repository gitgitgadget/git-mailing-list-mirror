From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 19:59:18 +0700
Message-ID: <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Feb 14 14:00:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEINA-0004Zn-Gp
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 14:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbaBNM7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 07:59:50 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:63112 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbaBNM7t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 07:59:49 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so18368487qap.30
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 04:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ciKEKCtd9JsOgKwgQMDKpeYSJi0LmrPf7MNpKSthWUI=;
        b=bWhnH68rk/m8KXDaBCdvF1tuzKVDcD3HY5fMxmY4tBnS/LAKjB2PtldfKzBfwMy1NZ
         sefCM+TgPxQ0GMR5mWzqe5Tfz2NFPdVgho58ZEGZRybIOkQlcrx/EY46kvwll1/Z8MhN
         jjqc2f54xzE/sFcCbsVUWNmzj0UaDL5J0582M01geShkQbqtR/r7osJkRY6zeJ0vL69y
         A1ufuxsIDhA3YJVyDfclALVFqsdjl+xOeimOoJZQcuiSXClukBWnlhOJOl/Pgp0rDbqC
         /O7fzWZ5L+KdzDvuMHOHi6WPYfCo7xqjk5dSy9jKjfQTb4LIEvuif/shps00pggZ7xfT
         fvfQ==
X-Received: by 10.229.10.197 with SMTP id q5mr12596552qcq.15.1392382788813;
 Fri, 14 Feb 2014 04:59:48 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 14 Feb 2014 04:59:18 -0800 (PST)
In-Reply-To: <87a9dt981o.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242100>

On Fri, Feb 14, 2014 at 7:45 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Josef Wolf <jw@raven.inka.de> writes:
>
>> Notice the refs/heads _within_ refs/heads!
>>
>> Now I wonder how I managed to get into this situation and what's the best way
>> to recover?
>
> Probably you did something like "git branch refs/heads/master".  You can
> remove it again with "git branch -d refs/heads/master".

As a porcelain, "git branch" should prevent (or at least warn) users
from creating such refs, I think.
-- 
Duy
