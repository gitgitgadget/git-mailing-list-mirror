From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 16/23] worktree: add -b/-B options
Date: Sat, 4 Jul 2015 10:19:23 +0700
Message-ID: <CACsJy8AYFC+FW1bgSJwW34p6s2zn_6A4GhBaJjB8o8rxUvY72g@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com> <1435969052-540-17-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 05:20:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBDzp-0002jj-8z
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 05:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbbGDDTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 23:19:54 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33815 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233AbbGDDTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 23:19:52 -0400
Received: by iebmu5 with SMTP id mu5so85410583ieb.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 20:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BPm7QGJ4rlGi4wJaSccd5HhySmpF2WiIYi/c3B13s+A=;
        b=CLVCBw5y68TC2sazk0VxMiGNfnOXfTWbwJQkwBDdBA0BHl5CB3Kw6qqKliJXz9r0Lf
         BBG2i1WxIqAqZ1mOXrl/F8jUqFPkiI1eCTGtWrt2T8Hxm+XW1lWrmzhWbVD4QG6mmYxx
         yY6TTlceU2K4Ozu3kPYbj4z1VXUVgCP7W0k0+/8wvjpDv2B6gxs7owT1UJycy0iUCqWs
         U3NDBPzSuSmAmKO7k4t8dmsejVQXhnbGB/dLmHYfThHOAF5jKqqfwqalabteEbI5hThi
         BNLIgAh0qYkj6MKtr9pef463zMaa98MDLioI84cxZ3Cg5x81u6gCQgfG6XF9F3PzaQNK
         Lgew==
X-Received: by 10.107.128.72 with SMTP id b69mr56206206iod.84.1435979992341;
 Fri, 03 Jul 2015 20:19:52 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Fri, 3 Jul 2015 20:19:23 -0700 (PDT)
In-Reply-To: <1435969052-540-17-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273350>

On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> One of git-worktree's roles is to populate the new worktree, much like
> git-checkout, and thus, for convenience, ought to support several of the
> same shortcuts. Toward this goal, add -b/-B options to create a new
> branch and check it out in the new worktree.

There are some other  ref manipulation options we can bring over like
--orphan and --track. But you can totally leave them out and we can
add them back when people actually need them.
-- 
Duy
