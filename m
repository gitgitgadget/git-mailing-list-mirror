From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-pull.sh: Fix call to git-merge for new command  
   format
Date: Wed, 02 Dec 2009 18:29:52 +0100
Message-ID: <4B16A410.5090802@drmicha.warpmail.net>
References: <1259707451-20661-1-git-send-email-vonbrand@inf.utfsm.cl> <7vmy22qmgp.fsf@alter.siamese.dyndns.org> <4B163B49.4070606@drmicha.warpmail.net> <7vws15jpe7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:34:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFt2n-000270-5W
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbZLBRa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754897AbZLBRa7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:30:59 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38811 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754881AbZLBRa7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 12:30:59 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6D464C578E;
	Wed,  2 Dec 2009 12:31:05 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 02 Dec 2009 12:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kV6x2fR5XKormhBC+Wd4Sdx22Io=; b=qfZmrVjZaBT2LcIiDk4tDcDrMosiY12s44DG+EIjw8PSjb1S7XwWayESQVzPB98VDKjGg78BB7vMG459zzph7n7WPC4LRoP/yd/OEt5kpguzfEmZQZRqY21TtXRytrWJI8MTCBjTcjK0K8sNBdy0r/WSygE6LSSmsQGP4ck7H7Q=
X-Sasl-enc: 1Ltm+VBDUPkViq0snDidQwk0q0vA/J7Q8juwIpmn1CMp 1259775064
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 552024A0018;
	Wed,  2 Dec 2009 12:31:03 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <7vws15jpe7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134358>

Junio C Hamano venit, vidit, dixit 02.12.2009 17:45:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> This made me wonder a bit: Do we have a policy regarding the use of
>> "git-command" vs. "git command" in git shell scripts such as this one?
> 
> Yes.  Anything that sets GIT_EXEC_PATH correctly can use git-foo form.

I know they can. That was in the part you snipped ;)

The questions is: Should they? Should we avoid mixing both forms in one
script?

Michael
