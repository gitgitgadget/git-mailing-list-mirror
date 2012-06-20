From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 11/11] Makefile: move GIT-VERSION-FILE dependencies
 closer to use
Date: Wed, 20 Jun 2012 16:31:47 -0500
Message-ID: <20120620213147.GG6142@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183222.GK30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:31:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShSVJ-0005nd-B8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 23:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139Ab2FTVbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 17:31:53 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:51393 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab2FTVbx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 17:31:53 -0400
Received: by ghrr11 with SMTP id r11so6098314ghr.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ecFIjEtlaqryww8R5eQk3q+gmVf5tJ40O5lcy9OArb8=;
        b=VZ1R6QKFd6qOsehQZogXC2jphZA4MFK6StJ114S86QHQdtrniavd4s7Q47ONdzRdtU
         VUfYwftwHmJeeMbtyAUiE5WFvPhnzQvaT5YYd5/35i/Zk5c5FKdBpN9XtxeC9OCB9ZF+
         iUca1mC7V70c6RryrvZ2r0grEXHRGGGSbAUv1ZkBhmPVjws8SUaqGhptwyDjlPp5YMn7
         kUoUTi9le35RNjWn2MN7ShyI1GMOk9+dj7qu4ULW9ABFZcqc6fGi6XyjtH/XSVF6FGMz
         /RzpPxiEjL5+HiFKMQO3vpL8H+HQJAOClEn7t8LDoJdQDOMkPo2n8fNZ/JjSGzlV5K+S
         j02w==
Received: by 10.236.186.103 with SMTP id v67mr30834419yhm.6.1340227912549;
        Wed, 20 Jun 2012 14:31:52 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id r8sm42252068ani.9.2012.06.20.14.31.51
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 14:31:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620183222.GK30995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200367>

Jeff King wrote:

> There is a list of all of the targets which depend on
> GIT-VERSION-FILE, but it can be quite far from the actual
> point where the targets actually use $(GIT_VERSION). This
> can make it hard to verify that each use of $(GIT_VERSION)
> has a matching dependency.
>
> This patch moves the dependency closer to the actual build
> instructions, which makes verification easier.  This also
> fixes the generation of "configure", which did not properly
> mark the dependency.

Very nice.

Regards,
Jonathan
