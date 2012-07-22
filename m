From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Sun, 22 Jul 2012 16:40:14 +0200
Message-ID: <61E46C90-5C8F-4E11-8CB7-0A05F1D62A8A@gmail.com>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net> <50092993.6010203@alum.mit.edu> <20120720154403.GB2862@sigill.intra.peff.net> <6F148977-4F57-47FF-B43B-0997694F3891@gmail.com> <20120722131448.GA16104@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 22 16:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsxLD-0002nw-DV
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 16:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab2GVOkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 10:40:19 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43364 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab2GVOkS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2012 10:40:18 -0400
Received: by weyx8 with SMTP id x8so3701665wey.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=IcCy/mc752pEhFauyItBjJTCmZnqlhEohdRNahzpc7o=;
        b=FZAgtNzPR3WUcVUvA3mKBfjXeYz5tSGpSfr0q4jVlG9wW0zfWV+z3mTFT7QusoY7E8
         ScxHXwIIW1HfNFtoDU2o3LmkLOU91nonvr+vG/D5wWDWqiOPmnnEVoSdN39GMSLE4bi/
         5C5B89dWSUSLuz/trO95GFutfJ9LCv6SfcCmrwYNUdhsVsy2V9SH+sKO6w5AeiQ04jdm
         pD/BmqGT2pQRkERiRPVh1CUwu/ij6a2FjII/CoyG9iJjgGtGkH6gM/oe+1FxmqW6DzAK
         aOoezcCLxk/Kf/oMYq57m/ZEoKNN88si0q3AISmIXlNekBlEYSTa6GFBf+T/2nYFEsUq
         y68w==
Received: by 10.180.92.7 with SMTP id ci7mr21722010wib.1.1342968017048;
        Sun, 22 Jul 2012 07:40:17 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id ep14sm16927311wid.0.2012.07.22.07.40.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 07:40:16 -0700 (PDT)
In-Reply-To: <20120722131448.GA16104@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201850>

On 22 Jul 2012, at 15:14, Jeff King wrote:

>  3. Most importantly, it does not resolve D/F conflicts (it has the
>     same problem as "logs/refs/heads/a~"). If you delete "foo/bar", you
>     will end up with "logs/refs/heads/foo/bar@{...}". That will prevent
>     D/F conflicts with a new branch "foo/bar/baz", but will still have
>     a problem with just "foo".

Unfortunately i do not really follow this, because i have not seen any directories in "logs/refs/heads/", i only saw files named after local branches there. I do not know how directories are used there.

-Alexey.