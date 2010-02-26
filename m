From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] refactor commit_graft_pos using general sha1_pos function
Date: Fri, 26 Feb 2010 11:04:25 +0800
Message-ID: <be6fef0d1002251904q59e12149lc3010b3587b00f8c@mail.gmail.com>
References: <4B87EBD2.3060007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: jackylee <jacky.liye@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 04:04:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkqVG-0007wh-5l
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 04:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935058Ab0BZDE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 22:04:28 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:38364 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935031Ab0BZDE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 22:04:27 -0500
Received: by iwn12 with SMTP id 12so5900317iwn.21
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 19:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=X7G1L7RobhkCQZGJYpAcBAxsuoE7aCoULnZsCHDHJJY=;
        b=m8y3QoDiHn0lfaH/B0l6Lk0r2lJwF2vy3F/Kv8ZE1loWAQotga7J3ebai9b7H46zKU
         LRhP0YpRUbLEbWpMX5qdVvmuZfagNJfBZPdvQvdOkJ/ufutPpb5gYDZKxDM4qKYGL7Rn
         nbj9+b3Kpm1Q469Ne294pJqE3nW008ktY+1yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=P4BM4KPH5tntCqPM7qmMR7xZxHgCiC09di7Nbp2V12hZEsHbBkwNVeM0+joMvuU8p5
         M8FALFFrYRKQzEXFZY4kYCGRqO4UVfbscNHRf/fk/AG3M6bYcX4ZrMsRyh1Xpg6LPlNC
         KKqeYlrzIlDJWcT2bhKx5r1FrHbQ7XImGr4II=
Received: by 10.231.146.4 with SMTP id f4mr81622ibv.21.1267153466031; Thu, 25 
	Feb 2010 19:04:26 -0800 (PST)
In-Reply-To: <4B87EBD2.3060007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141091>

Hi,

On Fri, Feb 26, 2010 at 11:42 PM, jackylee <jacky.liye@gmail.com> wrote:
> code cleanup according to git janitor page, replace sha1 lookup function with "sha1_pos" general binary search function
>
> Signed-off-by: jacky.liye <jacky.liye@gmail.com>

please sign off with your real name. See

  http://repo.or.cz/w/git.git?a=blob;f=Documentation/SubmittingPatches;hb=HEAD

for the importance of the sign-off.

-- 
Cheers,
Ray Chuan
