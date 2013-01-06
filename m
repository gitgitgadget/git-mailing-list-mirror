From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] docs: manpage XML depends on asciidoc.conf
Date: Sun, 6 Jan 2013 12:33:26 +0000
Message-ID: <20130106123326.GF6440@serenity.lan>
References: <20130105160017.GD6440@serenity.lan>
 <20130105232800.GF3247@elie.Belkin>
 <7vbod2pzxd.fsf@alter.siamese.dyndns.org>
 <20130106120153.GB22081@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sergey Vlasov <vsu@altlinux.ru>,
	Thomas Ackermann <th.acker66@arcor.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 13:34:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrpQP-0004wL-0n
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 13:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab3AFMdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 07:33:39 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:42863 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab3AFMdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 07:33:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 75C4BCDA566;
	Sun,  6 Jan 2013 12:33:37 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTkO7q2iZqrD; Sun,  6 Jan 2013 12:33:37 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id DBF82CDA571;
	Sun,  6 Jan 2013 12:33:36 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7049E161E3E9;
	Sun,  6 Jan 2013 12:33:36 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-lD+ga6U7Rl; Sun,  6 Jan 2013 12:33:36 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C4348161E54C;
	Sun,  6 Jan 2013 12:33:28 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130106120153.GB22081@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212798>

On Sun, Jan 06, 2013 at 04:01:53AM -0800, Jonathan Nieder wrote:
> When building manual pages, the source text is transformed to XML with
> AsciiDoc before the man pages are generated from the XML with xmlto.
> 
> Fix the dependencies in the Makefile so that the XML files are rebuilt
> when asciidoc.conf changes and not just the manual pages from
> unchanged XML, and move the dependencies from a recipeless rule to the
> rules with commands that use asciidoc.conf to make the dependencies
> easier to understand and maintain.
> 
> Reported-by: John Keeping <john@keeping.me.uk>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

This fixes the problem I wanted to fix (as well as being clearer for the
future), so FWIW:

Tested-by: John Keeping <john@keeping.me.uk>
