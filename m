From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC/PATCH 1/2] improve missing repository error message
Date: Wed, 04 Mar 2009 10:19:25 +0100
Message-ID: <vpqtz69lk6a.fsf@bauges.imag.fr>
References: <20090303184106.GH14365@spearce.org>
	<20090304083229.GA31798@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 10:24:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LenLF-0007YF-Hj
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 10:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbZCDJXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 04:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbZCDJXM
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 04:23:12 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:59926 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbZCDJXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 04:23:11 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n249JPHp005369;
	Wed, 4 Mar 2009 10:19:25 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LenG9-0002vT-BI; Wed, 04 Mar 2009 10:19:25 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LenG9-0006ot-96; Wed, 04 Mar 2009 10:19:25 +0100
In-Reply-To: <20090304083229.GA31798@coredump.intra.peff.net> (Jeff King's message of "Wed\, 4 Mar 2009 03\:32\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.90 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 04 Mar 2009 10:19:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112191>

Jeff King <peff@peff.net> writes:

> +		die("'%s' does not appear to be a git repository", dir);

It may be sensible to distinguish the case where dir exists as a
directory but isn't a repository, and the case where it does not exist
at all, like "directory exists but does not appear to be a git
repository" Vs "no such directory".

Just in case someone does a "mkdir" on the server and doesn't know he
has to "git init" there too.

My 2 cents,

-- 
Matthieu
