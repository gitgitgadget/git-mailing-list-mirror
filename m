From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] bash: update 'git svn' options
Date: Mon, 16 Feb 2009 07:54:29 -0800
Message-ID: <20090216155429.GA18525@spearce.org>
References: <1234628513-4573-1-git-send-email-szeder@ira.uka.de> <1234628513-4573-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:55:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5p8-00089z-H8
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 16:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbZBPPyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 10:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbZBPPya
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 10:54:30 -0500
Received: from george.spearce.org ([209.20.77.23]:53618 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbZBPPya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 10:54:30 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 67472381FF; Mon, 16 Feb 2009 15:54:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234628513-4573-2-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110196>

SZEDER G=E1bor <szeder@ira.uka.de> wrote:
> 'git svn' got some new subcommands and otions in the last couple of
> months.  This patch adds completion support for them.
>=20
> In particular:
>=20
>   * 'fetch', 'clone', etc.: '--ignore-paths=3D'
>   * 'init' and 'clone': '--prefix=3D', '--use-log-author',
>                         '--add-author-from'
>   * 'dcommit': '--commit-url', '--revision'
>   * 'log': '--color'
>   * 'rebase': '--dry-run'
>   * 'branch', 'tag', 'blame', 'migrate' subcommands and their options
>=20
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

>  contrib/completion/git-completion.bash |   31 ++++++++++++++++++++++=
+++------
>  1 files changed, 25 insertions(+), 6 deletions(-)

--=20
Shawn.
