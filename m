From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 20:30:39 +0200
Message-ID: <878ws7w8xc.fsf@iki.fi>
References: <20081029003931.GA7291@sigill.intra.peff.net>
	<1225241048-99267-1-git-send-email-dsymonds@gmail.com>
	<C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com>
	<alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<08FC4756-8890-449D-BB55-90E4761C9B93@wincent.com>
	<alpine.DEB.1.00.0810291801580.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<E4E10B61-FA92-417C-9046-F9DE3B48C2A6@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 19:32:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvFqE-00020o-Q3
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 19:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbYJ2SbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 14:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbYJ2SbL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 14:31:11 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:49576 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbYJ2SbK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 14:31:10 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B8900851255; Wed, 29 Oct 2008 20:30:42 +0200
In-Reply-To: <E4E10B61-FA92-417C-9046-F9DE3B48C2A6@wincent.com> (Wincent Colaiuta's message of "Wed\, 29 Oct 2008 18\:42\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99388>

Wincent Colaiuta (2008-10-29 18:42 +0100) wrote:

> El 29/10/2008, a las 18:03, Johannes Schindelin escribi=F3:
>> I completely disagree. If the existing set of commands causes
>> confusion, we need to deprecate those parts and add new commands.
>> Even if we have a ton of commands already.
>
> The confusion isn't at the command level; it's at the switch/option
> level. The solution isn't to add a new command.

I don't remember being confused in particular area but I think it's a
_very_ good thing that the following three are behind the same "diff"
command:

    git diff
    git diff --cached       (or --staged)
    git diff HEAD

It's also good idea to pretty much always teach those three together.
