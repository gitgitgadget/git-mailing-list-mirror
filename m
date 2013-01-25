From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 6/7] mergetools: Fix difftool/mergetool --tool-help
 listing for vim
Date: Fri, 25 Jan 2013 11:34:35 +0100
Message-ID: <CAHGBnuMPQWr8Z9jeQmHs7wFN5kf=MwBEEDy_M-QeY0mRnSke_g@mail.gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
	<1359107034-14606-7-git-send-email-davvid@gmail.com>
	<51025D1C.2030307@gmail.com>
	<CAJDDKr4yb1-C9W1ZnKxHUk7WKpq-EN_YiR6diHCm5DVtQWzeCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:35:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tygcd-0004xl-F7
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 11:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab3AYKeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 05:34:37 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:46378 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab3AYKeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 05:34:36 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so446481lbb.12
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6spENuStOTF4aIrviM/Y3N9iH+zGZBQm4me/QvnBahg=;
        b=YzTy7ny483oYHPOm4gNsgZTFp48R6QK7RqVpoPuNFOlzOmRwaUuUDZADjcEVq6f+O5
         naLrj26pf31ljg5FprmXzoQhKc86yGaDZLckqVAJ9HDpVoCzqrahFhdIFp6EO5OLkhyc
         Chdef3HyFOt3QZOnh2IyvrgVXTWp3WHCWxNOYJFzkRAvMrA6mNZqFAHYE8Y2l8wIW4wT
         5aDDKTa0/a5CVNanAJE9OkvXuzYlIZG44kAG+PE/SxVSSYknqIw+ySoXCFWXHestaqHt
         9nyAFXAwcmWJHqrzQ6+KFSkuBveZ0beXmDqXZ47ToShC5PfPLdjnJgzET7hq38s4nMtn
         CrFg==
X-Received: by 10.112.100.195 with SMTP id fa3mr2055698lbb.38.1359110075236;
 Fri, 25 Jan 2013 02:34:35 -0800 (PST)
Received: by 10.114.22.73 with HTTP; Fri, 25 Jan 2013 02:34:35 -0800 (PST)
In-Reply-To: <CAJDDKr4yb1-C9W1ZnKxHUk7WKpq-EN_YiR6diHCm5DVtQWzeCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214539>

On Fri, Jan 25, 2013 at 11:28 AM, David Aguilar <davvid@gmail.com> wrote:

> I thought Git did something sensible there like create a normal file?

It does not. Also see my answer over here:
http://stackoverflow.com/questions/11412028/git-not-storing-symlink-as-a-symlink-on-windows/11412341#11412341

> If not then I was thinking we could add a provides_tools() function that
> each scriptlet could supply.

Or maybe simply introduce scriptlets that do nothing but include /
inline another scriptlet?

-- 
Sebastian Schuberth
