From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Make cherry-pick use rerere for conflict   resolution.
Date: Mon, 11 Aug 2008 13:49:33 +0200
Message-ID: <48A0274D.8090504@viscovery.net>
References: <1218368935-31124-1-git-send-email-ams@toroid.org> <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811023053.GA9144@toroid.org> <alpine.DEB.1.00.0808111218160.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811104006.GH32184@machine.or.cz> <alpine.DEB.1.00.0808111328590.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Abhijit Menon-Sen <ams@toroid.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 13:50:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSVv8-00006E-7u
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 13:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYHKLtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 07:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbYHKLtj
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 07:49:39 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:11712 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbYHKLti (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 07:49:38 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KSVu2-0005Vc-Ay; Mon, 11 Aug 2008 13:49:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 137B16EF; Mon, 11 Aug 2008 13:49:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0808111328590.24820@pacific.mpi-cbg.de.mpi-cbg.de>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91934>

Johannes Schindelin schrieb:
> That would actually be a problem, no?  I am not sure that resolutions for 
> reverts make sense for cherry-picks, so I am not sure if resolutions 
> should be recorded for reverts.

Of course they should. If the reversal is part of a topic branch that you
rebase at least once, then you want to have the resolutions recorded,
don't you?

-- Hannes
