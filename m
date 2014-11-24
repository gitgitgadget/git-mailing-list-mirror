From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Mon, 24 Nov 2014 08:23:27 +0700
Message-ID: <CACsJy8D-W_YrxMgUDScSmkNBKMVpRu_Kc0k6nsfyhmoLg5HBjg@mail.gmail.com>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Patrick Schleizer <patrick-mailinglists@whonix.org>,
	Git Mailing List <git@vger.kernel.org>,
	whonix-devel@whonix.org, mikegerwitz@gnu.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 02:24:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsiNp-0000uU-US
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 02:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbaKXBX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 20:23:59 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:58022 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaKXBX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 20:23:58 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so7749522ieb.26
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 17:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r2EwP44qnER7oFy1UfKOeu8yZ5vXSF3rwGUQSh6wXX8=;
        b=RPrMcaIZWhaH0oRS7y60Oy9EZAIRVwoc1lMa4cR3V9pLToWvJY7f7QenbKDjZO+p8f
         YQTcaJe3kj+HdCOk5DSFubPLmUNyWT1hxVAnCDhdC9xpl2LdM9uw3wbOaEq5w+UOMGbC
         8pMLjpGWq6Bv0HLJvLWo87jRBgQQVHbPNyHAsnkgGDy4Oj6zCMSXHggBXHHBECBlTGs4
         6l4HdXB71UAD7qAVuMuWPN5hwGC14VS+1ewQwlKucYGhzFVE8HBfdXvFrPPz1sB2q5nP
         G782FBVWAApVGkyuHNVEdduYVSVnWLSVbWqKPu2SWrO5hyy75E/yj/L5W6F9aiHn7zhy
         TT+Q==
X-Received: by 10.42.167.1 with SMTP id q1mr22127423icy.48.1416792237781; Sun,
 23 Nov 2014 17:23:57 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Sun, 23 Nov 2014 17:23:27 -0800 (PST)
In-Reply-To: <20141117212657.GC15880@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260111>

On Tue, Nov 18, 2014 at 4:26 AM, Jeff King <peff@peff.net> wrote:
> Yes, it is only as "safe as SHA-1" in the sense that you have GPG-signed
> only a SHA-1 hash. If somebody can find a collision with a hash you have
> signed, they can substitute the colliding data for the data you signed.

I wonder if we can have an option to sign all blob content of the tree
associated to a commit, and the content of parent commit(s). It's more
expensive than signing just commit/tag content. But it's also safer
without completely ditching SHA-1.
-- 
Duy
