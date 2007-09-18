From: Sam Vilain <sam@vilain.net>
Subject: Re: git-fsck/lost-found's speed vs git-prune's
Date: Tue, 18 Sep 2007 21:14:37 +1200
Message-ID: <46EF96FD.1050602@vilain.net>
References: <20070918090926.GA8927@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:13:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXZ9O-0007c6-4N
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbXIRJNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbXIRJNl
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:13:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43042 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbXIRJNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:13:40 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 315B923C263; Tue, 18 Sep 2007 21:13:39 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 7D3A323C262;
	Tue, 18 Sep 2007 21:13:35 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20070918090926.GA8927@glandium.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58559>

Mike Hommey wrote:
> Hi,
>
> I was wondering if that was to be expected for git-fsck to be
> significantly slower than git-prune (by several orders of magnitude) ?
>
> $ time git-lost-found
>
> real    8m22.167s
> user    6m44.153s
> sys     1m16.613s
>
> $ time git-prune
>
> real    0m0.376s
> user    0m0.304s
> sys     0m0.000s
>   

You're probably already packed. I'd expect a similar speed difference
between git-fsck and git-fsck --full.

Sam.
