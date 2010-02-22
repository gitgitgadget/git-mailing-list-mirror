From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: working out where git-rebase is up to?
Date: Mon, 22 Feb 2010 11:26:47 +0100
Message-ID: <201002221126.47372.trast@student.ethz.ch>
References: <2cfc40321002220209pe1942ecucb3716f60bf05d32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 13:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVV8-0008Cw-RJ
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab0BVK0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 05:26:49 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:25412 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab0BVK0t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:26:49 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 11:26:48 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 11:26:47 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <2cfc40321002220209pe1942ecucb3716f60bf05d32@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140670>

On Monday 22 February 2010 11:09:18 Jon Seymour wrote:
> Hi,
> 
> For my funky "compensating rebases" I need to know where an automated
> rebase has stopped. In particular, I need to know the sha1 of the
> commit that caused the rebase to stop.
> 
> No doubt rebase is tracking this info, but is there a supported way to
> discover it?

It's in .git/rebase-merge/done (and .git/rebase-merge/git-rebase-todo
for the remaining TODO file).  Maybe we should add a 'git rebase
--whydiditstop' command ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
