From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] BUG: git push on an empty clone segfaults.
Date: Mon, 20 Apr 2009 15:55:32 +0200
Message-ID: <20090420135532.GC8940@machine.or.cz>
References: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr> <7vfxg3ipib.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904201252120.6955@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguy?n =?iso-8859-2?Q?Th=E1i?= Ng?c Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 15:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvtzp-00022e-H0
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 15:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbZDTNzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 09:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755479AbZDTNzh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 09:55:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34148 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755353AbZDTNzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 09:55:37 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id D4E7C204C0C8; Mon, 20 Apr 2009 15:55:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904201252120.6955@intel-tinevez-2-302>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116987>

  Hi,

On Mon, Apr 20, 2009 at 12:55:10PM +0200, Johannes Schindelin wrote:
> I fetched from repo.or.cz and tested with 'master', and it was broken.  
> Apparently git://repo.or.cz/git.git is lagging behind by 5 days.  Pasky?

  yes, I noticed that the mirroring got hanging on some dead repository
earlier today and restarted it, but it might take a while until a full
mirror cycle refreshes everything.

  Sorry about this.

				Petr "Pasky" Baudis
