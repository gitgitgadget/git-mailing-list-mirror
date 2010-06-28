From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git log and cherry-picks
Date: Mon, 28 Jun 2010 21:07:44 +0200
Message-ID: <4C28F300.1060506@drmicha.warpmail.net>
References: <AANLkTil6-rd5y9xcTVz4kJ4O2jL9ZdXYo1JrgYA3sM6N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 21:07:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTJgJ-0005jD-E1
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 21:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936Ab0F1THm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 15:07:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58193 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753299Ab0F1THm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 15:07:42 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7581E105733;
	Mon, 28 Jun 2010 15:07:40 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 28 Jun 2010 15:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=b292xB+jowGShFxCvk+lUeQnucI=; b=nMkx1yTYGEsGaASU8Tsrj4ilmkIgJ0B7131+k1DioRvEc89ucU+CT6CHfUffe5HvApOLhIza9wEXEe3a2s2hVTujqHCFHfRwl0gxe1X3U09qlR4ET7q2Rh+yQ6U3Q88ozcbTSWGOnqwDZz/w7eKFEngkDmW/AEi98qdfmdzQ3/w=
X-Sasl-enc: ao4yR6UbkG7W/R2qhb2SelGAmLyCyClwjW6Co5RVelDH 1277752052
Received: from localhost.localdomain (p54859FEF.dip0.t-ipconnect.de [84.133.159.239])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 67B824EDF1E;
	Mon, 28 Jun 2010 15:07:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTil6-rd5y9xcTVz4kJ4O2jL9ZdXYo1JrgYA3sM6N@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149853>

Erez Zilber venit, vidit, dixit 28.06.2010 18:02:
> Hi,
> 
> I saw that I can run git log with '--cherry-pick'. With this, if I run
> "git log --cherry-pick branch_a..branch_b", it doesn't show
> differences that are caused by cherry picks.
> 
> My question is: sometimes, cherry picking from branch_a to branch_b is
> not immediate, and I need to adapt the patch that was committed on
> branch_a to apply on branch_b. In other cases, git is able to apply
> the patch on branch_b automatically (e.g. if there's only a line
> offset). In such cases, will "git log --cherry-pick" ignore these
> cherry-picks like it ignores cherry-picks that were applied without
> any problem?

With --cherry-pick, log omits those commits whose associated patch has
the same patch-id (see "git patch-id").

Michael
