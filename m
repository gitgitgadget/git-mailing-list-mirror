From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 10/10] want_color: automatically fallback to color.ui
Date: Sat, 3 Sep 2011 22:36:01 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109032212310.12564@debian>
References: <20110818045821.GA17377@sigill.intra.peff.net> <20110818050533.GJ2889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	=?ISO-8859-15?Q?Ingo_Br=FCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 04 04:36:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R02ZK-00024L-6t
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 04:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab1IDCgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 22:36:10 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54371 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab1IDCgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 22:36:08 -0400
Received: by vws1 with SMTP id 1so3163837vws.19
        for <git@vger.kernel.org>; Sat, 03 Sep 2011 19:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=io+L4/NaqeorNk00BzQpTHwM84p+oko6HeV9bIPF4+A=;
        b=UQJCtNskNnVWtvWKjQWPrK0+lkX9BR76JzPNI8yc3ogzfnm78JLKez+op6Y4PuIUQ+
         vsX+sQRnvAWrBSVrVKcj98Y6zFs0YTctBHRTrkQLHFU8lrN5uRBrBcCjYIFRwSa/T4X7
         jO00qVYg3RdWcZxQvSn3Fk+6iXpRolo2XkObk=
Received: by 10.52.74.41 with SMTP id q9mr2452698vdv.388.1315103766718;
        Sat, 03 Sep 2011 19:36:06 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id ig8sm2569548vdb.3.2011.09.03.19.36.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Sep 2011 19:36:05 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <20110818050533.GJ2889@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180669>

Hi Jeff,

This patch makes format-patch output color escape codes to file when
run with color.ui=always. Before the patch it did not do that. The
documentation for color.ui says "Set it to always if you want all
output not intended for machine consumption to use color". Is
format-patch "intended for machine consumption" or not?

I'm not sure why I had the parameter set to "always" instead of
"true/auto" and maybe I should change it, but since this patch changes
the behavior, I thought I should let you know (it was not mentioned in
the commit message, so I'm not sure it was intentional).


Martin
