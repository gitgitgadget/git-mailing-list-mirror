From: Pat Notz <patnotz@gmail.com>
Subject: Re: Should --pretty=format:%b respect i18n.logoutputencoding just
 like normal "git log"?
Date: Mon, 19 Nov 2012 10:42:48 -0700
Message-ID: <CADvGaErNPyHEP029-M-UWtDUaH0xJstXUc+9FGuy-7YEUM0zpA@mail.gmail.com>
References: <CACsJy8Ag7wZCKeTM-fW7MUjWs=7xq7ciwhfx4kroJupwvs0dXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:43:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaVNV-00081o-J2
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 18:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab2KSRnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 12:43:10 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35156 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab2KSRnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 12:43:09 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so5075340obb.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lN18TNJY4JbARsAa55qo1PYrYFlnpWIBk4ix/a17JhE=;
        b=C7UW+PKDQEOtekK8hrfrbBcBJcEBTrS/ktwuAuaYKdCQLEH2KgTK8ok2mbLdjLUx0W
         bW4K5m4sHeIIYosQNkUfdAKraJS+NwfgXIhlgqXF0C8zAm0db2T6XhHM4hFYfunIXw+7
         eDoc3lEu03d7OCmCbvA3k9KPODubijzeVv6JZTYszvKkqHiLR9Yl+MOSZKojvLDoO+N5
         xY2b4zjeNuVVXgp8CS+6x2tBSkjuaJ0iR4rCUgCOHHAo7UGoHC/wouM2Zud3P5bmk39a
         qqhe/mYLFHdRfvPIrHcxYZTbegBdBLSH2fKDgGjQBHrfOOznirw06JTWvTOX2F4C3Fuj
         +CFw==
Received: by 10.60.171.146 with SMTP id au18mr10826913oec.25.1353346988937;
 Mon, 19 Nov 2012 09:43:08 -0800 (PST)
Received: by 10.182.80.229 with HTTP; Mon, 19 Nov 2012 09:42:48 -0800 (PST)
In-Reply-To: <CACsJy8Ag7wZCKeTM-fW7MUjWs=7xq7ciwhfx4kroJupwvs0dXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210047>

On Mon, Nov 19, 2012 at 6:08 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Changes around this code in history is a bit unclear. User format
> learns to get log encoding from a field in 177b29d (pretty.c: teach
> format_commit_message() to reencode the output - 2010-11-02), but this
> field is only set for --fixup and --squash (in a few commits later).
> This makes "git log --pretty=format:%b" always ignore the output
> encoding config key. I don't think %b output should be different from
> normal log output, which does respect output encoding. Pat, any
> reasons not to do it?

Nope, that looks like it was an oversight on my part. Nice find.

~ Pat

> --
> Duy
