From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/3] t7800: run --dir-diff tests with and without
 symlinks
Date: Tue, 26 Mar 2013 09:22:32 +0000
Message-ID: <20130326092232.GH2286@serenity.lan>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <cf71cc8757c7cb59e93d762fba922635c077376d.1364045138.git.john@keeping.me.uk>
 <514FFC3C.3010203@viscovery.net>
 <20130325103516.GC2286@serenity.lan>
 <51502E00.7070904@viscovery.net>
 <7vobe7w3m9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 10:23:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKQ67-0004Op-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 10:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934306Ab3CZJWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 05:22:47 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:47176 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934019Ab3CZJWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 05:22:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 66E57161E52C;
	Tue, 26 Mar 2013 09:22:45 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yMWKracwxPMk; Tue, 26 Mar 2013 09:22:44 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 05F7B161E325;
	Tue, 26 Mar 2013 09:22:34 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vobe7w3m9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219147>

On Mon, Mar 25, 2013 at 02:50:38PM -0700, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Am 3/25/2013 11:35, schrieb John Keeping:
> >> On Mon, Mar 25, 2013 at 08:26:52AM +0100, Johannes Sixt wrote:
> >>> The series looks good, but I can't test it because it does not apply
> >>> anywhere here.
> >> 
> >> It's built on top of da/difftool-fixes, is there some problem that stops
> >> it applying cleanly on top of that?
> >
> > Thanks. I had only tried trees that were "contaminated" by
> > jk/difftool-dir-diff-edit-fix, which is in conflict with da/difftool-fixes.
> 
> Yes, the conflict was unpleasant to deal with.  John, I think what
> is queued on 'pu' is OK, but please double check after I push it out
> in a few hours.

The result looks good to me.
