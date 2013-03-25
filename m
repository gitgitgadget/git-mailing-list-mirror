From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/3] t7800: run --dir-diff tests with and without
 symlinks
Date: Mon, 25 Mar 2013 11:02:20 +0000
Message-ID: <20130325110220.GF2286@serenity.lan>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <cf71cc8757c7cb59e93d762fba922635c077376d.1364045138.git.john@keeping.me.uk>
 <514FFC3C.3010203@viscovery.net>
 <20130325103516.GC2286@serenity.lan>
 <51502E00.7070904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 12:03:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK5BH-0003ka-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 12:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371Ab3CYLCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 07:02:42 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:44064 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757074Ab3CYLCl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 07:02:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 695F5CDA5A9;
	Mon, 25 Mar 2013 11:02:40 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ZCUywWZjzRu; Mon, 25 Mar 2013 11:02:33 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 746D3CDA5DB;
	Mon, 25 Mar 2013 11:02:22 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <51502E00.7070904@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219030>

On Mon, Mar 25, 2013 at 11:59:12AM +0100, Johannes Sixt wrote:
> Am 3/25/2013 11:35, schrieb John Keeping:
> > On Mon, Mar 25, 2013 at 08:26:52AM +0100, Johannes Sixt wrote:
> >> The series looks good, but I can't test it because it does not apply
> >> anywhere here.
> > 
> > It's built on top of da/difftool-fixes, is there some problem that stops
> > it applying cleanly on top of that?
> 
> Thanks. I had only tried trees that were "contaminated" by
> jk/difftool-dir-diff-edit-fix, which is in conflict with da/difftool-fixes.

I think they merge OK, but I suspect git-am won't apply the patches
cleanly on top of the result.

> t7800 passes on Windows with these patches.

Thanks.
