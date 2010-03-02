From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Only the config file changes ...
Date: Tue, 02 Mar 2010 15:46:51 +0100
Message-ID: <4B8D24DB.3080007@drmicha.warpmail.net>
References: <70786312428882320720829319256948501508-Webmail@me.com> <4B8D0FA7.8070206@drmicha.warpmail.net> <1463530E-F729-46CA-881D-A89E6CF89241@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jez Caudle <gitmailinglist@me.com>, git@vger.kernel.org
To: Jez Caudle <jezcaudle@me.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 15:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmTPZ-0006uR-C7
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 15:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab0CBOtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 09:49:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57019 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751352Ab0CBOtT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Mar 2010 09:49:19 -0500
Received: from compute2.internal (compute2 [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4A643E2C9B;
	Tue,  2 Mar 2010 09:49:19 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 02 Mar 2010 09:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=FXephw4BxPDE+2UkUQCIOAEfuv8=; b=qWeR36FEzEN+WEhqt8Xg+GNDb/g0kB3f72bO7eVRLTUxYxKla2Ua4s+n9s9jimqLUoCpCcJY6ui+7zzi7PmyWwiTRFI0gZwJNycueY+xsLWK3GsfevN6a2HVsp2UA13rtmSWfugPXWu2BVJtFx6YDC7s2y72UyQBbH6E3gFbEjY=
X-Sasl-enc: PjDWZf5sd8qD5yf3PWdzjBGjBB4DDEBWmrEFuM4JRO/3 1267541358
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9968F1698B;
	Tue,  2 Mar 2010 09:49:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100301 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <1463530E-F729-46CA-881D-A89E6CF89241@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141397>

Jez Caudle venit, vidit, dixit 02.03.2010 14:26:
> Sounds good.
> 
> The only problem being I find a bug in version C. I fix it in version
> C,

Don't do that :)

> now I want to merge that change back to the master and then out to
> A,B and then D.
> 

If you've done that anyways, you can still cherry-pick that change onto
master, or merge --no-commit and checkout --ours what you don't want merged.

> 
> I'm still reading my Git book but I'm thinking of doing it this way:
> 
> Master has it's own repository. Each version has it's own repository
> that is created by cloning the Master and then removing all the files
> that are not specific removed from the repository. When changes are
> made to the master then simply copy all the non-specific files to
> each of the versions.

I don't think you need to remove any files - you do need them for
testing, don't you? It's just that you don't want to modify them in your
"specific" client repos.

Michael
