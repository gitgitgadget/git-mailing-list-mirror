From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use "<unknown>" for unknown values of placeholders and suppress printing of empty user formats.
Date: Tue, 25 Sep 2007 17:43:56 -0700
Message-ID: <7vwsue1cj7.fsf@gitster.siamese.dyndns.org>
References: <20070925143846.GQ22869@mageo.cz>
	<Pine.LNX.4.64.0709251543561.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Vitecek <fuf@mageo.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 02:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaL0h-0005c9-3c
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 02:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbXIZAoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 20:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbXIZAoG
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 20:44:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbXIZAoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 20:44:05 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 91B8013C10A;
	Tue, 25 Sep 2007 20:44:21 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709251543561.28395@racer.site> (Johannes
	Schindelin's message of "Tue, 25 Sep 2007 15:47:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59201>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This may have warranted a description in the commit message a la
>
> 	Instead of setting unknown entries to "<unknown>" in the 
> 	interp_table, we teach interpolate() to replace entries with 
> 	NULL values by the empty string.

Indeed.

> Here are still spaces instead of tabs.
>
> These are only minor details; I don't know if Junio wants to fix them 
> himself.

Good eyes.

Also a sign-off is missing ;-)
