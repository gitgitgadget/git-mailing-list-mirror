From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH RESEND] git-svn: don't confuse editors with an
	apostrophe
Date: Sun, 1 May 2011 02:12:06 +0000
Message-ID: <20110501021206.GA23269@dcvr.yhbt.net>
References: <1304077214-1707-1-git-send-email-cmn@elego.de> <7viptxxbr7.fsf@alter.siamese.dyndns.org> <20110429205130.GA2727@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun May 01 04:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGM97-00076f-JH
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 04:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab1EACMK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Apr 2011 22:12:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38491 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab1EACMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2011 22:12:07 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1261FD59;
	Sun,  1 May 2011 02:12:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110429205130.GA2727@bee.lab.cmartin.tk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172527>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> wrote:
> On Fri, Apr 29, 2011 at 09:28:44AM -0700, Junio C Hamano wrote:
>  From his reply (adding Ack) I inferred he expected you to apply it.

Oops, I Acked but forgot to commit + push

> > I suspect that you are talking about syntax highlighting, and some =
syntax
> > highlighter may be stupid to be confused, but in that case, at leas=
t you
> > would need s/editors/some editors/.
>=20
> It confuses emacs and vim and I'd be surprised if any weren't, but
> I'll change the message a bit.

I've pushed the patch with the following message:

Subject: [PATCH] git-svn: avoid contraction in usage text

Contractions may be difficult for non-native English speakers.
The quotation mark may also confuse syntax highlighting in
some text editors.

[ew: reworded commit message]

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
Acked-by: Eric Wong <normalperson@yhbt.net>
--=20
Eric Wong
