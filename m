From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Core dump on commit
Date: Mon, 15 Aug 2011 22:26:42 +0700
Message-ID: <CACsJy8CKFeSXy-QV=qdgtax92TdWCfem9rC-FYzptjd1JA1+AA@mail.gmail.com>
References: <loom.20110815T162144-798@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Marko Vukovic <amasniko@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 17:27:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsz4Q-0007c3-5t
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 17:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab1HOP1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 11:27:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39822 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256Ab1HOP1N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 11:27:13 -0400
Received: by bke11 with SMTP id 11so3066289bke.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pB+v9gaEyFY2owIp7xq0Gn5KP6Y9v60zzyoPG3bGY3o=;
        b=nL9Z+6e4v/1rEQFHU4alwJFCS4xAoDztxpssfhyU5qC5igdzZcJeQ8pTlneVecu5p0
         gLYTOfn9C/aVbivfXXHv0BpeQ2vhUoihsj7j+zcqQyR7/cF4C9AxMcEzQTAUoLTj8HWj
         pn2Ar7NwAR9dNusylTPNzWdRPnjxoN39usV6E=
Received: by 10.204.231.201 with SMTP id jr9mr616789bkb.279.1313422032137;
 Mon, 15 Aug 2011 08:27:12 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Mon, 15 Aug 2011 08:26:42 -0700 (PDT)
In-Reply-To: <loom.20110815T162144-798@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179373>

On Mon, Aug 15, 2011 at 9:30 PM, Marko Vukovic <amasniko@yahoo.com> wrote:
> I get this error after running "git commit"
>
> error: Object 42504431bac2e2054483c1bbc35f1b535f8d11bb is a tag, not a commit
> Segmentation fault (core dumped)

If I put a tag to HEAD, I could reproduce this. Let's assume that "git
cat-file -t HEAD" in your repo returns "tag", how did you create the
last commits? Did you modify a ref manually? What git version did you
use?
-- 
Duy
