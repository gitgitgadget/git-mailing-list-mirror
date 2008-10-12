From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: git status options feature suggestion
Date: Sun, 12 Oct 2008 14:40:25 +0300
Message-ID: <87od1qrqhi.fsf@iki.fi>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
	<20081009061136.GA24288@coredump.intra.peff.net>
	<81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
	<81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
	<alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<48EE1F58.2060707@drmicha.warpmail.net>
	<20081012044900.GA27845@coredump.intra.peff.net>
	<7vwsgegvsh.fsf@gitster.siamese.dyndns.org>
	<971DCAD3-3274-4507-AE3D-5BDCEDB8513C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 13:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KozKd-0007ek-3k
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 13:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYJLLkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 07:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbYJLLkn
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 07:40:43 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:51916 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbYJLLkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 07:40:42 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48DA300B00EFEF77; Sun, 12 Oct 2008 14:40:27 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KozJB-0001Ih-Bx; Sun, 12 Oct 2008 14:40:25 +0300
In-Reply-To: <971DCAD3-3274-4507-AE3D-5BDCEDB8513C@wincent.com> (Wincent Colaiuta's message of "Sun\, 12 Oct 2008 12\:47\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98014>

Wincent Colaiuta <win@wincent.com> writes:

> I think if you're introducing a different command then you should make
> sure it doesn't happen to be an abbreviation of an existing one. It
> would be better to give it some other name (info, foo, whatever). If
> svn people then want to make an "st" alias pointing to it they're free
> to do so.

In Subversion and Bazaar "info" command gives mostly information about
the repository itself. They don't talk about individual files at all.
"status" is the command (also in Mercurial) for getting information
about the current state of files in the tree.

I think it would be really sad if "git status" can't be extended to
match people's needs. I don't like the idea of a new name for such
status command. It's a kind of "why git people always invent new names
for familiar commands?" thing.
