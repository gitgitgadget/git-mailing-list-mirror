From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: help: bisect single file from repos
Date: Mon, 07 Dec 2009 16:08:10 +0100
Message-ID: <4B1D1A5A.9060004@drmicha.warpmail.net>
References: <4B1CFC4C.6090406@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: wharms@bfs.de
X-From: git-owner@vger.kernel.org Mon Dec 07 16:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHfDh-000672-3e
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 16:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935245AbZLGPJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 10:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbZLGPJW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 10:09:22 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46997 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935242AbZLGPJV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 10:09:21 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B6E79C5553;
	Mon,  7 Dec 2009 10:09:27 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 07 Dec 2009 10:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=qSDrevTOumM01aIPdxq/rrECpHE=; b=nVvf+qW3RCISMRChYfHpElMe6wHmMXjgv/0E390vcDTonJFFDWVLXDIr7OAC+hmTGeQpJqXHR4VN9Z/6Enew+rfzabwIIhDsExcIBBewFAkp1i/v6BHTXZGzwxn87Mizqfv/o3QQC/x60eqNwQIHLbk0+nA0WBdA0JduY8WldZk=
X-Sasl-enc: XmdOYEmzGNunPtIPvPO3tUEzjEQMiY7wkVDWpTR3IE1K 1260198567
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0286C4A7E58;
	Mon,  7 Dec 2009 10:09:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091204 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <4B1CFC4C.6090406@bfs.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134758>

walter harms venit, vidit, dixit 07.12.2009 13:59:
> Hi list,
> i am new to git (using: git version 1.6.0.2).

though your git is not that new ;)

> I would like to bisect a single file but i have only commit id, no tags.
> 
> Background:
> I have a copy of the busybox git repos, and i know there is (perhaps) a bug
> in ash.c.
> 
> how can i do that ?

You don't need any tags for bisecting. The man page of git-bisect has
several examples on how to use it. Do you have a test script which
exposes the bug?

Michael
