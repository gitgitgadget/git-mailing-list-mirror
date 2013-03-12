From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: [PATCH] difftool: Make directory diff symlink work tree
Date: Tue, 12 Mar 2013 17:12:28 -0600
Message-ID: <7906294865355046191@unknownmsgid>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan> <20130312192459.GD2317@serenity.lan>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 13 00:13:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFYNW-000621-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 00:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933856Ab3CLXMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 19:12:33 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:65408 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933574Ab3CLXMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 19:12:31 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so362891pbb.27
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 16:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:from:mime-version:in-reply-to:date:message-id
         :subject:to:cc:content-type;
        bh=y0R1UJ0UzhhQokGu8yRUEne+VdJTw/7Lza8gNzrx2+o=;
        b=y/xAkdIbDSabMw8jBV7h7nc2tk3RbkRs6w/fEn3a1FxKltmJZ/RJKcIi+61ACfHcQq
         m9jexKoa5zCuOGtuYWi8sk6QjpMNcRfohQl9Fwl7mol5f/y+9qGh7QK0W4LTzch4UmnW
         +K1wl23rDH4TYtra8Wd/ZlBi9YmeZCxHPqm/vvo5tu0so5Pn635v1+NMGlMFMsg63fDf
         TIKc+YWGvIYWrFDEEZQo1Ux2XUntK2SWwBcWi318tqNWHonkMrJ40JhBgKWjIMwbYBgf
         sD/rQO/UHhoJLH7YB4d173AoG8lvUzyyvIaI/LUVx9VyL9FRyPOeGzhBrN6qjbKG1v0L
         nvbw==
X-Received: by 10.68.176.68 with SMTP id cg4mr9002165pbc.49.1363129950605;
 Tue, 12 Mar 2013 16:12:30 -0700 (PDT)
In-Reply-To: <20130312192459.GD2317@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218007>

On Mar 12, 2013, at 1:25 PM, John Keeping <john@keeping.me.uk> wrote:

> When I tried this I got the expected behaviour even without this patch.

    git diff --raw commit

emits the null SHA1 if the working tree file's stat differs from the
blob corresponding to commit. Is that the case you observed?
