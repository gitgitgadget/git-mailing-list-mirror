From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Export GIT_DIR after setting it
Date: Thu, 15 May 2008 20:44:23 +0200
Message-ID: <20080515184423.GA13535@atjola.homenet>
References: <1210807401-11201-1-git-send-email-madduck@madduck.net> <7vod78i9r7.fsf@gitster.siamese.dyndns.org> <20080515101523.GA31719@lapse.madduck.net> <7vlk2bh45u.fsf@gitster.siamese.dyndns.org> <20080515175555.GA13003@atjola.homenet> <20080515182806.GA14799@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu May 15 20:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwiSI-0008U9-5r
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 20:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbYEOSo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2008 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756450AbYEOSo2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 14:44:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:51191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755272AbYEOSo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 14:44:27 -0400
Received: (qmail invoked by alias); 15 May 2008 18:44:25 -0000
Received: from i577AEBEF.versanet.de (EHLO atjola.local) [87.122.235.239]
  by mail.gmx.net (mp031) with SMTP; 15 May 2008 20:44:25 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+3KspkvHi3lgW21d64/lZr3FU9Hf+fCwbUdf3rE+
	Ztr+pNBfixVc7b
Content-Disposition: inline
In-Reply-To: <20080515182806.GA14799@lapse.madduck.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82218>

On 2008.05.15 19:28:06 +0100, martin f. krafft wrote:
> also sprach Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> [2008.05.15.1855=
 +0100]:
> > It kind of feels like a bug that git-pull does not export GIT_DIR t=
here,
> > but you could probably also argue that it is wrong not to have GIT_=
DIR
> > set in the environment when using a non-standard name for the git d=
ir.
> > Hm?
>=20
> Ah, but it is a standard name: .
>=20
> If git does not find .git, it *does* seem to look into the current
> directory too; that's why commands work inside bare repos...

Yeah, but this is not a bare repo. As far as I understood Junio, it is
at least an error to use GIT_DIR without GIT_WORK_TREE (or
core.worktree), so I'm just thinking that it may also be an error to us=
e
GIT_WORK_TREE (or core.worktree) without GIT_DIR.

Bj=F6rn
