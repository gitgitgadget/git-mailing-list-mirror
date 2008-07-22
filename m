From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix update-index --refresh for submodules if stat(2)
	returns st_size 0
Date: Tue, 22 Jul 2008 18:49:41 +0200
Message-ID: <20080722164941.GB3766@blimp.local>
References: <20080721173511.GB5387@steel.home> <alpine.DEB.1.00.0807211917440.8986@racer> <20080721194322.GA4013@blimp.local> <7vbq0qnxyi.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:51:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLL5M-0002wI-A2
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 18:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbYGVQug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbYGVQug
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:50:36 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:41130 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbYGVQug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:50:36 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jepV
Received: from tigra.home (Fa955.f.strato-dslnet.de [195.4.169.85])
	by post.webmailer.de (mrclete mo19) (RZmta 16.47)
	with ESMTP id C067c3k6MFJvGJ ; Tue, 22 Jul 2008 18:50:32 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id F32A2277C4;
	Tue, 22 Jul 2008 18:50:31 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 9C7DC36D11; Tue, 22 Jul 2008 18:49:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vbq0qnxyi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89498>

Junio C Hamano, Tue, Jul 22, 2008 10:07:49 +0200:
> I however have to wonder if you also need to touch the end of
> ce_match_stat_basic() that checks for zero sized cache entry.

I frankly don't know.
