From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Thu, 30 Aug 2007 14:33:41 -0700
Message-ID: <7v7inc907e.fsf@gitster.siamese.dyndns.org>
References: <lkbtwek0.fsf@cante.net>
	<Pine.LNX.4.64.0708301107320.28586@racer.site>
	<46D6984D.9040802@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:34:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQreI-0004Ft-44
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 23:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761127AbXH3Vdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 17:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761107AbXH3Vdy
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 17:33:54 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760859AbXH3Vdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 17:33:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EC4A612B5F0;
	Thu, 30 Aug 2007 17:34:09 -0400 (EDT)
In-Reply-To: <46D6984D.9040802@op5.se> (Andreas Ericsson's message of "Thu, 30
	Aug 2007 12:13:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57073>

Andreas Ericsson <ae@op5.se> writes:

> When gc was a shell-script, it was fairly easy to find out the command-
> sequence...

Maybe referring more advanced/curious users to contrib/examples/
directory is a good idea, but not necessarily from manpages of
the commands that have been rewritten in C.

I think contrib/examples/ needs a README file that effectively
say "these are the last versions of shell script implementation
of the commands before they were rewritten in C.  New features
may have been added to the built-in ones but these example
scripts are not kept up to date.  They are here to serve as
examples to show you how you would pipeline the plumbing level
commands."
