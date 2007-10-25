From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: Add -N option to force a new import
Date: Wed, 24 Oct 2007 20:17:40 -0700
Message-ID: <7vfxzz51d7.fsf@gitster.siamese.dyndns.org>
References: <1193268519.8008.11.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 05:18:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IktEN-00084B-KW
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 05:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760000AbXJYDRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 23:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759706AbXJYDRr
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 23:17:47 -0400
Received: from rune.pobox.com ([208.210.124.79]:44178 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757760AbXJYDRq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 23:17:46 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 1438A14D13C;
	Wed, 24 Oct 2007 23:18:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 89E2114D163;
	Wed, 24 Oct 2007 23:18:04 -0400 (EDT)
In-Reply-To: <1193268519.8008.11.camel@mattlaptop2> (Matt McCutchen's message
	of "Wed, 24 Oct 2007 19:28:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62259>

Matt McCutchen <matt@mattmccutchen.net> writes:

> I had a git repository for development of rsync and wanted to start
> importing the upstream CVS with git-cvsimport, but git-cvsimport saw
> that the git repository existed and insisted on updating a previous
> import.  This patch adds an -N option to git-cvsimport to force a new
> import and updates the documentation appropriately.

Sounds like a useful addition.  Tests?
