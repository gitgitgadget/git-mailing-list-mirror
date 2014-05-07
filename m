From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Standardize python shebangs
Date: Wed, 07 May 2014 15:40:20 -0500
Message-ID: <536a9a34e8194_76ff7a52ec7f@nysa.notmuch>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
 <vpqy4ydpiog.fsf@anie.imag.fr>
 <536a842838fbb_76ff7a52ec5d@nysa.notmuch>
 <vpqr445nxrw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:51:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8o5-0004ni-0n
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbaEGUvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:51:10 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:38426 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaEGUvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:51:08 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so1961418oag.14
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=s6iD+RjPSDzWLvLSOXUsk/YjT3OE+rF/6dgTfu8aDOE=;
        b=aBPslx0tAy/8f+nSu/j+gPz/vfeyLRc0jsuNUMQTpETNQFNQ6ftvomAJMHm0rE5Z9h
         dcwTOF1ovc3gAU3x06v+u8FMyIKcRKf3/0FW2HnHSRUVGFMuQqwXXNQut5WV9T+Ey3l1
         1+AscGA9JJnr0HT8XbGbU+qb0eogGDZWgRkqqxeFDOy9gwEYHzsynaixi2n4Tp95SpRH
         7+Ms1RYA5d8jK71/moO8pCxOd3UhyXRWSemFt9lidiCdUgb+XWWGKw68lynUoqNg0gGf
         /7xRp/FTKujc5O0P225sfzU24/Jw+oSsG/bLEP5Hb/EqD+nnpE/Y3+RNoywjCDuC8erI
         lYdg==
X-Received: by 10.182.97.1 with SMTP id dw1mr48199110obb.23.1399495867648;
        Wed, 07 May 2014 13:51:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id vh3sm36648277obb.9.2014.05.07.13.51.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 13:51:06 -0700 (PDT)
In-Reply-To: <vpqr445nxrw.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248369>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > If you want to use python2, then use '/usr/bin/env python2'.
> 
> Err, yes, this is what the code does before your patch.

Not for all the instances.

> > If you are going to follow practices different than git.git, then
> > multimail shouldn't live in 'contrib/'.
> 
> git-multimail is not the only part of git.git that has a separate
> maintainer. Same goes for git-gui and gitk.

They are not part of contrib.

-- 
Felipe Contreras
