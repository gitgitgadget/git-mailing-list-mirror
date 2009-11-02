From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Headless tags don't have a follows or precedes?
Date: Mon, 02 Nov 2009 10:42:07 +0100
Message-ID: <4AEEA96F.7080609@drmicha.warpmail.net>
References: <1257067898626-3926483.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 10:42:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4tR6-0004sv-Qa
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 10:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZKBJml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 04:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZKBJml
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 04:42:41 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:55026 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754105AbZKBJmk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2009 04:42:40 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 37BE6BD330;
	Mon,  2 Nov 2009 04:42:18 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 02 Nov 2009 04:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=opokjoUgeOiW/8hiaOTCkuhcG04=; b=c9xU7CiXXvaas8ChvzpMJfMfILUQylYauwUAhBbO3G1KGJwgLMF6vFe2po7/ZQuLMXaSwwZQ019eEWKA5BUCBgq3QzWSwuJz2wGIh1H5ZOUp0TXPSh5JEpyrwjvWi+C1+Rbsfd7rEjbNLg6UrbKtwBbp1hTy8C1Zu0TD8cw0vuc=
X-Sasl-enc: qsszvT9FKZ+vmKIBEXvkIv29vrKhNf9VSX6EyJU//KW5 1257154932
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 86CC3323AE;
	Mon,  2 Nov 2009 04:42:12 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091102 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <1257067898626-3926483.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131899>

Tim Mazid venit, vidit, dixit 01.11.2009 10:31:
> 
> Hi all,
> 
> I've noticed that if I create a headless tag (one that doesn't have a
> branch, right?), when I click on that commit, it doesn't have precedes or
> follows information. Is this by design? Is there a work-around I can use
> without creating a branch there?

Reposting (without even saying so) doesn't necessarily increase your
chance of getting responses. Would would help:

- saying you're talking about gitk/git view/whatever it is you're
"clicking" on

- providing a minimal example others can reproduce. That would be one
where a tag on a detached head (assuming that's what you mean) has no
precedes/follow but a tag "on a branch" does have that info

Cheers,
Michael
