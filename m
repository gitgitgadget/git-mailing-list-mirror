From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC! PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 20 Oct 2009 20:37:08 +0200
Message-ID: <200910202037.09140.trast@student.ethz.ch>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 20:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Jaf-0006Q4-TA
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 20:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbZJTShk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 14:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbZJTShj
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 14:37:39 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:57641 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbZJTShj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 14:37:39 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 20:37:44 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 20:37:43 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130823>

Thomas Rast wrote:
> git-pull has historically accepted full fetchspecs, meaning that you
> could do
> 
>   git pull $repo A:B
> 
> which would simultaneously fetch the remote branch A into the local
> branch B and merge B into HEAD.  This got especially confusing if B
> was checked out.  New users variously mistook pull for fetch or read
> that command as "merge the remote A into my B", neither of which is
> correct.
> 
> Since the above usage should be very rare and can be done with
> separate calls to fetch and merge, we just disallow full fetchspecs in
> git-pull.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Argh.  This was actually supposed to be an *RFC* patch.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
