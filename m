From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow safer?
Date: Tue, 25 Nov 2014 17:55:08 +0700
Message-ID: <CACsJy8C5F7JPvfpGPOPy0oT=1YrhLeheF9fc29PgkAK=SnhXww@mail.gmail.com>
References: <5468C33E.2080108@whonix.org> <20141117212657.GC15880@peff.net>
 <CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
 <CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com>
 <20141125012359.GR6527@google.com> <CACsJy8C3Bfruy=usn9MajmLP_10s2zf8AFZJmxyeGSPDS9SwVQ@mail.gmail.com>
 <20141125034730.GB19161@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nico Williams <nico@cryptonector.com>,
	git discussion list <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 25 11:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtDmc-00037Z-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 11:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbaKYKzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 05:55:42 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:55826 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbaKYKzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 05:55:39 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so4756023igb.17
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 02:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ak5DMso0qQ4/un8Sc9pnanlLFeLxLggfL7bZrp8l0UE=;
        b=ufUR0cScQ5BZUKPOUE2LNboSjk8/q84QVlcEdaLIXhwnoUw8/atpmiIL88VYdmcCCk
         3v0WvVX+Dh35fYuY3Lfnz/lohIP5kPejj/gxRI00uRUpThHxR3YObGSgSHOCQpnzunY3
         KOh6oKFXrAB5RpFIZCpXr/eN0MvSTXLyWqNPpCNK7NnWVGpCCXMkm75ONaA3lA8w5Hl0
         FEaSDU4d2vyVVIubt5VlLR+FctMlDNzvs9tQk5atd2x4f8v9quFGaHw58/Bu1/aq26Dj
         MO7wk8E7tVMkuUbsCwPgSSR9l0CZo7GN3U8JXK+GPkmcsm3/UvpSRKLCkAF/CNnZTiwS
         LjRw==
X-Received: by 10.50.43.202 with SMTP id y10mr16538141igl.41.1416912939128;
 Tue, 25 Nov 2014 02:55:39 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Tue, 25 Nov 2014 02:55:08 -0800 (PST)
In-Reply-To: <20141125034730.GB19161@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260208>

On Tue, Nov 25, 2014 at 10:47 AM, Jeff King <peff@peff.net> wrote:
> Maybe we can fix the tree-sorting order while we are at it. :)

At this speed, there a teeny tiny chance that pack v4 will be ready by
Git v3.0 and we can pile that on top of the new tree format. And we
don't have to worry about v3<->v4 online conversion either because
it's backward incompatible ;)

> More seriously, there may come a day when we are ready to break
> compatibility completely with a new "Git v3.0" (2.0 is already taken, of
> course). I do not have immediate plans for it, but it's possible that
> multiple factors may make such a move desirable sometime in the next 10
> years, and that would be a good time to jump hash algorithms, as well.
>
> So it's possible that procrastinating on SHA-1 issues may be the least
> painful route. Or it may just be pushing off the day of pain. :)
-- 
Duy
