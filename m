From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Help with rebase after cvsimport
Date: Sat, 27 Mar 2010 18:22:29 +0100
Message-ID: <4BAE3ED5.6080808@drmicha.warpmail.net>
References: <bcd06dea1003250935q324b2412g959309070491c73c@mail.gmail.com> 	<bcd06dea1003251037j492bfbbcx2f99ad5046169f2@mail.gmail.com> 	<4BAC7BAC.7030507@drmicha.warpmail.net> <bcd06dea1003260910h6e27fdfbh9f968bf5ca4c1b6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Brice Ruth <bdruth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 18:22:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvZiD-0005GI-4M
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 18:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679Ab0C0RWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 13:22:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36835 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753650Ab0C0RWK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 13:22:10 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 06825E9F32;
	Sat, 27 Mar 2010 13:22:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 27 Mar 2010 13:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=77GRZOSaqkCbdwJgCHEje/sSbvA=; b=B3f9z6Jw/c4A0YgJGEB3NoIHYEqYLI0Q1L4Yk6+lOM0NR8NQ/EVi+0hgGub7YDBS0sGlRUGf2OTreROqGIQVwasAbJB7ouuwlWlYpRGVoFkGpr3dkY4OjhqFkkH3aQ9XzLa9fUEFog+j5zaLWZ1rndy3pK1KFBpQrRAPL6HK+nI=
X-Sasl-enc: rTx9CETa0JZZyL9To9Ouciljpd/UEyscyK0oTOy2xk6F 1269710529
Received: from localhost.localdomain (p3EE29960.dip0.t-ipconnect.de [62.226.153.96])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3BB0F2DEFD;
	Sat, 27 Mar 2010 13:22:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <bcd06dea1003260910h6e27fdfbh9f968bf5ca4c1b6e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143339>

Brice Ruth venit, vidit, dixit 26.03.2010 17:10:
> So, when you write "Note that by doing that you basically discard your
> version of commits which made the git-cvs-git roundtrip" - I will lose
> the individual commits I made locally and I'll just see the *one*
> exportcommit that I made for my local changes, is that right?

The way I use git-cvs, I have one cvs commit per git commit. Are you
using it differently?

The rebase will discard those commits whose patch text is already
"present" on the branch. I assume that for a cumulative patch this means
it's not ignored - in that case the rebase won't buy you anything.

Michael
