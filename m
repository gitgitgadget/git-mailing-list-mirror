From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Tue, 02 Dec 2014 18:45 +0100
Message-ID: <4081616.27DjsMG0kb@al>
References: <6997784.RuzRO1AFsK@al> <283403992.8FOSVk7RPR@al> <D7697DE2C591421E8588920BD4FE0455@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:45:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvrVj-0000Lp-HR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbaLBRpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:45:09 -0500
Received: from lekensteyn.nl ([178.21.112.251]:40698 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074AbaLBRpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=8VR/ceAU9wad5wCM6x88JnlfGDKpysyayRPU1wyDUao=;
	b=gd2nZqWlyyc/HCW5OnTb7e6Le/InTpIvVFItUwFp0czK0c+7zJ2ZJ66YPmFdQJU2y7N7BZH96UF7AWnIBUm2gz2o0nu6VZy83fl1tCmDzx4iV5J5T6YvZl5x/rOfpxhW8nkTaY2wtbj22G9itUtETEfA5tRqAkK5idLZ47GS0HAu+W+mHyR7/pX1R8aiHkKD6nF+8EfkP90qrCxl6axIX9KJbUFc//96IeaOw3IrxU9/BkV00QruU2yJrq9UIecw5b7i5ILoFNLOHCHRmVqfQcUKcH+xq8XtOUcVkDZXSHq7P0e/rBSM2OyOEOmtv9f2rz/dLgrM6Dcs+xF9jmseSg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1XvrVU-0001rD-Rk; Tue, 02 Dec 2014 18:45:01 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <D7697DE2C591421E8588920BD4FE0455@PhilipOakley>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260585>

On Saturday 29 November 2014 13:31:18 Philip Oakley wrote:
> From: "Peter Wu" <peter@lekensteyn.nl>
> > Ok, I will make a clear note about the default (without --only) 
> > behavior
> > having weird behavior for historical reasons. Are you really OK with
> > --only=both? It sounds a bit odd (mathematically speaking it is 
> > correct
> > as fetch and push are both partitions that form the whole set if you
> > ignore the historical behavior).
> >
> How about :
> 
> s/--only/--direction/
> 
> or some suitable abbreviation (--dirn ?)

In the next version of the patch I went for three separate options,
--fetch, --push and --both:
http://article.gmane.org/gmane.comp.version-control.git/260213
(Juno, Jeff: ping?)

The option --direction=<fetch|push|both> is a bit longer and --dirn can
be mistaken for "directory N".
-- 
Kind regards,
Peter
https://lekensteyn.nl
