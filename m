From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: Repo with only one file
Date: Wed, 7 Aug 2013 17:07:39 -0400
Message-ID: <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com>
 <520224E0.5060206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 07 23:08:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Axm-0005Oo-5t
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 23:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933334Ab3HGVIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 17:08:04 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:46746 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932849Ab3HGVID (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 17:08:03 -0400
Received: by mail-ve0-f173.google.com with SMTP id cy12so2361882veb.4
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TRyQxBGujs27S5Ua9ReVgkuK95cOdbZIzyD0I4uqTyY=;
        b=ZKF2LrQHxH4z9ebxrgdB/hDhrolDbzP05IdONvC5nFY6+Gk8RxR01s4yVU2l9A98ln
         1ThmVkmEJGz75yT6Sii+eqMzBdk3caGsemLGCzCfoSyI90w06lrw/7W3clTd+ssqm6m3
         UneRWkRo5wFHxboVYnZUnD+BM0+62ey/pyppVfi0RrWERdAPya9ibXO9A4L7KKrdBqxe
         qc0p+N4jjXrK+i7bUxRJEzz9C6b1QgEIZuoiAS9Q2NuWdC7HCR2vwyUKAGDOJEKiqzTi
         wb8Evokr885bWx1z8eb9OfyV0HGtUM5FQvkuUjGMfU41gfxa2YHz8zOaO7o5Za0quZSE
         0GKA==
X-Received: by 10.58.211.227 with SMTP id nf3mr1564235vec.20.1375909681147;
 Wed, 07 Aug 2013 14:08:01 -0700 (PDT)
Received: by 10.52.116.72 with HTTP; Wed, 7 Aug 2013 14:07:39 -0700 (PDT)
In-Reply-To: <520224E0.5060206@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231844>

On Wed, Aug 7, 2013 at 6:43 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/7/2013 8:24, schrieb shawn wilson:> ... create a repo for one of
>> these scripts and I'd like to keep the commit history.
>>
>> Ok, so:
>> % find -type f ! -iname "webban.pl" | while read f; do git
>> filter-branch -f --index-filter "git rm --cached --ignore-unmatch $f"
>> HEAD ; done
>>
>> Which basically did it. But, I've got this one commit that seems to be
>> orphaned - it doesn't change any files.
>
> Try this:
>
>   git filter-branch HEAD -- webban.pl
>

 % git filter-branch HEAD -- webban.pl
Cannot create a new backup.
A previous backup already exists in refs/original/
Force overwriting the backup with -f
 % git filter-branch -f HEAD -- webban.pl
Rewrite 1e04b18c256c996312f167be808733bcc755f1e3 (9/9)
WARNING: Ref 'refs/heads/master' is unchanged
