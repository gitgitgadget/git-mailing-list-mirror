From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-pull doesn't update my refs for remotes/origin/master
Date: Mon, 25 Jul 2011 10:35:42 +0200
Message-ID: <4E2D2ADE.40407@drmicha.warpmail.net>
References: <4E2D223E.8090505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 10:35:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlGdk-0005S5-59
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 10:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab1GYIfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 04:35:47 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44472 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750864Ab1GYIfp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2011 04:35:45 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6C6F720C07;
	Mon, 25 Jul 2011 04:35:45 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 25 Jul 2011 04:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=2H+Wg1dcWuvMru5gGEF+nT
	phqxo=; b=XEWABhenxZMq1BNEej5sL+LhPdzd46unk3Sp9jC0qrIbbOPY2tzYJs
	GTcFo0/9amLUTU0+mbigWJ/Qruohb1rxdAiAIcyjM+8P2dCFRW25m6ZUhq2MP7cb
	im/PA8LLgHC8ElgZmNjD+mIWxJUThvsVu97/ucDSKunpqP6/DC6l0=
X-Sasl-enc: 5t9gqiJfvJG01Zpr5Jz6+OVFxlY1ZuNA6h9op91d3u3q 1311582945
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EDF1B454192;
	Mon, 25 Jul 2011 04:35:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4E2D223E.8090505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177785>

Graeme Geldenhuys venit, vidit, dixit 25.07.2011 09:58:
> Hi,
> 
> Any idea why this happens? When I do a 'git pull origin master' while in
> the master branch, it fetches all the latest commits, but doesn't update
> the 'remotes/origin/master' reference. When I do a 'gitk', the
> remotes/origin/master reference is still pointing to the old original
> HEAD commit. Only when I do a 'git push origin master', does it update
> the remotes/origin/master references?
> 
> I'm using git version 1.7.0.4 as is include with Ubuntu 10.04
> 
> Here is my .git/config file:
...

Here's my quote from git-pull's man page:

A parameter <ref> without a colon is equivalent to <ref>: when
pulling/fetching, so it merges <ref> into the current branch without
               storing the remote branch anywhere locally

I.e., just do "git pull origin".

Michael
