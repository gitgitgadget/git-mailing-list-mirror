From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
Date: Mon, 20 Sep 2010 23:13:13 +0200
Message-ID: <vpqvd6086fq.fsf@bauges.imag.fr>
References: <cover.1285013802.git.kirr@landau.phys.spbu.ru>
	<cover.1285013802.git.kirr@landau.phys.spbu.ru>
	<3c344d9b8f014ccb96dc37dc42668426fb5a3c30.1285013802.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Mon Sep 20 23:18:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxnl9-0004M7-75
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 23:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab0ITVSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 17:18:41 -0400
Received: from imag.imag.fr ([129.88.30.1]:64136 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754380Ab0ITVSl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 17:18:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8KLDDwp017613
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Sep 2010 23:13:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oxnfl-0008SW-Qn; Mon, 20 Sep 2010 23:13:13 +0200
In-Reply-To: <3c344d9b8f014ccb96dc37dc42668426fb5a3c30.1285013802.git.kirr@landau.phys.spbu.ru> (Kirill Smelkov's message of "Tue\, 21 Sep 2010 00\:39\:45 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Sep 2010 23:13:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156670>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> (Description partly by Matthieu Moy)

Better put such statements at the end, to avoid distracting the reader.

> ~~~~
>
> NOTE: git diff doesn't try to textconv the pathnames, it runs the
> textual diff without textconv, which is the expected behavior.

It's not clear whether this is intended to stay in the commit message.
If not, it should go below the ---. If yes, then I'd incorporate this
into the message itself. The ~~~~ and NOTE look odd.

For example (in next patch):

| Instead get the mode from either worktree, index, .git, or origin
| entries when blaming and pass it to textconv_object() as context.
| 
| The reason to do it is not to run textconv filters on symlinks
+ (just like "git diff" already does).

Anyway, I'm bikeshedding. With or without these remarks,

Reviewed-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
