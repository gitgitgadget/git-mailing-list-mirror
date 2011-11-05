From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] fsck: print progress
Date: Sat, 5 Nov 2011 10:26:48 +0700
Message-ID: <CACsJy8AoEa3gR5dzTcscJRqjrfkv5_J+7Q2UVaYSjvSQyKJssA@mail.gmail.com>
References: <1320421670-518-1-git-send-email-pclouds@gmail.com>
 <1320421670-518-5-git-send-email-pclouds@gmail.com> <20111104201416.GA26591@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 05 04:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMWzQ-0001lr-41
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 04:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab1KED1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 23:27:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42586 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429Ab1KED1U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 23:27:20 -0400
Received: by bke11 with SMTP id 11so2481296bke.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 20:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6KsPXXItS1KmamfH8ivFJI6FSPGANQ74EmoXtQJPgKI=;
        b=ch/+TrqrFViz+vWRDXhOz7aGCtpx5DRCjs4qdf3VfENxr1aYhbrp3qzterrC3IcHfJ
         oCM4npmWjiN9RNYP+l0JPL60Nix49ePXBdRCwo+ribIwshKIh411Txn3K7qvGk6Uqq1K
         8CXtO7/sc6LBKzHptrpI2CneySlhhNhBHth0U=
Received: by 10.204.139.8 with SMTP id c8mr13480421bku.97.1320463639209; Fri,
 04 Nov 2011 20:27:19 -0700 (PDT)
Received: by 10.204.177.79 with HTTP; Fri, 4 Nov 2011 20:26:48 -0700 (PDT)
In-Reply-To: <20111104201416.GA26591@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184814>

2011/11/5 Jeff King <peff@peff.net>:
> Thanks, this is a good place to put a progress meter, too. If you're
> feeling like pushing this topic further, "git prune" might be a good
> place for a progress meter, too. It does a similar traversal[1] for
> reachability, and makes "git gc" appear to hang at the end (we have nice
> progress meters for packing, but it takes something like 25 seconds to
> run "git prune" at the end, during which we are silent).
>
> -Peff
>
> [1] I wonder why fsck doesn't use mark_reachable from reachable.c.

Thanks. I'll have a look.
-- 
Duy
