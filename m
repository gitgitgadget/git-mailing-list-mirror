From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 04 Oct 2007 07:40:26 -0700
Message-ID: <7vhcl79c4l.fsf@gitster.siamese.dyndns.org>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	<20071004125641.GE15339@genesis.frugalware.org>
	<7vy7ej9g38.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0710041534000.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 16:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdRsb-000505-AE
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 16:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbXJDOkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 10:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756154AbXJDOkg
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 10:40:36 -0400
Received: from rune.pobox.com ([208.210.124.79]:43197 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756120AbXJDOkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 10:40:35 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id CB39F140FF6;
	Thu,  4 Oct 2007 10:40:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CFAFC141B40;
	Thu,  4 Oct 2007 10:40:51 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710041534000.4174@racer.site> (Johannes
	Schindelin's message of "Thu, 4 Oct 2007 15:34:45 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59956>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 4 Oct 2007, Junio C Hamano wrote:
>
>>  * --cached means work only on index and ignore work tree.
>
> I guess I could live with "--staged" as a synonym for "--cached" (and 
> maybe deprecating "--cached").

A handy mnemonic might be:

 * --index means work work tree through the index.  Once you get
   git, this is natural as you would not interact with files in
   the work tree that is not known to the index.

 * --cached means work only on the cached information in index.

Any change like swapping them or renaming --cached to --index
and making something else to mean what --index always meant will
break existing setups and people's scripts.  Won't happen.

Giving them synonyms without deprecation is a viable option, if
necessary.  I do not however see the need yet.  A few people who
haven't learned the lingo of the land yet can worry about
possible confusion, but I do not think that "worry" itself does
not count as real need.
