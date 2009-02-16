From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 18:33:08 +0100
Message-ID: <vpq4oyu70dn.fsf@bauges.imag.fr>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org>
	<20090215232013.GA11543@zakalwe.fi>
	<20090216000443.GB3503@coredump.intra.peff.net>
	<alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm>
	<alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
	<alpine.LNX.1.00.0902160322530.19665@iabervon.org>
	<7veixybw7u.fsf@gitster.siamese.dyndns.org>
	<loom.20090216T101457-231@post.gmane.org>
	<20090216135812.GA20377@coredump.intra.peff.net>
	<49999ED6.7010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 19:20:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ857-0008Jo-Sb
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 19:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbZBPSTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 13:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbZBPSTI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 13:19:08 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:33009 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbZBPSTH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 13:19:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n1GHX8um002393;
	Mon, 16 Feb 2009 18:33:09 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LZ7LA-0002H3-Ko; Mon, 16 Feb 2009 18:33:08 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LZ7LA-00039U-IR; Mon, 16 Feb 2009 18:33:08 +0100
In-Reply-To: <49999ED6.7010608@gmail.com> (Sergio Callegari's message of "Mon\, 16 Feb 2009 18\:13\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110225>

Sergio Callegari <sergio.callegari@gmail.com> writes:

> I guess that git does not let you commit on a detached head without
> crying out loud.

For some definition of "crying out loud" only ;-)

$ git branch
* (no branch)
  master
$ git commit -a -m foo
[detached HEAD b27b4e3] foo
 1 files changed, 1 insertions(+), 2 deletions(-)

-- 
Matthieu
