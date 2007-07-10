From: Sam Vilain <sam@vilain.net>
Subject: Per-file, possibly even per-hunk cherry picking
Date: Wed, 11 Jul 2007 00:16:43 +1200
Message-ID: <469378AB.7030909@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 14:17:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8EeK-0007ux-Tu
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 14:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbXGJMQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 08:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbXGJMQc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 08:16:32 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47385 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbXGJMQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 08:16:31 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 0315621CEB3; Wed, 11 Jul 2007 00:16:28 +1200 (NZST)
Received: from [192.168.1.3] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 61F4321CEA4
	for <git@vger.kernel.org>; Wed, 11 Jul 2007 00:16:23 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52059>

Hi all,

I'm interested in extending the cherry analysis to allow specification
of the diff options used when calculating diff IDs, presenting the
calculated diff IDs for analysis by external tools, and even calculating
and dealing with per-hunk diff IDs.

Has anyone done anything with this before, or got any good pointers or
advice?

Sam.
