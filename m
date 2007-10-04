From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 04 Oct 2007 16:44:00 +0200
Message-ID: <vpqtzp7ndn3.fsf@bauges.imag.fr>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	<20071004125641.GE15339@genesis.frugalware.org>
	<7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0710041534000.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 16:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdRyy-00084y-Al
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 16:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917AbXJDOrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 10:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbXJDOrK
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 10:47:10 -0400
Received: from imag.imag.fr ([129.88.30.1]:46445 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538AbXJDOrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 10:47:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l94Ei6gO025863
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Oct 2007 16:44:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IdRvk-0004yd-H2; Thu, 04 Oct 2007 16:44:00 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IdRvk-0000fM-Eb; Thu, 04 Oct 2007 16:44:00 +0200
In-Reply-To: <Pine.LNX.4.64.0710041534000.4174@racer.site> (Johannes Schindelin's message of "Thu\, 4 Oct 2007 15\:34\:45 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 04 Oct 2007 16:44:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59957>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 4 Oct 2007, Junio C Hamano wrote:
>
>>  * --cached means work only on index and ignore work tree.
>
> I guess I could live with "--staged" as a synonym for "--cached" (and 
> maybe deprecating "--cached").

It makes more sense to me.

For me, a "cache" is a fast-access copy of something, that I can
rebuild at any time. Cache should be only a matter of performance, if
the "cache" for an application changes its functionality, it means the
cache has been too optimistic. Git's index is not that, "git add"
means "add this to the index", which itself means "put that in the
list of things to commit", and not "get a copy of that to work faster
with it".

So, to me (non-native speaker), "index" doesn't mean much, "cache" is
worse, it means something which isn't correct, and "staging area"
means the right thing (but is longer to type). For example, I
understand immediately when git-gui talks me about staging/unstaging
changes ;-).

-- 
Matthieu
