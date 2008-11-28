From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: remote branch checkout issue, why its *(no branch)
Date: Sat, 29 Nov 2008 00:24:59 +0100
Message-ID: <20081128232459.GA5956@atjola.homenet>
References: <9e6474ae0811281415n7b4596afq7b3ce25816d9a639@mail.gmail.com> <m3k5anjxcd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sudipta GHOSH <sudipta.in@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 00:26:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Cj7-0003gc-EJ
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 00:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYK1XZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Nov 2008 18:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYK1XZF
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 18:25:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:58973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752720AbYK1XZE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 18:25:04 -0500
Received: (qmail invoked by alias); 28 Nov 2008 23:25:00 -0000
Received: from i577B9A57.versanet.de (EHLO atjola.local) [87.123.154.87]
  by mail.gmx.net (mp067) with SMTP; 29 Nov 2008 00:25:00 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19KEx58G+lKb4D+tUtemolUAqlKCiw5c11zlNarLE
	7QJ710mDohEgQo
Content-Disposition: inline
In-Reply-To: <m3k5anjxcd.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101892>

On 2008.11.28 14:32:56 -0800, Jakub Narebski wrote:
> What you can do is to create _local_ branch, closely tied to
> remote-tracking branch 'origin/B1', by using:
>=20
>   $ git branch -b B1 --track origin/B1

You mixed up checkout and branch there ;-)

It's either

git branch B1 origin/B1 # Just create a branch B1

or

git checkout -b B1 origin/B1 # Create and checkout B1

I omitted the "--track" as, by default, it is implied when you create a
new branch from a remote tracking branch.

Bj=F6rn
