From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH da/difftool-mergtool-refactor] Makefile: fix permissions
 of mergetools/ checked out with permissive umask
Date: Sun, 9 Oct 2011 16:47:52 -0500
Message-ID: <20111009214752.GB3006@elie>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-4-git-send-email-davvid@gmail.com>
 <20111009091617.GA29150@elie.hsd1.il.comcast.net>
 <20111009114333.GA29829@elie.hsd1.il.comcast.net>
 <1C9F1683-4C6E-4D49-86D3-3A47B2843F23@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	SebastianSchuberth <sschuberth@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 23:48:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD1E6-0006Aw-Vz
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 23:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911Ab1JIVr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 17:47:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38169 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1JIVrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 17:47:55 -0400
Received: by iakk32 with SMTP id k32so6712279iak.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PnRtH7nAXmrjpSO+DipEXeG2oozn/p6BGzVI2OWkHBA=;
        b=eKv8clWpTbD1aSWqZya2ZK+1KNQt1tLp3Uuno8SFVkljRjS004Tq7PaMmyC2oSjrGN
         5EcY8ThsjKjXIWJKu5cfzgFKdckP3U14veFb/32FWyXSYfU6Faau1manz3x4XdpSvSKy
         Kj6rAFi1qmBSCgyeWfVBcPNJ1f00AiJThE024=
Received: by 10.42.159.1 with SMTP id j1mr12092092icx.20.1318196875227;
        Sun, 09 Oct 2011 14:47:55 -0700 (PDT)
Received: from elie (c-67-167-211-62.hsd1.il.comcast.net. [67.167.211.62])
        by mx.google.com with ESMTPS id z11sm40938192iba.6.2011.10.09.14.47.54
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Oct 2011 14:47:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1C9F1683-4C6E-4D49-86D3-3A47B2843F23@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183213>

David Aguilar wrote:

> thanks. I agree that the tar is overkill. I think I copied that
> snippet from templates/makefile. does that have the same bug?

It did have a similar bug before, but it was fixed (in a different
way) by v1.6.0.3~81^2 (Fix permission bits on sources checked out with
an overtight umask, 2008-08-21).  The main difference from the
mergetools/ case is that the blt/ directory is populated at build
time.
