From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] Documentation: mention 'git stash pop --index'
	option explicitly
Date: Mon, 8 Jun 2009 23:42:43 +0200
Message-ID: <20090608214243.GK13773@neumann>
References: <27f7124b574aa6ac4391b9bd029242ceb5874447.1244475542.git.szeder@ira.uka.de>
	<7viqj6xvv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:42:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmcJ-0002SF-C4
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbZFHVmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 17:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbZFHVmp
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:42:45 -0400
Received: from francis.fzi.de ([141.21.7.5]:40294 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751089AbZFHVmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:42:44 -0400
Received: from [127.0.1.1] ([91.19.66.149]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 8 Jun 2009 23:42:44 +0200
Content-Disposition: inline
In-Reply-To: <7viqj6xvv8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 08 Jun 2009 21:42:44.0454 (UTC) FILETIME=[0E90E860:01C9E882]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121114>

On Mon, Jun 08, 2009 at 02:23:55PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > -'git stash' (show | drop | pop ) [<stash>]
> > +'git stash' (show | drop ) [<stash>]
> > +'git stash' pop [--index] [<stash>]
> >  'git stash' apply [--index] [<stash>]
>=20
> Why not "(pop | apply) [--index]"?
>=20
> Other than that looks sensible.

Dunno.  I didn't like it somehow, but could not tell why.  But even
then, I should have followed the convention of (show | drop).

Will resend both patch after dinner.
