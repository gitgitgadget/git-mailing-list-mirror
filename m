From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2014, #04; Wed, 26)
Date: Sun, 30 Nov 2014 15:35:33 +0700
Message-ID: <CACsJy8D7uf=TVDy1CYmQ8gO4KL=gSz=KMg6NmOEUzhjjjn=X_g@mail.gmail.com>
References: <xmqqoarto8xy.fsf@gitster.dls.corp.google.com> <20141127183901.GD4744@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Nov 30 09:36:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuzzH-00032Q-Mm
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbaK3IgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 03:36:06 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:65238 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbaK3IgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:36:05 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so7608490ieb.7
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z+cnNm3fg5TKt0h4V1PHW2EjOOY5OlTKsBZryRtL7yg=;
        b=fjNo/Mu1nCM7E4Q2yd5WAIawD7hhdphiuZdudKngnNGCgKW+N9Fl+R29fWGE3IhXAs
         NMiSUCeBEBbBu4bYeb24G+Ii2eu7fEcQn1tm0GWDm+eoMV9mTZnSm8lgaOSpY0oOQApn
         ohHWIJ2mt+v19EcV4WCZGgvxl+Pj2GsBjLz33LZfmIlzuSoSqQnfU64qiso8ziOE87FN
         CQ2b7uD+scPps47ThCIfJz7cFKPU10mDQSXsXo7nXU1eSEekqUS2Llu3A9kZ6yIMZXfv
         D6FJ51e9z/YV13b25aMZOCCoCQ8KO8dDNHgzvhdH1Sh5JilD0WK/LtUgH8FH8zgl+El7
         OUjQ==
X-Received: by 10.50.18.102 with SMTP id v6mr41147153igd.40.1417336563775;
 Sun, 30 Nov 2014 00:36:03 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Sun, 30 Nov 2014 00:35:33 -0800 (PST)
In-Reply-To: <20141127183901.GD4744@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260422>

On Fri, Nov 28, 2014 at 1:39 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Wed, Nov 26, 2014 at 03:09:45PM -0800, Junio C Hamano wrote:
>> * nd/untracked-cache (2014-10-27) 19 commits
>>  - t7063: tests for untracked cache
>>  - update-index: test the system before enabling untracked cache
>>  - update-index: manually enable or disable untracked cache
>>  - status: enable untracked cache
>>  - untracked cache: mark index dirty if untracked cache is updated
>>  - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
>>  - untracked cache: avoid racy timestamps
>>  - read-cache.c: split racy stat test to a separate function
>>  - untracked cache: invalidate at index addition or removal
>>  - untracked cache: load from UNTR index extension
>>  - untracked cache: save to an index extension
>>  - untracked cache: don't open non-existent .gitignore
>>  - untracked cache: mark what dirs should be recursed/saved
>>  - untracked cache: record/validate dir mtime and reuse cached output
>>  - untracked cache: make a wrapper around {open,read,close}dir()
>>  - untracked cache: invalidate dirs recursively if .gitignore changes
>>  - untracked cache: initial untracked cache validation
>>  - untracked cache: record .gitignore information and dir hierarchy
>>  - dir.c: optionally compute sha-1 of a .gitignore file
>
> You didn't comment on the status of this branch, and I'm interested.

I'm not Junio :) but I think the core changes are done. I wanted to
actually add watchman support on top of untracked cache as well to see
if it needs any more changes. I think I can see how it could be done
now (not easy, but not terribly hard). I'm going to resend soon to fix
some minor bugs (in a reroll that Junio has not picked up) and change
file format to be more compact.
-- 
Duy
