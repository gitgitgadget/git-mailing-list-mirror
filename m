From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Wrap completions in `type git' conditional statement.
Date: Tue, 29 Dec 2009 07:02:17 -0800
Message-ID: <20091229150217.GB6152@spearce.org>
References: <44A6FDEB-71B6-42E1-99E3-D6A595FF1B58@metablu.com> <20091229200530.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Sung Pae <sung@metablu.com>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 16:02:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPdab-0005sm-9f
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 16:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbZL2PCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 10:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbZL2PCV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 10:02:21 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:50103 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbZL2PCU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 10:02:20 -0500
Received: by ywh6 with SMTP id 6so11283111ywh.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 07:02:20 -0800 (PST)
Received: by 10.150.19.4 with SMTP id 4mr11989831ybs.216.1262098940427;
        Tue, 29 Dec 2009 07:02:20 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm12019259iwn.0.2009.12.29.07.02.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Dec 2009 07:02:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091229200530.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135804>

Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Junio, could you tell us what happened to this thread?
> 
> The patch avoids failing completion script when git is not there.
> No discussion.

Actually, that's probably my fault.  I never sent an ack or nak,
or anything else really, on this thread.

Originally this was because the completion was trying to run git
as it loaded.  In 1.6.6 this is no longer true, the completion list
is generated lazily on demand during the first completion attempt.

With the lazy loading, I didn't see a reason to add this ugly block
around the entire script.

-- 
Shawn.
