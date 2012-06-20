From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 03/11] Makefile: do not have git.o depend on
 common-cmds.h
Date: Wed, 20 Jun 2012 16:09:26 -0500
Message-ID: <20120620210926.GC6142@burratino>
References: <20120620182855.GA26948@sigill.intra.peff.net>
 <20120620183118.GC30995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:09:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShS9f-0002W7-Nl
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 23:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab2FTVJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 17:09:32 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:32859 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab2FTVJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 17:09:31 -0400
Received: by ghrr11 with SMTP id r11so6080554ghr.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=P9l7xNHaRr31YyKOdn4JgVSnPp+i8ohQf/s+w2gv62I=;
        b=kBtEw9RlYLC6iSH0Qy6Kgic5vg11zm5Sw65coQtkmZzCPoqh6WFFgMjX4NyBlYEK/C
         MWzDgnbhS/jm9+TSmcdcW7vtBa+wmvPnPnRILNjUMEvbfBi1w3x0EuI3W+KFkZVuYAUe
         M0oHE8fguDWoG7XfryfU3pt7UFVLquXVxXD8DiP468FHqq3B8AKKK7KjFuea+pUDHuAe
         Meu62rO4Jj+yIBLTTkSriPuQhMdFKXrj5SRO3bLho2onGdtyAsYTrMk0XLhxkYvdadJY
         VRhYpj1FhzFT29ZVpn/eqxTN/9MqAgTIKn8xNjHJeZsNtoPOW5mJKRtQmDb1u4ZM5vLP
         raLQ==
Received: by 10.236.182.7 with SMTP id n7mr29673753yhm.61.1340226571015;
        Wed, 20 Jun 2012 14:09:31 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id y66sm98864498yhi.10.2012.06.20.14.09.29
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 14:09:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120620183118.GC30995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200363>

Jeff King wrote:

> This dependency has been stale since 70827b1 (Split up
> builtin commands into separate files from git.c, 2006-04-21).

Good catch, thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
