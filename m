From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git pull --rebase and losing commits
Date: Mon, 2 Nov 2009 16:10:22 +0100
Message-ID: <20091102151022.GA3995@atjola.homenet>
References: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Nov 02 16:10:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4yYL-0001N1-Bp
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 16:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbZKBPKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 10:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbZKBPKa
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 10:10:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:50168 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755340AbZKBPKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 10:10:30 -0500
Received: (qmail invoked by alias); 02 Nov 2009 15:10:33 -0000
Received: from i59F546D3.versanet.de (EHLO atjola.homenet) [89.245.70.211]
  by mail.gmx.net (mp023) with SMTP; 02 Nov 2009 16:10:33 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18yMJJQHHwy8E8PwGa94aJiGKVweQcpvCwzGRJEdx
	FdQ0JGwwwn0kBl
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131911>

On 2009.11.02 13:26:37 +0100, Peter Krefting wrote:
>  # Update tree (--strategy=3Dours avoids merge conflicts)
>  git pull --rebase --strategy=3Dours origin master

The "ours" strategy doesn't just avoid merge conflicts, it avoids makin=
g
any changes at all. The ours strategy means "just keep our state, just
pretend that we've merged". And rebase will see that there were no
changes and conclude:

Already applied: 0001 test commit

And thus it will drop the commit.

Bj=F6rn
