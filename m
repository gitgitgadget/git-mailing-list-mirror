From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch
 04/33
Date: Thu, 24 Mar 2016 02:47:14 -0400
Organization: Twitter
Message-ID: <1458802034.28595.8.camel@twopensource.com>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 07:47:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiz3D-0000Zk-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 07:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbcCXGrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 02:47:19 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36752 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbcCXGrS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 02:47:18 -0400
Received: by mail-io0-f172.google.com with SMTP id 124so75987145iov.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 23:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=KMzcU25rpCWC3/xqmKY0PLq5PoflcZrOAtrSxRH7iXU=;
        b=MqdcCF68/jhCDKKggqJSm7s1rT9n6EpCKsBdOo1H2eG0ME13tXLDUjm5dHMhj11Ahg
         Y1bovk8NHO+zQkyhXHjbMgKfuOOWOd/JOh3bkVOJ81hmV66dQ9fxPjp4g6XuouGNFDyU
         1buhkF5Vk6orF3RQm14PIzoaPhG42Ao1stkhVGoZ/5k3J3wGYRRJcLN18VI76P1WJB7V
         SleRtvINKlZjGExYzijuaKDs1xpn0u2W0kck58HtKOqpWmC8yFzdaK2J7nPNOjq6/6XK
         6mBn6NQG0pKg1sSjkDdiUzGBJa+MrtWx5LAVP7fzj8BzoE5biSMsYANjG8PA3RlAp1bH
         Bj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KMzcU25rpCWC3/xqmKY0PLq5PoflcZrOAtrSxRH7iXU=;
        b=cG9RZwoe6/SYyNvVjLvmu1V/o8NyNnur55sv/OJ32sfKP2zVEZlGkn+WX+pdYzoRKA
         W3s+cQUmKLP5E5OkI1rT2QECSyfPyqqChZ5o3VXBBcQ6sQAA+X+TxGYqgQyh1rQosrJX
         zo4Mwr6Q7bso7LHyc5Lx0AlHnp1ErcvUYspsMOXonWZeWPEQ/o2/U+HBCerbYn8BefVD
         LKnu8HNNyQqwcrbLV0w3fgDrPa0/iTVvYXFUyryWlNJYldSu8Hn9U5lstMoZSg8tV52p
         EEhVWqIdqql1UrXh5Mz/xgI6hEn23frzGLKPfmJdj0mUKoaGpU/mt5kIcCdOharCS73h
         kXKg==
X-Gm-Message-State: AD7BkJLraUB1Kvo0efDDwWO5cfYJaJhdzLlBICD08Q8Rkrc2aCVadRKfs6QZIsT85MzbDw==
X-Received: by 10.107.28.134 with SMTP id c128mr6803477ioc.86.1458802037274;
        Wed, 23 Mar 2016 23:47:17 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id w129sm2616284iof.11.2016.03.23.23.47.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2016 23:47:16 -0700 (PDT)
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289714>

On Wed, 2016-03-23 at 11:04 +0100, Michael Haggerty wrote:
> Patch 04/33 in David Turner's refs-backend-lmdb series v7 [1] did way
> too much in a single patch, and in fact got a few minor things wrong.
> Instead of that patch, I suggest this patch series, which
> ...

LGTM.  I think I would squash these patches:
  fsck_head_link(): remove unneeded flag variable
  cmd_merge(): remove unneeded flag variable
  get_default_remote(): remove unneeded flag variable
  checkout_paths(): remove unneeded flag variable

But that's up to you.

I incorporated your changes into the lmdb backend.  To make merging
later more convenient, I rebased on top of pu -- I think this mainly
depends on jk/check-repository-format, but I also included some fixes
for a couple of tests that had been changed by other patches.

The current version can be found here:

https://github.com/dturner-tw/git/tree/dturner/pluggable-backends

I won't resend the full patchset to the list until I hear back on the
rest of the review.

It seems like maybe we should now split this into two patchsets:
everything up to and including "refs: move resolve_ref_unsafe into
common code" does not depend on the backend structure and could go in
earlier.  If you agree, we could send that first series and get it in,
hopefully reducing later merge conflicts.  
