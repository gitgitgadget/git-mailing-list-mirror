From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 15:07:17 -0700
Message-ID: <20121030220717.GO15167@elie.Belkin>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
 <20121030185914.GI15167@elie.Belkin>
 <CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
 <CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
 <20121030214531.GN15167@elie.Belkin>
 <CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJyH-0005VV-I8
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934579Ab2J3WH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:07:26 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38681 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932932Ab2J3WHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:07:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so482544pbb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=reqFTEYA+G5Ohf10eEroNWVZCGWF/dOiQW0QMzy8ZgY=;
        b=RzUPa9opP9uaS4JH6HjKdVANN5oDT+K4FX/HMXO/yQKYRn85u9SEeaRmHOiFoeFfc8
         IhaHq65i9CejdN/aQW+T2tcbyBH0U20Fmnds6UB3EkZWwc0qqpUrJ7LtHruQMgvSr/MF
         HXt6vRQcXYrcd1Mc0EkRkuGukZw41wDOGeguBkCs8i0nppn+e53J7eIkO1avTnHI+1sa
         1OeUW4lWFUqGmZmLnH566R32zp43LDCHA9xzHZy379BMSbZag81eNrTdVM3jacnDySOJ
         HyQ6ia2wJNtPb0j6/k3QW38PKsG7WNl5ska5rK21UG9EtQQZDb5g9x5BFuzmr73/sze9
         mGeQ==
Received: by 10.66.84.196 with SMTP id b4mr34040316paz.41.1351634842061;
        Tue, 30 Oct 2012 15:07:22 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id j4sm1004948pax.31.2012.10.30.15.07.20
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 15:07:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208756>

Felipe Contreras wrote:

> Well, that's what we have now, and you want to preserve this "feature"
> (aka bug), right?

Nope.  I just don't want regressions, and found a patch description
that did nothing to explain to the reader how it avoids regressions
more than a little disturbing.

I also think the proposed behavior is wrong.

I don't think there's much benefit to be gained from continuing to
discuss this.  Consider it a single data point: I would be deeply
worried if this patch were applied without at least a clearer
description of the change in behavior.  Maybe I'm the only one!

Hope that helps,
Jonathan
