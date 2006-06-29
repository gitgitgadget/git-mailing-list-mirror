From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with Git.pm
Date: Thu, 29 Jun 2006 11:58:26 +0200
Message-ID: <200606291158.27172.Josef.Weidendorfer@gmx.de>
References: <20060628183557.GA5713@fiberbit.xs4all.nl> <7vbqsdynvu.fsf@assigned-by-dhcp.cox.net> <20060629130400.c280de67.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org,
	pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Jun 29 11:58:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvtIB-0007CY-RQ
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 11:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWF2J6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 05:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbWF2J6d
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 05:58:33 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:18172 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751587AbWF2J6c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 05:58:32 -0400
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 3B052273F;
	Thu, 29 Jun 2006 11:58:31 +0200 (MEST)
To: Sergey Vlasov <vsu@altlinux.ru>
User-Agent: KMail/1.9.3
In-Reply-To: <20060629130400.c280de67.vsu@altlinux.ru>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22855>

On Thursday 29 June 2006 11:04, Sergey Vlasov wrote:
> And the effect of -fPIC on x86_64 is smaller than on i386, because
> x86_64 has 2x more registers than i386, therefore loss of one register
> is less noticeable.

According to the x86_64 ABI, x86_64 has no explicit GOT pointer.
Meaning: no additional register needed at all, as x86_64 has IP-relative
addressing. Thus, compiling with -fPIC on x86_64 probably has no
negative implications at all (?).

Josef
