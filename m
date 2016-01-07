From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] worktree setup broken in subdirs with git alias
Date: Thu, 7 Jan 2016 16:48:21 +0700
Message-ID: <CACsJy8BrvFi2uL1KVxrRDnPRAikpLwWcSSu8udfFBzEz7P6QMw@mail.gmail.com>
References: <568E10A7.5050606@drmicha.warpmail.net> <CACsJy8CRJhdb9Gf+SkC+BSHuGa0DPEBZnCDRUa7zkJvrBK72kQ@mail.gmail.com>
 <568E3282.1060508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 10:49:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH7Bh-0006R6-PE
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 10:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbcAGJsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 04:48:53 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35451 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbcAGJsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 04:48:52 -0500
Received: by mail-lb0-f180.google.com with SMTP id bc4so204094348lbc.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 01:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ervPtgLqdet6xUo7e57CD4JaSiUzCS1DiVPaf2c3h2Y=;
        b=FYvCPhUKxSBsH4HbYNjfYyeIR5O5slZ/RlnjrLAYs6O3ENH2DGGRt2MrBzR/cmhHkm
         6siyYjoY0xTBrceRFhvNoJ1F7nCLRF428l0LWInlSl4jy1J7HVOCYQJp3rQeOd9tq4aJ
         zLPU8eLSM5O7CDSjXA+BChXeJi2wueC6aBs9OgpovZcuBPwmZxRjxE3qyTfX4XOMscSh
         y0G72mBqSF7HMxnQpYaUU8SS4AojeP8BAhXey/uPr5p0ncaRFOxldD4Kda3fW6h8zfie
         3qkRV5PiBJjxFe7vPeY0LDrpR6G5jjGNZ5YjmbhjksbWiRxhhSDvEeFlWTZL0ueblIl/
         qAHg==
X-Received: by 10.112.149.230 with SMTP id ud6mr14681155lbb.12.1452160130890;
 Thu, 07 Jan 2016 01:48:50 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 7 Jan 2016 01:48:21 -0800 (PST)
In-Reply-To: <568E3282.1060508@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283475>

On Thu, Jan 7, 2016 at 4:40 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> As for the fix on pu, do you mean that one:
> ac78663 (run-command: don't warn on SIGPIPE deaths, 2015-12-29)

And the three commits before that, if you cherry-pick instead of
merge, so 0d5466d to ac78663
-- 
Duy
