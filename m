From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] bash: Enable completion for external subcommands
Date: Tue, 23 Feb 2010 16:50:07 +0100
Message-ID: <20100223155007.GB10772@neumann>
References: <1266936193-10644-1-git-send-email-teemu.matilainen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Teemu Matilainen <teemu.matilainen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Feb 23 16:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njx1j-0004sX-2e
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 16:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab0BWPuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 10:50:16 -0500
Received: from francis.fzi.de ([141.21.7.5]:7988 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753186Ab0BWPuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 10:50:15 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Feb 2010 16:50:07 +0100
Content-Disposition: inline
In-Reply-To: <1266936193-10644-1-git-send-email-teemu.matilainen@iki.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 23 Feb 2010 15:50:07.0717 (UTC) FILETIME=[DF920950:01CAB49F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140806>

Hi,


On Tue, Feb 23, 2010 at 04:43:12PM +0200, Teemu Matilainen wrote:
> Now the parameter completion is only available for subcommands
> delivered with git.  Providers of external subcommands do not have
> a way to supply bash completion for their commands (other than
> instructing users to hack their git-completion.bash file).
>
> This makes it possible to have completion also for external git
> subcommands.  It can be provided by specifying a function (or a
> command in PATH) '_git_<subcommand>' that sets the environment
> variable COMPREPLY.
>
> All dashes (-) in the subcommand name are replaced with underscores
> (_).  E.g. completion for command 'git foo-bar' can be provided by
> '_git_foo_bar'.
>
> Signed-off-by: Teemu Matilainen <teemu.matilainen@iki.fi>

this issue was raised a few weeks ago, and the discussion led to a
similar patch back then.  However, Junio mentioned a few concerns
regarding this approach, and, since it was v1.7.0-rc time and this was
clearly a post v1.7.0 change, I didn't pursue the discussion and
didn't send updated patches, and then forgot it completely.  I will
try to find some time in the evening to get the commit messages in
shape send out the updates.  In the meantime please have a look at
Junio's concerns about this approach:
http://thread.gmane.org/gmane.comp.version-control.git/138316/focus=3D1=
38348


Best,
G=E1bor
