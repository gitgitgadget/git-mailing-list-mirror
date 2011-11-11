From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Thoughts on gitk's memory footprint over linux-2.6.git
Date: Fri, 11 Nov 2011 14:44:52 +0200
Message-ID: <CAMP44s1cZc5OZ0L0zG-Wu+QVpu7xv4-JtWTBtPvnjO7sUFeM9w@mail.gmail.com>
References: <CACPiFC+T1EZ1CSakQxsYZhsnHc-ZsN1-=tpoi-NaQSdpU5Yxkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 13:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROqTb-0003jD-IL
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 13:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074Ab1KKMoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 07:44:54 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40221 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab1KKMox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 07:44:53 -0500
Received: by pzk36 with SMTP id 36so4238261pzk.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 04:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1+ur3qV5nL1o4Q4tww2JduKdyqTRWCyYcwOTp+Fe5iw=;
        b=fpvOCD4d9F2HMQfxfdAZbeh2X5yP3jI47ZF8x/VP6xAHoOp290yKSKzyP8+78M9URD
         4iIvuaKUktu+5R9KcFcWDwdUUjb9sAP8Sz3UW2hYJzgNEfDUKpj1sZf/OdAiCpWb4yxQ
         S//jVeox6dxYy7785E0B6ttKa5znCm9ByLOyU=
Received: by 10.68.33.134 with SMTP id r6mr7255389pbi.76.1321015493446; Fri,
 11 Nov 2011 04:44:53 -0800 (PST)
Received: by 10.68.58.38 with HTTP; Fri, 11 Nov 2011 04:44:52 -0800 (PST)
In-Reply-To: <CACPiFC+T1EZ1CSakQxsYZhsnHc-ZsN1-=tpoi-NaQSdpU5Yxkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185265>

On Mon, Sep 26, 2011 at 10:38 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> However, I find it extremely annoying over the kernel tree, due to its
> memory footprint. It is not the only thing I am running, (Chrome
> Browser, Gnome3, Firefox, many gnome Terminal windows, emacs), and
> given that I am looking at "just a couple of commits" I don't feel
> opening a few gitk instances should be problematic... except that it
> is.

Sometimes I do this:
 % gitk master..branch_1 master..branch_2 ...

But as I visualize more branches, it becomes tedious.

It would be nice to have --base option, and show only the commits
<base>..<branch>.

Cheers.

-- 
Felipe Contreras
