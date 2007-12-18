From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 15:18:50 -0800
Message-ID: <7vzlw7wq05.fsf@gitster.siamese.dyndns.org>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	<20071218204623.GC2875@steel.home>
	<200712182224.28152.jnareb@gmail.com>
	<20071218222032.GH2875@steel.home>
	<Pine.LNX.4.64.0712182239500.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dana How <danahow@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 00:19:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lin-0006ck-Fn
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 00:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbXLRXTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 18:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbXLRXTJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 18:19:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbXLRXTI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 18:19:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E67916A06;
	Tue, 18 Dec 2007 18:18:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2589269E4;
	Tue, 18 Dec 2007 18:18:53 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712182239500.23902@racer.site> (Johannes
	Schindelin's message of "Tue, 18 Dec 2007 22:43:52 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68845>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And I still maintain that expecting <tree-ish>:<path> to take the current 
> relative path into account would be just like if you expected
>
> 	C:\> cd WINDOWS
> 	C:\WINDOWS> dir D:system32
>
> to show you the contents of D:\WINDOWS\system32.
>
> Or another, less Windowsy example:
>
> 	$ cd /usr/bin
> 	$ scp home:bash ./
>
> No, this does not copy home:/usr/bin/bash but home:$HOME/bash.

Please do not cc me on this topic, unless it is a patch implementing
suggestion from Linus to treat $commit^{tree} as relative to $(cwd) but
for only when the user directly specified that in full, including ^{tree}
part.
