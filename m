From: Pascal Obry <pascal@obry.net>
Subject: Re: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 15:06:12 +0100
Message-ID: <a2633edd0901300606ub4c507bocccb6747b436f01f@mail.gmail.com>
References: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
	 <adf1fd3d0901300318s5a0e4c94gab5f31342643ea52@mail.gmail.com>
	 <a2633edd0901300456y48e8d78fn199675f2ae105c8@mail.gmail.com>
	 <adf1fd3d0901300516y3d1bf58dmda9c5172586d828@mail.gmail.com>
	 <a2633edd0901300535mf2d9ceemd9e9009e0aa18b40@mail.gmail.com>
	 <adf1fd3d0901300557t19ca4bccn7fe24013a05d2d57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:15:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSu92-0000Jz-Cw
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 15:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZA3ONb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 09:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbZA3ONb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 09:13:31 -0500
Received: from mail-bw0-f12.google.com ([209.85.218.12]:63245 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbZA3ONa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 09:13:30 -0500
X-Greylist: delayed 2235 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jan 2009 09:13:30 EST
Received: by bwz5 with SMTP id 5so45722bwz.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 06:13:27 -0800 (PST)
Received: by 10.223.115.12 with SMTP id g12mr1080803faq.92.1233324372228; Fri, 
	30 Jan 2009 06:06:12 -0800 (PST)
In-Reply-To: <adf1fd3d0901300557t19ca4bccn7fe24013a05d2d57@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107824>

Santi,

Thanks for your patience!

> gitk topicbranch ^trackingbranch
>
> But I agree that a way to refer to the tracking branch would be great, as:
>
> branch^{origin}
>
> so you can say, for example:
>
> gitk topicbranch ^topicbranch^{origin}

That's exactly what I'm looking for!

> At least part of. You have to understand the branch model:
>
> git model:
>  * a branch is just a pointer to a commit
>  * you cannot say "this commit was done in that branch"
>  * what you can say is "this commit is contained in that branch"

The second point wasn't clear to me.

I had 2 out of 3 OK :)

Thanks.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
