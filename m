From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Per-branch receive.denyNonFastForwards?
Date: Mon, 08 Jun 2009 10:43:05 +0200
Message-ID: <4A2CCF19.9000405@drmicha.warpmail.net>
References: <2729632a0906072220n4dff5d39vaa863401c136c3c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 08 10:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDaRw-0004Uj-TQ
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 10:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbZFHInJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 04:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbZFHInI
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 04:43:08 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52912 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753277AbZFHInI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 04:43:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 187EB35D90B;
	Mon,  8 Jun 2009 04:43:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 08 Jun 2009 04:43:10 -0400
X-Sasl-enc: dhZYwoC4xA/adIoWtSO2Z6FbAxiWSfxnCuBCYRsjC60D 1244450589
Received: from localhost.localdomain (p54859B76.dip0.t-ipconnect.de [84.133.155.118])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 71FE05A1C1;
	Mon,  8 Jun 2009 04:43:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090606 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <2729632a0906072220n4dff5d39vaa863401c136c3c5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121047>

skillzero@gmail.com venit, vidit, dixit 08.06.2009 07:20:
> Is there a way to deny non-fast forward pushes to only certain
> branches? I'd like for people to be able to force push to their own
> branches on the server, but for the master branch (and maybe a couple
> other important branches), I want to prevent it. I basically want a
> per-branch version of receive.denyNonFastForwards. Is there a way to
> do this?

The update-hook example should shows how you could guard specific
branches. If you want to make this user-dependent you may need to look
at gitosis.

Michael
