From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] WinGit: include html pages from official git.git's html branch
Date: Sat, 29 Sep 2007 15:13:25 -0700
Message-ID: <7vr6khjf22.fsf@gitster.siamese.dyndns.org>
References: <A835C8E8-8EC5-43B7-9252-8709214DE7AD@zib.de>
	<11910819531200-git-send-email-prohaska@zib.de>
	<11910819542185-git-send-email-prohaska@zib.de>
	<Pine.LNX.4.64.0709292149280.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 00:13:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbkZB-0007KS-BQ
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 00:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416AbXI2WNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 18:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756379AbXI2WNe
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 18:13:34 -0400
Received: from rune.pobox.com ([208.210.124.79]:57091 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756251AbXI2WNd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 18:13:33 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 176A113DDDF;
	Sat, 29 Sep 2007 18:13:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 766AB13DC5F;
	Sat, 29 Sep 2007 18:13:49 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709292149280.28395@racer.site> (Johannes
	Schindelin's message of "Sat, 29 Sep 2007 21:50:58 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sat, 29 Sep 2007, Steffen Prohaska wrote:
>
>> It is assumed that a matching version of the html documentation
>> is available as the HEAD of /doc/git/html/.git. If not an error
>> will be reported.
>> 
>> This patch doesn't include a mechanism to fetch the html pages
>> to /doc/git/html/.git. You should manually clone them. Maybe
>> this could handled as a submodule of msysgit?
>
> I'd rather handle it as in git.git, as another branch, and not check it 
> out in /git/html/, but rather use "git read-tree 
> --prefix=/tmp/WinGit/share/git/html origin/html", or some such.

This is starting to smell like an opportunity to use the gitlink
stuff, isn't it?
