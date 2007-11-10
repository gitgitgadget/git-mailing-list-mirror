From: Junio C Hamano <gitster@pobox.com>
Subject: Re: *[PATCH] builtin-commit: Refresh cache after adding files.
Date: Fri, 09 Nov 2007 18:26:23 -0800
Message-ID: <7vve8aq1io.fsf@gitster.siamese.dyndns.org>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0711091702190.4362@racer.site>
	<7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
	<7v640ari76.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711100201310.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 03:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqg3b-0004bK-8v
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 03:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbXKJC0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 21:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbXKJC0c
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 21:26:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45455 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbXKJC0c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 21:26:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BDAF02F2;
	Fri,  9 Nov 2007 21:26:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 501BD93DA5;
	Fri,  9 Nov 2007 21:26:50 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711100201310.4362@racer.site> (Johannes
	Schindelin's message of "Sat, 10 Nov 2007 02:02:31 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64300>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But I think that we still need to refresh the index.

You are correct.  See

    http://article.gmane.org/gmane.comp.version-control.git/64254
