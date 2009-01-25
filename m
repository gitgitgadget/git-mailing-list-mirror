From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 18:18:21 +0100
Message-ID: <20090125171821.GA5881@atjola.homenet>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <glhqdi$tec$1@ger.gmane.org> <alpine.DEB.1.00.0901251509550.14855@racer> <200901251722.53392.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 18:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR8et-000757-QD
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 18:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbZAYRTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2009 12:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbZAYRTI
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 12:19:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:53129 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751110AbZAYRTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 12:19:05 -0500
Received: (qmail invoked by alias); 25 Jan 2009 17:19:03 -0000
Received: from i577BA873.versanet.de (EHLO atjola.local) [87.123.168.115]
  by mail.gmx.net (mp036) with SMTP; 25 Jan 2009 18:19:03 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19UR+AO0rtUR6UIRFWBXnLlFGmuiIQYJcrdjXShVI
	G2gnJVWRKIf6nb
Content-Disposition: inline
In-Reply-To: <200901251722.53392.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107067>

On 2009.01.25 17:22:52 +0100, Jakub Narebski wrote:
> Or perhaps:
>=20
> 	merge A' D' into B Merge bla/blub

That would be confusing. I'd read it as:

git checkout B
git merge A' D'

But the point of B is just to tell rebase that the original merge commi=
t
B is replaced by this new merge commit, so that B' works later.

Bj=F6rn
