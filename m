From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 3 Oct 2011 06:13:31 -0500
Message-ID: <20111003111331.GA12707@elie>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
 <20111003074250.GB9455@sigill.intra.peff.net>
 <4E8975E7.2040804@viscovery.net>
 <20111003093912.GA16078@sigill.intra.peff.net>
 <CACsJy8B7Z-fT+ED=4F-Ug-bhvCagSxr0X6vZqn5PGRfB7KnUTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 13:13:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAgSx-0006yP-Tq
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 13:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab1JCLNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 07:13:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47776 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab1JCLNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 07:13:42 -0400
Received: by yxl31 with SMTP id 31so3358308yxl.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qZ6x1DVXAtwQTyB9ygGVj6NJKIQXxKB0Ro6s8MuU+lY=;
        b=Jip1huyjb5px6TVjiBK/AtDw9LnjZ9EpRIVx2hij2RbXV7meJvWpfCIdABbcNt6qE+
         x1taEhLC3D7CAjaGl4U7SJgbAUxK1h1PsufoTSKoPS5+ZTInOyzBmScXzinyy8nu0PJr
         rWRoh/xBOyKDn5iWtZ+FdsV1SJMMuNwka0bGA=
Received: by 10.43.133.2 with SMTP id hw2mr460758icc.33.1317640421969;
        Mon, 03 Oct 2011 04:13:41 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id dv19sm28946745ibb.3.2011.10.03.04.13.40
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 04:13:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8B7Z-fT+ED=4F-Ug-bhvCagSxr0X6vZqn5PGRfB7KnUTA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182653>

Nguyen Thai Ngoc Duy wrote:

> To me, just "<service>: access denied" is enough. Not particularly
> friendly but should be a good enough clue.

Yes, I think you're right.  It also has the benefit of being easily
parsable, so some day the client might learn to give a friendly
message in the operator's chosen language.
