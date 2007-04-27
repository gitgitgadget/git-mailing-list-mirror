From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [PATCH] Teach mailsplit about Maildir
Date: Fri, 27 Apr 2007 15:26:59 +0200
Message-ID: <20070427132659.GD4690@ferdyx.org>
References: <20070427132313.GA5237@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 15:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhQTh-0007Su-8t
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 15:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818AbXD0N1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 09:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbXD0N1J
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 09:27:09 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:50331
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbXD0N1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 09:27:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id AE04B8D33B;
	Fri, 27 Apr 2007 15:04:27 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17654-10; Fri, 27 Apr 2007 15:04:23 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 74F498D305;
	Fri, 27 Apr 2007 15:04:22 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Fri, 27 Apr 2007 15:27:00 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070427132313.GA5237@ferdyx.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45716>

On Fri, Apr 27, 2007 at 03:23:13PM +0200, Fernando J. Pereda wrote:
> Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
> ---
> 
> 	This time I changed the documentation of git-am and git-mailsplit to
> 	state that it can also split Maildirs.
> 
> 	Instead of taking an arbitrary order (like my last patch) it now
> 	relies on filenames to be sorted. Although the Maildir 'spec'
> 	prohibits it, at leas

... at least we found that Pine and Mutt are generating 'sorted
filenames'.

Hit 'send' too early.

- ferdy
