From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-am.txt: advertise 'git am --abort' instead of 'rm
	.git/rebase-apply'
Date: Tue, 22 Mar 2011 21:00:57 +0100
Message-ID: <20110322200056.GH14520@neumann>
References: <1300819345-28279-1-git-send-email-szeder@ira.uka.de>
	<20110322191708.GA23447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:01:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q27lL-0001SP-Jt
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 21:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab1CVUBB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 16:01:01 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:16042 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab1CVUBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 16:01:00 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 22 Mar
 2011 21:00:56 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 22 Mar
 2011 21:00:57 +0100
Content-Disposition: inline
In-Reply-To: <20110322191708.GA23447@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169771>

On Tue, Mar 22, 2011 at 03:17:08PM -0400, Jeff King wrote:
> On Tue, Mar 22, 2011 at 07:42:25PM +0100, SZEDER G=E1bor wrote:
>=20
> > -The command refuses to process new mailboxes while the `.git/rebas=
e-apply`
> > -directory exists, so if you decide to start over from scratch,
> > -run `rm -f -r .git/rebase-apply` before running the command with m=
ailbox
> > +The command refuses to process new mailboxes before the current
> > +operation isn't finished, so if you decide to start over from scra=
tch,
> > +run `git am --abort` before running the command with mailbox
> >  names.
>=20
> Grammar: it should be "...before the current operation is finished".

Thanks; I almost wrote after the '---' that I'm not quite happy with
the wording of the first part of the sentence, but I just couldn't see
why...  at least now I know ;)


Best,
G=E1bor
