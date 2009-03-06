From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 06 Mar 2009 11:51:37 +0100
Message-ID: <vpqwsb2ly9y.fsf@bauges.imag.fr>
References: <Pine.LNX.4.44.0903010945290.4675-100000@localhost.localdomain>
	<49AF9601.9060709@op5.se>
	<43d8ce650903050337n48924fc3l89ef991d578f5849@mail.gmail.com>
	<20090305120602.GA18717@coredump.intra.peff.net>
	<vpq7i34ywjg.fsf@bauges.imag.fr>
	<20090305124512.GA2723@coredump.intra.peff.net>
	<m3eixbszkt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 12:42:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfYRG-0007MQ-Vy
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 12:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbZCFLkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 06:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZCFLke
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 06:40:34 -0500
Received: from ebene.inrialpes.fr ([194.199.18.70]:64953 "EHLO
	ebene.inrialpes.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZCFLke (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 06:40:34 -0500
X-Greylist: delayed 2758 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2009 06:40:33 EST
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by ebene.inrialpes.fr (8.13.6/8.13.8) with ESMTP id n26Apadk028471;
	Fri, 6 Mar 2009 11:51:37 +0100 (MET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LfXeT-0001ok-RB; Fri, 06 Mar 2009 11:51:37 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LfXeT-0002Nb-Oj; Fri, 06 Mar 2009 11:51:37 +0100
In-Reply-To: <m3eixbszkt.fsf@localhost.localdomain> (Jakub Narebski's message of "Fri\, 06 Mar 2009 02\:39\:46 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.90 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ebene.inrialpes.fr [194.199.18.70]); Fri, 06 Mar 2009 11:51:38 +0100 (MET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112426>

Jakub Narebski <jnareb@gmail.com> writes:

> However while toolchain needed to produce documentation (asciidoc +
> xmlto) isn't, I think, something very common, in my opinion autoconf
> is something that is present on systems containing other build tools
> required to build git from sources.

Plus:

* an old ./configure script (taken from a previous tarball release)
  has good chance to work on a new Git. Since Makefile is designed to
  be useable without scripting, Junnio takes great care not to break
  existing setups.

* ./configure script is not mandatory to build Git from sources.

-- 
Matthieu
