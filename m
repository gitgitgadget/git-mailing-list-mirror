From: Andrew Myrick <amyrick@gmail.com>
Subject: Re: Efficiency and correctness patches for git-svn mergeinfo support
Date: Sat, 19 Dec 2009 14:15:56 -0800
Message-ID: <6b2f9b1d0912191415n560a5a58xbe6390b1fcade854@mail.gmail.com>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Dec 19 23:18:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM7d7-0008Em-9j
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 23:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbZLSWQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 17:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753472AbZLSWQR
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 17:16:17 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:51063 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbZLSWQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 17:16:16 -0500
Received: by iwn1 with SMTP id 1so2929837iwn.33
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 14:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=h03AGnvDKusPCQZAYO1kFwpwTtwGAv6VmEHaBXAYOBQ=;
        b=YkwI+R0Ew8SSVDyNPxU4yfz380z+VtIOEq0saiKO12y8H6/0ScQQo0UzgFYcPSjpuf
         6NBrkZq7btWM4EGgqzYaSSjryqbC8J8a07xRJBN1ygTRvVVSBkop3r4dRCfGDr3cF7DI
         2E2XuJV9+X0Fgu8eb7m86UQ9i8ji5CBdZonkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hZs1BalgRIbv3fjt618JsA/AqNFkuobVy+II7Bsy57WFTkjVlePb4Lagq8hM/aBxP4
         XYzyz0YOLXv3sud+DoZUjveAfodKcjuy1z4MgHtnHT4KExbn1fN6WU2ZDn4RUe0xb6j7
         aHerQxUvQVXHROgKsYUIaJD381uWggt8H8Tcc=
Received: by 10.231.125.100 with SMTP id x36mr3265950ibr.52.1261260976070; 
	Sat, 19 Dec 2009 14:16:16 -0800 (PST)
In-Reply-To: <1261240435-8948-1-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135503>

> It would be nice if the people who have experienced slow git-svn
> performance in these situations could test that this fixes the
> performance issues, and that the resulting repositories seem to have
> correct contents.

I tried cloning from a fairly recent revision that I knew was after
our switchover to svn 1.5, and I received a number of these errors:

   Couldn't find revmap for [branch]
   Exiting subroutine via next at /Users/adm/libexec/git-core/git-svn line 2983.
   Exiting subroutine via next at /Users/adm/libexec/git-core/git-svn line 2983.
   Exiting subroutine via next at /Users/adm/libexec/git-core/git-svn line 2983.

I'm not sure if this is expected, since I didn't clone from the whole
repo, but it did cause a lot of spew.  I'm starting a fresh clone now,
but it takes a few days to get through the whole repository.  I'm
fairly new to git, so I would welcome any tips on how I can test this
more quickly.

-Andrew
