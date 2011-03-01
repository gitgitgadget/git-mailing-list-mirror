From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Tue, 1 Mar 2011 18:13:12 +0700
Message-ID: <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 12:13:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuNWW-000516-NV
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 12:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab1CALNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 06:13:43 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58940 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab1CALNn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 06:13:43 -0500
Received: by wyg36 with SMTP id 36so4539089wyg.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=o57bV6RxbmcnAyXyfPpBWXB8+nUPRB0U+PkAJ625a8s=;
        b=ZwW8iWWN/yisdEW9kIEOtKO09BNOORiE8XfEJZNkDEXE0LlDvkgc0vW60H6AI4KAeF
         Y9CEEpMbAqn2tQI2+o3NP7l1fJ9EVqW0rlp5CrKFXugrakv6n7/WnX4ywMLBHItPJVLq
         VVnWDyHnmLxNhR0LzHtslLWHUyypzX/lC2w40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZPOsNe90L97T3eZMeciN8OsyehnXE/R2H8BH7513cdWJWouSZhTQ4sdy7oNON25dlb
         Fm1eF1d1JnREvUZ2qUEffrpF589VzSXKGs43K87mXSVK997mjZGDuLHy9THIqYZGyPDf
         Jx+UXqIwMS3HIosctRU5AEiMHxYcTDLXz2SvA=
Received: by 10.216.24.135 with SMTP id x7mr3310072wex.43.1298978022047; Tue,
 01 Mar 2011 03:13:42 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 03:13:12 -0800 (PST)
In-Reply-To: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168209>

2011/3/1 Michael J Gruber <git@drmicha.warpmail.net>:
> Introduce a leading ':' as the notation for repo-wide pathspecs.
>
> This is in line with our treeish:path notation which defaults to
> repowide paths.
>
> Heck: Even ':./path' works for pathspecs, and I have no clue why!

If you are going to turn pathspecs into something more complex,
reserve room for future extension. I have negative pathspecs that can
utilize it.

I take it, from now on people must refer file name ':foo' as './:foo'
with your patch?
-- 
Duy
