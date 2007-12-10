From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't cache DESTDIR in perl/perl.mak.
Date: Mon, 10 Dec 2007 11:24:41 -0800
Message-ID: <7vodcyl5dy.fsf@gitster.siamese.dyndns.org>
References: <20071210093102.3050.qmail@06e91d20307a62.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 20:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1oFh-000370-OV
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 20:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbXLJTY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 14:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbXLJTY4
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 14:24:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835AbXLJTYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 14:24:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CBC5E36F7;
	Mon, 10 Dec 2007 14:24:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 61B0136F6;
	Mon, 10 Dec 2007 14:24:44 -0500 (EST)
In-Reply-To: <20071210093102.3050.qmail@06e91d20307a62.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Mon, 10 Dec 2007 09:31:02 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67747>

Hmph.  That's reverting this:

commit 4c5cf8c44ce06a79da5bafd4a92e6d6f598cea2e
Author: Eric Wong <normalperson@yhbt.net>
Date:   Sun Aug 13 04:13:25 2006 -0700

    pass DESTDIR to the generated perl/Makefile
    
    Makes life for binary packagers easier, as the Perl modules will
    be installed inside DESTDIR.
    
    Signed-off-by: Eric Wong <normalperson@yhbt.net>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

Eric, care to comment?
