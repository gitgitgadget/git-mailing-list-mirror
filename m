From: Jon Seymour <jon.seymour@gmail.com>
Subject: porcelain question: state of the art for undo-redo?
Date: Sat, 11 Jun 2005 18:51:34 +1000
Message-ID: <2cfc40320506110151624b3ec1@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jun 11 10:47:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh1eG-0005Ax-8X
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 10:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFKIvl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 04:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVFKIvl
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 04:51:41 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:19420 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261266AbVFKIve convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 04:51:34 -0400
Received: by rproxy.gmail.com with SMTP id i8so420480rne
        for <git@vger.kernel.org>; Sat, 11 Jun 2005 01:51:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qdbV1R/cUgFxCepHHBV2GJdFrO6OVllb8/zHO0NClwBzor96d3b+0V4DWgHh095bLAOBCqQVN4HX0bN1e4bbd1L+2mq+95p1OcpLDQhODwUBnK3hSfnSE3byC7+VRm3ZRkDE2sjHzuExz67PjTzL9rSWh3JvI1ls8ffrceMlIbw=
Received: by 10.38.101.36 with SMTP id y36mr66596rnb;
        Sat, 11 Jun 2005 01:51:34 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sat, 11 Jun 2005 01:51:34 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

What porcelain layer solutions currently exist for effective undo-edit-redo?

For example, if you are working on a series of patches in a series,
then realise there is a mistake in a patch early in the series, how
does one mod that patch, then reapply all the following patches to
produce a slightly modified patch series with as little stuffing
around as possible?

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
