From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] git-gui: display summary when showing diff of a submodule
Date: Tue, 07 Jul 2009 15:01:28 +0200
Message-ID: <4A534728.3050005@drmicha.warpmail.net>
References: <4A526D15.3090202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 15:01:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOAJ1-0003V1-7h
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 15:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbZGGNBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 09:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755203AbZGGNBo
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 09:01:44 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:45286 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754964AbZGGNBn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 09:01:43 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 0873B3AF68C;
	Tue,  7 Jul 2009 09:01:47 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 07 Jul 2009 09:01:50 -0400
X-Sasl-enc: daAzXvir0MzPPPtEQQxQdm6bhibygo3Aba29D72CXD7P 1246971706
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 418A63B99;
	Tue,  7 Jul 2009 09:01:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A526D15.3090202@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jens Lehmann venit, vidit, dixit 06.07.2009 23:31:
> As it is hard to say what changed in a submodule by looking at the hashes,
> let's show the colored submodule summary instead.
> 

I can't comment on the patch but I find the goal very valid. I just
updated the submodule tutorial wiki to use "git submodule summary" in
addition to plain diff.

Me wonders whether the summary should be the default diff output, or at
least a builtin merge driver which can be selected using attributes or such.

Michael
