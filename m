From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: add missiong format-patch options
Date: Sat, 27 Apr 2013 16:39:42 -0500
Message-ID: <CAMP44s0g05L4GamAqbV-s9WJUsrcQeMK+N=c_jjzDMo3rQQ-Kw@mail.gmail.com>
References: <1367093864-9362-1-git-send-email-felipe.contreras@gmail.com>
	<7vy5c3slkh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 23:39:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWCqT-00072u-NY
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 23:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056Ab3D0Vjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 17:39:45 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:45997 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab3D0Vjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 17:39:44 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so410389lbh.21
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=wL+UvejmoQ7EtblTVB0yw0G1XtDuRiw41tc2C2AJ9N8=;
        b=K142Vp1nHpyMntDImsN9FDhAcBEo8E75a1e+oXSlmvmLCiLoPxlfAmYxDRy72BjH7q
         8lE7qcfZ8XCRyArEPiHKAFmltNezzsxEfQ+jZjx24JyHY2syBXrq4hoOTkjNpswBxES0
         2XuSKwZRoOZ4HhBC8/7ogr1YF2+itvVkm/2rHDPJ+4+M3Jl+8aTDUEviJZUlWGgoSNXi
         MPuY1vuz38dDx1TTyGEK5s5KJBRAnzQgRFTwBClLKClk4O9LqhotdLGeFbNUagd6dVD/
         MkZlfBjG+qW+TzrTtga33Hl83LVSJNAuQYNlmlzd4tC/38/HtUaxz/5ddOuds69wc7ui
         OJeg==
X-Received: by 10.112.139.226 with SMTP id rb2mr23547696lbb.12.1367098782795;
 Sat, 27 Apr 2013 14:39:42 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 27 Apr 2013 14:39:42 -0700 (PDT)
In-Reply-To: <7vy5c3slkh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222704>

On Sat, Apr 27, 2013 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Looks like a no-brainer-safe update that could even go to maint.  I
> prefer not to have too many patches in the "trivially correct"
> category in flight, so will apply directly on top of 'master'.

I just noticed that --cc= is duplicated, not that it would make any
functional difference.

Cheers.

-- 
Felipe Contreras
