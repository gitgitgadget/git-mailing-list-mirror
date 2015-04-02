From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] init: don't set core.worktree when initializing /.git
Date: Thu, 2 Apr 2015 11:49:05 -0700
Message-ID: <20150402184905.GB5467@google.com>
References: <0FD999DB-3DBF-40D4-8128-715BDC49EAAB@free.fr>
 <20150331181552.GC19206@peff.net>
 <20150331183423.GD19206@peff.net>
 <20150331191420.GE22844@google.com>
 <20150402183739.GA19911@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cedric Gava <gava.c@free.fr>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 20:49:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdkAy-0004fv-1k
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 20:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbbDBStK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 14:49:10 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35902 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbbDBStI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 14:49:08 -0400
Received: by igbud6 with SMTP id ud6so84391262igb.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q+LKVO831wHroyN4lfGDTnxFEvuy6616wBDedsTgUnI=;
        b=tM9NI+7IbGp5irl0lH3XYad+b9YggVBVpV/MiVGLaxsyADRRllk/jZMHZs+exPt17l
         isMjVY+j6+kgH3C+BFGE7rEtYjVJ+X+OBoYB4UxGLdM3ElbNfAwGlJJrnD6Vm9xapUfd
         nev/Z+Dav1NNZAvqc8XatQPk4ode8UcUklUMU9BC8PpCTbaAq6aCT0+KiLaw8Fhzo0qi
         YBbdXAn/HAjHFnrFFobNr8GI6nY8MOgh6Do6buRk9v0LsZoMSIn8oaGJl+MekWZC9JpL
         LG1Ay3wHzUUj3fJayQVwLRMggnoSEfRYww+xsAuUbcWRWTdHSw4YeI18voxzcMWUVlQD
         KDEw==
X-Received: by 10.50.122.68 with SMTP id lq4mr22102992igb.10.1428000547601;
        Thu, 02 Apr 2015 11:49:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:e164:8d21:5db5:d6c0])
        by mx.google.com with ESMTPSA id w3sm1735389igz.1.2015.04.02.11.49.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 11:49:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150402183739.GA19911@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266655>

Jeff King wrote:

> OK, dropped. Here's the re-roll.

Thanks.

> -- >8 --
> Subject: [PATCH] init: don't set core.worktree when initializing /.git
[...]
> No tests, as we would need to be able to write to "/" to do
> so.

This is confusing in the light of t1509-root-worktree.sh existing, but
anyone curious can dig up this mailing list thread so I don't mind. :)

[...]
> Signed-off-by: Jeff King <peff@peff.net>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yep - still looks good.

Regards,
Jonathan
