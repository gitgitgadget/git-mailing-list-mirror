From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] modernize fetch/merge/pull examples
Date: Thu, 22 Oct 2009 10:51:23 +0200
Message-ID: <200910221051.26336.trast@student.ethz.ch>
References: <200910201947.50423.trast@student.ethz.ch> <7vk4ypb71j.fsf@alter.siamese.dyndns.org> <20091021172123.GB27495@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>, <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Oct 22 10:52:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0tP2-0000es-4O
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 10:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbZJVIv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 04:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbZJVIv5
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 04:51:57 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:10813 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbZJVIv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 04:51:56 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 10:51:59 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 10:51:59 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091021172123.GB27495@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131011>

Clemens Buchacher wrote:
> On Tue, Oct 20, 2009 at 11:22:16PM -0700, Junio C Hamano wrote:
> 
> > For example, I am in favor of deprecating the "pull $there $src:$dst"
> > notation. 
> 
> A first step in that direction.

I think this is a good change independently of the deprecation.

> +------------------------------------------------
> +$ git fetch origin +pu:pu maint:tmp
> +------------------------------------------------
[...]
> +The `pu` branch will be updated even if it is does not fast-forward;
> +the others will not be.

I think to a new user it is not immediately clear if this means "will
not be updated, period" or "will not be updated if ...".  How about

  The `pu` branch will always be updated; the `tmp` branch only if it
  is a fast-forward update.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
