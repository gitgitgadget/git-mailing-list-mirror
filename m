From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 5 Apr 2012 23:22:15 -0500
Message-ID: <20120406042215.GA3938@burratino>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David E. Wheeler" <david@justatheory.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 06:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG0gu-0000Ls-Dv
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 06:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab2DFEWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 00:22:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63691 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab2DFEWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 00:22:23 -0400
Received: by iagz16 with SMTP id z16so2651847iag.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 21:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u2N7rJ9IGr05XEKoN4k/80nuiyb3cFN65X+9RYJai3o=;
        b=x5snxiHU98r18u6ZdeWUNw7hn834PMx26ErIQz8ml/hzdB9BicT3XjuLlcqMRFG7/e
         uX7BBVBBJF8+JRbWn2/GT6pcCZMEDRcZum6QT38tSsNXM0oWr5xtYmrJLqP2A6aiJ3P5
         W+DCSOhiQ5zKfZV6ivt/bZeMoEoaOVHbYhBYL0ihRzN73K9xyyr4f6+XimQ893MiJSCW
         woAZGOxvPxUhpAUJe6bKnAhdSufbnAZFant1TYSifc8WQyW7oaFHVDeDR4Tqu6gyjo21
         VOV1TyeOsMw9c2ZTgK9646UDe+CxCGwOuAuab9aK3MTGxiUeXFaHZKpvOLrajnbT/EYw
         FJ9g==
Received: by 10.50.153.198 with SMTP id vi6mr4080354igb.0.1333686142606;
        Thu, 05 Apr 2012 21:22:22 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c2sm3449964igj.1.2012.04.05.21.22.21
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 21:22:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120406025457.GA23997@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194844>

Jeff King wrote:

> So I think technically the docbook part of the toolchain would be the
> right place to fix this. But it may be easier to hack around it at the
> asciidoc level.

Isn't this what MAN_BASE_URL in Documentation/Makefile is for?  I
don't think a lower level fix is needed.
