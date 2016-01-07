From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] worktree setup broken in subdirs with git alias
Date: Thu, 7 Jan 2016 16:31:00 +0700
Message-ID: <CACsJy8BVys_0yLjt0Ttk2TsYeNmF5UKqqyraNJ532VB7tuKSKg@mail.gmail.com>
References: <568E10A7.5050606@drmicha.warpmail.net> <CACsJy8CRJhdb9Gf+SkC+BSHuGa0DPEBZnCDRUa7zkJvrBK72kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 10:31:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH6uv-0001Cr-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 10:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbcAGJbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 04:31:33 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35919 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbcAGJbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 04:31:31 -0500
Received: by mail-lf0-f54.google.com with SMTP id z124so323514313lfa.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 01:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LmB1MWRxlnV49EZ3BVWACpVYCdyiKUdnMa5xe7hbY3E=;
        b=zETRO1aw2/LcxjMTtSqO8efw8uDAdpElxUI/Kf52nFDEhI/JtU+AV/ZopJSHkdZpPP
         n4w1SQnSedJYm6hnUdUYn5gLMt0dQ5gv+T4oybBc2LIPr5oZchVHQnHegaD0aSTm5M8K
         mC+iimlYg/Q/PzQyxN5oviu2aQvsfCKtai8p2V/U8iV/2j59Y5JcjYdVMO/XblcnKWFA
         LqFpmIrjIvIrCDSUVcYi79AhYsMOFHupB5/VIgdsEYHlKLauDznPExjeqxBYhKs/N4/X
         7n39/SLsjqgu8daNbJu7nGxPUxjAjH9GHAbKNylOIyjCAOdLc7JQv6DcAMwSkf/yF9Zr
         1EWQ==
X-Received: by 10.25.157.135 with SMTP id g129mr473681lfe.45.1452159090060;
 Thu, 07 Jan 2016 01:31:30 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 7 Jan 2016 01:31:00 -0800 (PST)
In-Reply-To: <CACsJy8CRJhdb9Gf+SkC+BSHuGa0DPEBZnCDRUa7zkJvrBK72kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283473>

On Thu, Jan 7, 2016 at 4:26 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> You forgot to mention what version you used.

Gaaah i need to work on my reading skills. You did mention 'next' in

>> sorry I can't dig deeper now, but the worktree code from next seems to

So it matches my expectation. Merge branch
nd/clear-gitenv-upon-use-of-alias to fix it.
-- 
Duy
