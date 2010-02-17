From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/6] fast-import updates
Date: Wed, 17 Feb 2010 15:23:41 -0800
Message-ID: <20100217232341.GA27377@spearce.org>
References: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 00:23:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhtFO-00046D-6E
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 00:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757871Ab0BQXXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 18:23:46 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:65244 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757868Ab0BQXXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 18:23:45 -0500
Received: by ywh35 with SMTP id 35so446917ywh.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 15:23:45 -0800 (PST)
Received: by 10.151.88.12 with SMTP id q12mr6140373ybl.315.1266449024921;
        Wed, 17 Feb 2010 15:23:44 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 35sm3404979yxh.15.2010.02.17.15.23.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 15:23:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266433556-1987-1-git-send-email-nico@fluxnic.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140271>

Nicolas Pitre <nico@fluxnic.net> wrote:
> Will follow a couple fast-import updates, with the most significant
> change being the ability for fast-import to produce pack index v2 by
> default.  Overall this should make fast-import produced data more imune
> to silent corruptions, and also lift the limit on the maximum pack size
> it could produce.
> 
> [PATCH 1/6] fast-import: start using struct pack_idx_entry
> [PATCH 2/6] fast-import: use sha1write() for pack data
> [PATCH 3/6] fast-import: use write_idx_file() instead of custom code
> [PATCH 4/6] fast-import: make default pack size unlimited
> [PATCH 5/6] fast-import: honor pack.indexversion and pack.packsizelimit config vars
> [PATCH 6/6] fast-import: use the diff_delta() max_delta_size argument

Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks Nico.  I wanted to do this myself, but couldn't find the time
since it was recently brought up that we still didn't use index v2
in fast-import.

-- 
Shawn.
