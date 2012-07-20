From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git with large files...
Date: Fri, 20 Jul 2012 19:28:50 -0400
Message-ID: <CACPiFC+a=46n-igTUBSDdpgDQyL4cz5vrcpurNBSsb+D1c0UnA@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com> <86fw8mf3gp.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 01:29:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsMdK-0007tf-NV
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 01:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab2GTX3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 19:29:14 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:44313 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab2GTX3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 19:29:12 -0400
Received: by vcbfk26 with SMTP id fk26so3435958vcb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 16:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lVUiQx/dT2OHN+aZooJAjms8nEuuvQ1Cy18lRKmGuAU=;
        b=zzg3g/gtxBf5svcqDKkzly3Lj3gEESeTdygaQw9V4vl8NNAB9CL8IiN+1Rka+Z7Oxe
         4rO4WD9+Z/Y0ZkOkYIqbmKlq7yOQnh1vQ04uNzRK+O22ozNQZUzlVntV5sTAbjnkBfL6
         G09vcJWa7zqcLS/RMRGG1rieLGDtaSjcZMbHIc+foHqXhcdsG/NbpDUL5QQfm4TphcFG
         RA94faH/jASNOPGDPaxRCSXJwG77wpv3LEIXxQW8feyMNkEYz2fvfCkLj1QByg8gnoNM
         +xQlcmg/GB1ndzefP9I32qWdoBzVnFj18lID2qVaUvDJTgUdo6dz6pR4Bwqe4OdzrLLB
         tG+g==
Received: by 10.220.153.7 with SMTP id i7mr5424558vcw.34.1342826951617; Fri,
 20 Jul 2012 16:29:11 -0700 (PDT)
Received: by 10.52.162.34 with HTTP; Fri, 20 Jul 2012 16:28:50 -0700 (PDT)
In-Reply-To: <86fw8mf3gp.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201797>

On Fri, Jul 20, 2012 at 6:54 PM, Randal L. Schwartz
<merlyn@stonehenge.com> wrote:
>>>>>> "Darek" == Darek Bridges <darek.bridges@me.com> writes:
>
> Darek> I use git for many things, but I am trying to work out the
> Darek> workflow to use git for deployment.
>
> Don't.

Heh. Best to keep in mind that it just doesn't work very well.
git-bigfiles, git-annex might help you, but look at the docs and
caveats carefully.

Perhaps use rsync, unison work better for you.



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
