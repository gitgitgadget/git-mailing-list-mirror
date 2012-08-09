From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Add Code Compare v2.80.4 as a merge / diff tool for Windows
Date: Thu, 9 Aug 2012 09:06:51 +0200
Message-ID: <CAHGBnuOaze=opbK+hH2s92enHuN2NUuKOVsTY4ZKgc3aWsX2-g@mail.gmail.com>
References: <5022CC90.3060108@gmail.com>
	<7v1ujhrs7e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 09:06:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzMpd-0001VK-In
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 09:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab2HIHGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 03:06:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63779 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab2HIHGv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 03:06:51 -0400
Received: by yenl2 with SMTP id l2so106409yen.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 00:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9+wBr5nRCrKydIhGszAVVvLDOiHHZCyYHW/8js+6X0M=;
        b=XfnKk8sI9rS4sQEFplbrNjcs/QDmNQBkad5tLoz32XhyEJc/KhgLY7tipSNdZjLMo6
         JhmShcMuKhkLdFdjaAkShICqsGb3WrrxCRYEWhWjYaaPJDwCRby7ne+5U7NM3JiD7FBk
         VLLhWTckxdWGUAqlpEgimMFXLKuIJcCfJ+bzOuQ3/AT7M5ZXcC8Rgd1ZuZn4wSG4848M
         qSWpH5kqSqEZf10/0BbVVFTgRqsXhNbCbsOF8NBM5JTzw1XsRzSSfFjQ8pUSCEbjvKgH
         qbBnyeFtwV8YfFoSpjkq+uhX9oWAMphwH3vQeKU6v0GtuEczP9I4KpqaD3RzoHFh/Ayy
         0xGg==
Received: by 10.50.188.135 with SMTP id ga7mr39746igc.48.1344496011077; Thu,
 09 Aug 2012 00:06:51 -0700 (PDT)
Received: by 10.64.137.97 with HTTP; Thu, 9 Aug 2012 00:06:51 -0700 (PDT)
In-Reply-To: <7v1ujhrs7e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203152>

On Wed, Aug 8, 2012 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I do not have a strong reason to vote for or against inclusion of
> yet another tool as mergetool backends (read: Meh), but what this

That sounds almost as if you'd like to keep the number of directly
supported mergetools small (I'm not talking about about the length of
the list of mergetools in the docs right now). I was always thinking,
the more mergetools, the better. Do you think differently?

> patch does to Documentation/merge-config.txt is actively unwelcome.
>
> As we discussed earlier in
>
>     http://thread.gmane.org/gmane.comp.version-control.git/201913/focus=201976
>
> the longer term direction is to reduce the names of tools listed
> there.
>
> I am somewhat saddened to find your name in that thread; you should
> have been aware of that discussion when you wrote this patch.

I still agree that not listing all mergetools in multiple places is a
good thing. But doing the whole stuff of extending --tool-help for
git-mergetool and git-difftool to return a simple list that can be
used in git-completion.bash etc. IMHO is a separate topic and out of
scope of this patch.

If it helps to accept the patch, I can send a v2 that changes
merge-config.txt and diff-config.txt to refer to "git-mergetool
--tool-help" and "git-difftool --tool-help" instead of naming any
actual tools.

-- 
Sebastian Schuberth
