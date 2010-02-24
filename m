From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] receive-pack: Two small code cleanups
Date: Wed, 24 Feb 2010 09:29:32 -0800
Message-ID: <20100224172932.GE18993@spearce.org>
References: <cover.1267029680.git.agruen@suse.de> <f409d0cde7939a833708ed92f86605dbbdd64a49.1267029680.git.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 18:29:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkL3O-0004OD-5k
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 18:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757182Ab0BXR3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 12:29:36 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:53582 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab0BXR3g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 12:29:36 -0500
Received: by yxe12 with SMTP id 12so650292yxe.33
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 09:29:35 -0800 (PST)
Received: by 10.150.243.10 with SMTP id q10mr523728ybh.23.1267032575224;
        Wed, 24 Feb 2010 09:29:35 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm830771yxe.19.2010.02.24.09.29.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 09:29:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f409d0cde7939a833708ed92f86605dbbdd64a49.1267029680.git.agruen@suse.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140960>

Andreas Gruenbacher <agruen@suse.de> wrote:
> Rename show_ref()'s path parameter to refname.
> 
> In read_head_info(), lines may have trailing capability strings.  Throw
> away such strings after evaluation; they are not needed in the command
> structs.
> 
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
