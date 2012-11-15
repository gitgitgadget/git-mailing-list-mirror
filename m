From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: use cases for git namespaces
Date: Thu, 15 Nov 2012 18:09:03 +0530
Message-ID: <CAMK1S_iWZyH5j7GdGj7Fuj=kn+zZ0wCZTSFXxjspGpcA+x-iSw@mail.gmail.com>
References: <CAMK1S_gczLajro0aZ5ftUmt_vhxA+yAr_5pCZknJ2bxhykYRXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 13:39:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYyj2-0003ad-NK
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 13:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767685Ab2KOMjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 07:39:06 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63192 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993283Ab2KOMjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 07:39:04 -0500
Received: by mail-lb0-f174.google.com with SMTP id gp3so1254285lbb.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 04:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=5YyMMvUq1uGgpkldmkT8GapneE8/On2owjtl7H/nq2I=;
        b=pQx0zEdOXnxaIhoigcSD9YwlodeZ15kjVK4dlUjSK9bKhMxDybNgZsfopWIsHdu4J0
         3kjmgTKxvlT64fiHrQxuFqVeD/B/7p6Qt9zfrvvW2jc2zFYURVxmdslwtA/tlddXOMrD
         uaqBACDglgNYL/oqiosSDvGFCPsiiNcwaekCf8qKwj5jC5qq6XFOW2GWHAlCrLTpYn6l
         0sjDx0Es6Fwdy0pC4nwnFZD499143vA+CM4WnKyaRWCH1fYgUS4YFwj0QO6Ts32IwvhD
         f61XqHq0B1n+vTgfDRZ6e2Z8+V2t/X6mXEzjfgcMEqk6MSdZzDqqMbsd5TGSkB7yZCqr
         Hzgw==
Received: by 10.112.29.129 with SMTP id k1mr539046lbh.102.1352983143306; Thu,
 15 Nov 2012 04:39:03 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Thu, 15 Nov 2012 04:39:03 -0800 (PST)
In-Reply-To: <CAMK1S_gczLajro0aZ5ftUmt_vhxA+yAr_5pCZknJ2bxhykYRXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209820>

On Thu, Nov 15, 2012 at 2:03 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Hi,
>
> It seems to me that whatever namespaces can do, can functionally be
> done using just a subdirectory of branches.   The only real
> differences I can see are (a) a client sees less branch clutter, and
> (b) a fetch/clone pulls down less if the big stuff is in another
> namespace.
>
> I would like to understand what other uses/reasons were thought of.

(I should mention that I am asking from the client perspective.  I
know that on the server this has potential to save a lot of disk
space).

> I looked for discussion on the ml archives.  I found the patch series
> but could not easily find much *discussion* of the feature and its
> design.  I found one post [1] that indicated that "part of the
> rationale..." (being what I described above), but I would like to
> understand the *rest* of the rationale.
>
> Pointers to gmane are also fine, or brief descriptions of uses [being]
> made of this.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/175832/match=namespace
>
> Thanks
>
> --
> Sitaram



-- 
Sitaram
