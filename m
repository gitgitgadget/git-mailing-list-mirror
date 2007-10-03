From: Junio C Hamano <gitster@pobox.com>
Subject: Re: WIP: asciidoc replacement
Date: Tue, 02 Oct 2007 21:48:50 -0700
Message-ID: <7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 06:49:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcwAU-00041C-1Y
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 06:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbXJCEs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 00:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbXJCEs5
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 00:48:57 -0400
Received: from rune.pobox.com ([208.210.124.79]:36095 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbXJCEs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 00:48:57 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 285901409DE;
	Wed,  3 Oct 2007 00:49:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6301F1409DC;
	Wed,  3 Oct 2007 00:49:14 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710030133020.28395@racer.site> (Johannes
	Schindelin's message of "Wed, 3 Oct 2007 01:42:00 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59782>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So here it is: a perl script that does a good job on many .txt files in 
> Documentation/, although for some it deviates from "make man"'s output, 
> and for others it is outright broken.  It is meant to be run in 
> Documentation/.
>
> My intention is not to fix the script for all cases, but to make patches 
> to Documentation/*.txt themselves, so that they are more consistent (and 
> incidentally nicer to the script).

How you spend your time is up to you, but I need to wonder...

 - Is "man" format important for msysGit aka Windows
   environment?  I had an impression that their helpfile format
   were closer to "html" output.

 - Does it make sense in the longer term for us to maintain
   in-house documentation tools?  Can we afford it?

It appears that we heard about breakages for every minor docbook
updates, and it is really appealing if we do not have to rely on
xsl toolchain for manpage generation.  But if patching the text
means making it compatible with the in-house script _and_
incompatible with AsciiDoc, hmmm...
