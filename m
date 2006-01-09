From: lamikr <lamikr@cc.jyu.fi>
Subject: undoing changes with git-checkout -f
Date: Mon, 09 Jan 2006 23:16:52 +0200
Message-ID: <43C2D2C4.2010904@cc.jyu.fi>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Feb 01 09:21:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4DBy-000859-TY
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 09:18:18 +0100
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id k09LEcUK040274
	for <gcvg-git@gmane.org>; Mon, 9 Jan 2006 22:14:49 +0100 (CET)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWAIVL6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 16:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWAIVL6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 16:11:58 -0500
Received: from posti6.jyu.fi ([130.234.4.43]:4829 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S1750738AbWAIVLz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 16:11:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti6.jyu.fi (8.13.4/8.13.4) with ESMTP id k09LBr1b005448
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 23:11:53 +0200
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.44])
	by posti6.jyu.fi (8.13.4/8.13.4) with ESMTP id k09LBe2H005432
	for <git@vger.kernel.org>; Mon, 9 Jan 2006 23:11:41 +0200
Received: from [127.0.0.1] (aragorn.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id E4DDA4681A9
	for <git@vger.kernel.org>; Mon,  9 Jan 2006 23:16:52 +0200 (EET)
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15392>

Hi

Can somebody tell have I understood git-checkout -f wrong as following
does not work as I thought
1) I clone git repo by using command

    git-clone rsync://source.mvista.com/git/linux-omap-2.6.git
linux-omap-2.6

2) I go to cloned repo and create there a new file
    cd linux-omap-2.6
    echo "test" > 1.txt

3) I want to undo the creation of 1.txt by using command
    git-checkout -f

but for some reason the 1.txt is still displayed in the root of
linux-omap-2.6 directory. (I have also tried "git-reset --hard" but
seems to have same effect)
What am I doing wrong?

Mika
