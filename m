From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v5 00/28] Support multiple checkouts
Date: Mon, 07 Jul 2014 12:49:01 +0200
Message-ID: <1404730141.4779.25.camel@seahawk>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
	 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
	 <20140706204651.GB21237@wheezy.local>
	 <CACsJy8D=9vVkZ2PtZq=b6R6wEmr1pX-yxCCXVBrd-akfeqE1sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 12:49:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X46U5-0000Fo-7I
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 12:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbaGGKtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 06:49:06 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37045 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbaGGKtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 06:49:04 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so15698000wib.5
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 03:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=sUN4LiOOJGJEw9tx+38evf6cRIL1xJXwEdN8Nkd4KlI=;
        b=RLrqDWLDHNOLPL/tUG0NmpLXfPeW2Fb6UT+ACAB6tVE+wJReSvRRkSdl5teXZ9Hhct
         H9+NjIwjBjsBR0+4+uG+EdOsYQegZYfCcbP1B8BL96pUK6PdyLTWwqYqCMzSy6z4d5IL
         zIjBOPcrnPsXC7ELM23bOFaUGdY71/PKhk/jDWoh5LSw53ATpvX5XK8BU4NuOLssLiU/
         WemKhTMr4GzdudoEFutI5v36AaUUc7cyt+Z61kuefDV2ijRcdHlmPJuGhKF/XCDscGKP
         vEB74v+sb7KOvT6qLDeN+7yq7HCQ3DoBMgyeCB6IVvLoIm6ujrgTSbX5vHwLhy2OInAl
         e2QQ==
X-Gm-Message-State: ALoCoQkkzZBdgd9IMZG94cJikN6pbI1XFEXSZeRn1b2FtX/Vjfn9XlW0p5Gzp9KreRS3fspIQp7q
X-Received: by 10.180.19.70 with SMTP id c6mr36329861wie.19.1404730142896;
        Mon, 07 Jul 2014 03:49:02 -0700 (PDT)
Received: from [10.155.73.156] (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id fg1sm30689042wic.17.2014.07.07.03.49.01
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 07 Jul 2014 03:49:02 -0700 (PDT)
In-Reply-To: <CACsJy8D=9vVkZ2PtZq=b6R6wEmr1pX-yxCCXVBrd-akfeqE1sQ@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252965>

On ma, 2014-07-07 at 17:25 +0700, Duy Nguyen wrote:

> > I also have a comment about how it interacts with submodules.
> > Would it be more appropriate to mark "modules" as a
> > per-checkout directory? Because each of the working tree's
> > submodule is obviously a separated directory in filesystem,
> > and in most cases (at least in my practice) they are
> > checked-out to different revisions.
> 
> Submodule interaction is something I have avoided so far because I'm
> not a big user and admittedly does not follow its development closely.
> I think we could get this in first, then let submodule people aware
> about this feature and let them decide how to use it.

I do intend to use checkout --to and submodule update on the same
repository, but have not yet done so. I will poke at that later this
month. If you can easily reproduce errors, I would appreciate to know
how, because my use of submodules is very limited.
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
