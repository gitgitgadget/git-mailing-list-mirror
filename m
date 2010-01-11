From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 4/6] Documentation: emphasize when git merge terminates early
Date: Tue, 12 Jan 2010 00:11:33 +0100
Message-ID: <201001120011.38704.trast@student.ethz.ch>
References: <cover.1263081032.git.trast@student.ethz.ch> <20100111082123.GA23742@progeny.tock> <20100111083754.GD23806@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	<git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 00:11:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUTQL-0002jt-37
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 00:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab0AKXLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 18:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355Ab0AKXLm
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 18:11:42 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:12724 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab0AKXLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 18:11:41 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 12 Jan
 2010 00:11:40 +0100
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 12 Jan
 2010 00:11:39 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <20100111083754.GD23806@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136678>

Jonathan Nieder wrote:
> +In some other version control systems, you merge/update and then
> +commit, with the risk of clobbering your changes with humongous
> +conflicts. You shouldn't be pulling or merging if you haven't got
> +your own work into good shape and committed it locally (see also
> +linkgit:git-stash[1]).

Isn't it wrong to talk about other VCS, especially when writing down
what Git does *not*?  The user wants to know what git *does*,
otherwise he wouldn't be looking in the manual.

> +If all named commits are already ancestors of `HEAD`, 'git merge'
> +will exit early with the message "Already up-to-date."

<aside>
I suspect this is little-known but the equivalent message for an
octopus is actually: "Already up-to-date. Yeeah!"
</aside>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
