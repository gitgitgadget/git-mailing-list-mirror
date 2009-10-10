From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Sat, 10 Oct 2009 12:23:32 -0500
Message-ID: <200910101223.36426.luke@dashjr.org>
References: <200908121726.52121.luke-jr@utopios.org> <20090815063958.6117@nanako3.lavabit.com> <200908141754.51393.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Luke Dashjr <luke-jr+git@utopios.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 19:38:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwftx-00067a-Lk
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 19:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbZJJRfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 13:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759138AbZJJRfw
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 13:35:52 -0400
Received: from vps2.mechanicalrealm.com ([66.216.20.21]:46088 "EHLO
	zinan.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758898AbZJJRfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 13:35:52 -0400
X-Greylist: delayed 692 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Oct 2009 13:35:52 EDT
Received: from tsuruki.localnet (unknown [IPv6:2002:62b3:1d4c:0:20e:a6ff:fec4:4e5d])
	(Authenticated sender: luke-jr)
	by zinan.dashjr.org (Postfix) with ESMTPSA id CD57CB9C6CA;
	Sat, 10 Oct 2009 17:23:43 +0000 (UTC)
User-Agent: KMail/1.12.2 (Linux/2.6.30-gentoo-r4; KDE/4.3.2; x86_64; ; )
In-Reply-To: <200908141754.51393.luke@dashjr.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129892>

Just for reference, since these fixes+functions have not yet been merged to 
mainline Git, I have pushed a fork with them rebased on up-to-date tags:
	http://repo.or.cz/w/git/ljr.git
