From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Fix --cherry-pick with given paths
Date: Wed, 11 Jul 2007 02:22:04 +1200
Message-ID: <4693960C.1010906@vilain.net>
References: <469378AB.7030909@vilain.net> <4693800F.4010308@vilain.net> <Pine.LNX.4.64.0707101449220.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:21:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GbB-0002pu-2b
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbXGJOVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbXGJOVu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:21:50 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:39038 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbXGJOVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 10:21:49 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 413DA21CECB; Wed, 11 Jul 2007 02:21:48 +1200 (NZST)
Received: from [192.168.1.3] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 68F7621CEB2;
	Wed, 11 Jul 2007 02:21:43 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <Pine.LNX.4.64.0707101449220.4047@racer.site>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52080>

Johannes Schindelin wrote:
> If you say --cherry-pick, you do not want to see patches which are
> in the upstream.  If you specify paths with that, what you usually
> expect is that only those parts of the patches are looked at which
> actually touch the given paths.
>
> With this patch, that expectation is met.
>
> Noticed by Sam Vilain.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>   

I just tested this, and it seems to work just like I hoped, so:

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>

Sam.
