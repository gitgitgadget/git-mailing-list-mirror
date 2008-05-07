From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 2/2] Documentation: bisect: add a few "git bisect run"
	examples
Date: Wed, 07 May 2008 11:09:20 -0500
Message-ID: <1210176560.6102.9.camel@ld0161-tx32>
References: <20080507062931.dd72d7e1.chriscool@tuxfamily.org>
	 <7vwsm6g14i.fsf@gitster.siamese.dyndns.org>
	 <vpqlk2mbpao.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	Thomas Adam <thomas.adam22@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed May 07 18:19:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtmMJ-0004SY-UR
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbYEGQSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbYEGQSX
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:18:23 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:56318 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbYEGQSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 12:18:21 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id m47G9Ltv016936;
	Wed, 7 May 2008 09:09:21 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m47G9Kl1021440;
	Wed, 7 May 2008 11:09:20 -0500 (CDT)
In-Reply-To: <vpqlk2mbpao.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.0.2 (2.0.2-35.el4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81459>

On Wed, 2008-05-07 at 08:29 +0200, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +------------
> >> +echo "#"\!"/bin/sh" > ~/test.sh
> >> +echo "make install || exit 125" >> ~/test.sh
> >> +echo "~/check_test_case.sh" >> ~/test.sh
> >> +chmod u+x ~/test.sh
> >
> > s/install//; let's not set a bad example of installing first and then
> > testing.
> 
> Perhaps also s/~/./g, since it's not a good idea to put temporary
> files in $HOME IMHO.
> 
> Also, using simple quotes instead of double would simplify the
> "#"\!"/bin/sh".

Hmm.  I would have just done "$ cat ~/test.sh" and
then shown the file listing directly.

jdl
