From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Fri, 9 Nov 2007 20:48:34 +0100
Message-ID: <200711092048.34868.robin.rosenberg.lists@dewire.com>
References: <11945685673280-git-send-email-dsymonds@gmail.com> <11945685732608-git-send-email-dsymonds@gmail.com> <7vtznwxl59.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 21:23:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqaNg-0007zV-8N
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 21:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbXKIUWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 15:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbXKIUWw
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 15:22:52 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18501 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbXKIUWv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 15:22:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 93F998026C9;
	Fri,  9 Nov 2007 21:13:49 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13437-03; Fri,  9 Nov 2007 21:13:49 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 260B48026F3;
	Fri,  9 Nov 2007 21:13:49 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vtznwxl59.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64258>

fredag 09 november 2007 skrev Junio C Hamano:
> David Symonds <dsymonds@gmail.com> writes:
> 
> > Signed-off-by: David Symonds <dsymonds@gmail.com>
> > ---
> > 	Test 5 in this series fails because of a bug in git-ls-files, where
> > 		git-ls-files t/../
> > 	(with or without --full-name) returns no files.
> 
> Heh, you shouldn't do that ;-)
> 
> Seriously, that's a long standing limitation in the code, not to
> deal with arbitrary combination of ups and downs, but I do not
> think there is any fundamental reason to disallow something
> like:
> 
> 	cd Documentation && git ls-files --full-name ../t
> 
> Patches welcome.

I'm for allowing it, but then it should really be all over, not just some arbitrary
command. Everywhere or not at all.

-- robin
