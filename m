From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v4 00/11] Resend sp/maint-dumb-http-pack-reidx
Date: Mon, 19 Apr 2010 07:49:07 -0700
Message-ID: <20100419144907.GC4295@spearce.org>
References: <20100418115744.0000238b@unknown> <1271686990-16363-1-git-send-email-spearce@spearce.org> <20100419224643.00001ff1@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:49:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3sHt-0002HH-Vv
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab0DSOtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 10:49:15 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:55753 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab0DSOtN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 10:49:13 -0400
Received: by bwz25 with SMTP id 25so5681661bwz.28
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:49:12 -0700 (PDT)
Received: by 10.204.38.82 with SMTP id a18mr980941bke.126.1271688552142;
        Mon, 19 Apr 2010 07:49:12 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 15sm3174203bwz.4.2010.04.19.07.49.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 07:49:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100419224643.00001ff1@unknown>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145307>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> the small patch below could also be applied to the rebased topic branch.
> 
> -->8--
> From: Tay Ray Chuan <rctay89@gmail.com>
> Subject: [PATCH] http.c::new_http_pack_request: do away with the temp variable filename
> 
> Now that the temporary variable char *filename is only used in one
> place, do away with it and just call sha1_pack_name() directly.
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

FWIW, Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
