From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH] tag.c: remove extern keyword from function definition
Date: Wed, 20 Apr 2016 11:39:28 -0400
Message-ID: <20160420153928.GA1314@LykOS>
References: <5717A181.1000603@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 17:39:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuE3-0001Bi-Qz
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 17:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbcDTPjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 11:39:32 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33603 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbcDTPjb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 11:39:31 -0400
Received: by mail-qg0-f41.google.com with SMTP id v14so31012405qge.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwsFKxiJCQBNBOYZDtGpRzl0+V0LiKmMADrOIiMqaok=;
        b=oZivT81l/+O2av4kvZMY1iA/CqRgOgWu4yRl+GiJEEreTON9iVP1MZpVVkLQvpQ1NJ
         F9sWKaHe6FVGNuEf2UaWXff4A5xNiZgaexnjKW9wkp71kMMX4ZBtvbF0FijUgeWYvJxP
         z/Tc7kfGPSw+HfIsI+IQEag/jkC+mVHzVsMHpufjWAiBdNLZE2mR7yj1lwELJ5525y+e
         Sh56A2HyzfQ2/i6icRW9Obz1cnlz9njB3Er2HRoYllzsuc9aE1HriOStmBckIF6QOuwl
         l2OCjtoQI/8iVm7AEXOAAXkaRVK4IT8gdUyoA84Z71RBW2QeMODALRgce2Y/LGV1iNAK
         LhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwsFKxiJCQBNBOYZDtGpRzl0+V0LiKmMADrOIiMqaok=;
        b=ms2b6UgX1LJ22IZOl6kv62/TpmZeADIikm4vKfLbA0tU8R7WoDdYI/nh87z1E+mY1j
         Yk2qgm/DgRxGfRQj7D7/NAl85ehUay6/2ni1h6YnePg08i/X/9TktFDsWaEM+3BwiCyY
         0/EgJySGXDgoDm6kzz7SYkVSf462TX0hFZKSCJSeszffAfPYxrlGzHmx1eWGxICP4ghm
         Wg5NXB2AcTdvZRGnOrXUNd35Otb5iNP9AlzaHsOj8HnEhsmOK4XhenD9mQO3mXvFz+8r
         XxlHnkTtuSL62jShv8pBGvjIvQhtL+z01TxJ9u/znDEKSRUQb6e92aTB+XB7Nz0PhDnW
         vflg==
X-Gm-Message-State: AOPr4FX91Jw+kmxOpgJ6EAFlGh6nKSfMu4dr+HCAFAFkGxM0C1W1lYmG/416um4uU5k6X89X
X-Received: by 10.140.98.175 with SMTP id o44mr11917281qge.46.1461166769751;
        Wed, 20 Apr 2016 08:39:29 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id 79sm31056524qgj.20.2016.04.20.08.39.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 08:39:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5717A181.1000603@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292030>

On Wed, Apr 20, 2016 at 04:34:25PM +0100, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Santiago,
> 
> If you need to re-roll your 'st/verify-tag' branch, could you
> please squash this into the relevant patch (commit c5213b40,
> "verify-tag: move tag verification code to tag.c", 19-04-2016).
> 
> Although not actually an error, it is very unusual for an extern
> keyword to be used on a function definition (it seems to be getting
> quite unusual on a function declaration these days!), which causes
> sparse to issue a warning.

Oh sure! I'm waiting to see if there are more reviews regarding this and
I'll re-roll. It's defintely unecessary to have the extern keyword
there.

Thanks for pointing it out!

-Santiago.
