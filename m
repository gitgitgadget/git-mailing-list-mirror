From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 16:53:29 +0700
Message-ID: <CACsJy8ChOd-684V8Dsbwf2nOsW8UMnYn_vo5MAZ6ixyq_QvMkw@mail.gmail.com>
References: <5060097F.9050203@drmicha.warpmail.net> <CACsJy8DHGtktnvvziA_+Fp6a4VFsE9_=zkWKNBJU7Ro_QO+==A@mail.gmail.com>
 <50601274.80506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 11:54:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG5Mi-0006Qm-4A
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 11:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab2IXJyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 05:54:03 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64460 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab2IXJyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 05:54:01 -0400
Received: by ieak13 with SMTP id k13so10340439iea.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+Ho6SH0OKRkZx1fCHDZQeV5FmB0T+kl4TeKcWE5ekM0=;
        b=DR7ixnFPXj6YFRK5UGCAA1TfjYGPqpYP7InF+X4vxAO+PfTYkXXtnvIdyAAOET+93+
         2mzgruGNqEVjLw76JIPDszZXGMEbQkc1kETS4aNWRUioOEhQ/bRGeAEGYD14rZT+gGry
         T9QYubnNuDOmewIZJvVb8SWRMIJbVAQS3ADOjeXmTD7mytKKQ2L62gJXode0nUzGrWnH
         4K1gZWdDx8AtEqFDJASoyx8X5qYUjbnFZ/urtdtI/jbbyqasKOhL0C7Ae9kw3ZYGfj4u
         dwnCrvTCggNh28gR+XvFtJCjasx2EGOXZWFuHWVyQlPmZmsDte3HcYPBruOwrrkAqvAP
         AjFg==
Received: by 10.42.129.83 with SMTP id p19mr9308647ics.9.1348480441358; Mon,
 24 Sep 2012 02:54:01 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Mon, 24 Sep 2012 02:53:29 -0700 (PDT)
In-Reply-To: <50601274.80506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206259>

On Mon, Sep 24, 2012 at 2:57 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> It might be difficult to implement, but I'm sorry I can't follow the
> argumentation above at all; it's not based on what we do in other places
> and other cases.

My point is, what's so special about --git-dir? what about
--work-tree, or "commit -F path"? It's hard to draw a line there.
Config files are a special case, because git is the only one that
reads the file. "~" expansion depends on shell setting. If users turn
it off, they may be surprised that "~foo" is turned to /home/foo while
they really mean "~foo". Warning is the only sensible thing we could
do.
-- 
Duy
