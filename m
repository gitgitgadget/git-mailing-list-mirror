From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Documentation/git-gc.txt: change --aggressive
	description
Date: Tue, 13 May 2008 13:57:28 +0300
Message-ID: <20080513105728.GA3088@mithlond.arda.local>
References: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue May 13 12:58:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvsDE-0003dk-VI
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 12:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbYEMK5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 06:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbYEMK5i
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 06:57:38 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:54691 "EHLO
	kirsi2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750962AbYEMK5i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 06:57:38 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.rokki.sonera.fi (8.5.014)
        id 48236516003684EA; Tue, 13 May 2008 13:57:28 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JvsCG-0000pe-43; Tue, 13 May 2008 13:57:28 +0300
Content-Disposition: inline
In-Reply-To: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82015>

Pieter de Bie wrote (2008-05-13 11:53 +0200):

> I keep seeing people regularly packing their repo with git gc
> --aggressive. However, in my experience, this seldom results in
> a smaller repository. This can be because the repository was repacked
> tightly previously (for example, with a high --window value) or
> because incremental "git gc" just makes better packs anyway. Throwing
> away that information is often not a good idea.
> 
> The documentation for the --aggressive flag was misleading, in that it
> hints that you'll get a smaller pack, which is often not the case.

This patch might be a good thing. But from ordinary user's point of view
this raises questions: if gc --aggressive really is not that aggressive
then the option itself is misleading. Why not change gc --aggressive to
be really effective? Using high --window/--depth value etc.
