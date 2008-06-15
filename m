From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Documentation: Note about the meaning of "clone"
Date: Sun, 15 Jun 2008 15:52:38 +0200
Message-ID: <D6D7C2A1-C755-4564-AB85-B893FA3000D0@wincent.com>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz> <m3od63ozuf.fsf@localhost.localdomain> <200806151505.27686.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Vaclav Hanzl <hanzl@noel.feld.cvut.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 15:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7sgf-0006FR-JM
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 15:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbYFONx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jun 2008 09:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757516AbYFONx1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 09:53:27 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:44146 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473AbYFONx0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jun 2008 09:53:26 -0400
Received: from cuzco.lan (185.pool85-53-11.dynamic.orange.es [85.53.11.185])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m5FDqcMp007801
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 15 Jun 2008 09:52:40 -0400
In-Reply-To: <200806151505.27686.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85092>

El 15/6/2008, a las 15:05, Robin Rosenberg escribi=F3:

> Clarify that a clone is not an exact copy.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
> Documentation/git-clone.txt |    7 ++++++-
> 1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
> index 7973e6a..c9bc627 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -31,7 +31,12 @@ This default configuration is achieved by =20
> creating references to
> the remote branch heads under `$GIT_DIR/refs/remotes/origin` and
> by initializing `remote.origin.url` and `remote.origin.fetch`
> configuration variables.
> -
> ++
> +*NOTE*: Although this command is called clone, the clone is not =20
> identical
> +in all respects. Local branches in the repository being cloned
> +becomes remote tracking branches in the clone and remote tracking

Grammar: "become", not "becomes"

>
> +branches are not cloned at all. For security reasone the config =20
> sections
> +and triggers are not cloned either.

Typo: "security reasons", not "security reasone"

You might also want to mention that the clone is not necessarily a =20
redundant _copy_ of the original repo, because at least for local =20
clones on the same file system clone will use hard links rather than =20
actually making a copy, unless you explicitly tell it not to.

W
