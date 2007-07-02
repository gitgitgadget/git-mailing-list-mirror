From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Test that git add removes stages 1,2,3.
Date: Mon, 02 Jul 2007 13:47:32 +0200
Organization: eudaptics software gmbh
Message-ID: <4688E5D4.6BA7EB7F@eudaptics.com>
References: <11833750863127-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0707021232510.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 02 13:47:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5KN6-00082e-Qb
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 13:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbXGBLrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 07:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbXGBLrJ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 07:47:09 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30384 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbXGBLrI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 07:47:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I5KMy-0003FQ-OX; Mon, 02 Jul 2007 13:47:05 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AD8536D9; Mon,  2 Jul 2007 13:47:04 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.9 (+)
X-Spam-Report: AWL=-1.768, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51359>

Johannes Schindelin wrote:
> On Mon, 2 Jul 2007, Johannes Sixt wrote:
> 
> > git add seems to have a bug, where it doesn't remove stages 1,2,3
> > if a stage 0 entry is already in the index.
> 
> But how does that happen? I do not know any way to use porcelain to
> achieve that bogus state.

I'm aware of that; so I said "border case" in the original post.

> Pilot error?

Oh, yes :) It noticed this when I was tweaking the test for git add with
symlinks=false that I posted.

-- Hannes
