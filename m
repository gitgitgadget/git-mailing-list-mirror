From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-repack: generational repacking (and example hook
 script)
Date: Tue, 03 Jul 2007 16:58:37 +1200
Message-ID: <4689D77D.20601@vilain.net>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz> <11831937813223-git-send-email-sam.vilain@catalyst.net.nz> <11831937822346-git-send-email-sam.vilain@catalyst.net.nz> <11831937823184-git-send-email-sam.vilain@catalyst.net.nz> <11831937823982-git-send-email-sam.vilain@catalyst.net.nz> <1183193782172-git-send-email-sam.vilain@catalyst.net.nz> <11831937822249-git-send-email-sam.vilain@catalyst.net.nz> <11831937823756-git-send-email-sam.vilain@catalyst.net.nz> <11831937822950-git-send-email-sam.vilain@catalyst.net.nz> <11831937823588-git-send-email-sam.vilain@catalyst.net.nz> <1183193782608-git-send-email-sam.vilain@catalyst.net.nz> <alpine.LFD.0.999.0707022331080.26459@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:58:53 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5aTS-00036l-6d
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 06:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbXGCE6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 00:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbXGCE6r
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 00:58:47 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:59471 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbXGCE6q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 00:58:46 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id B3FAA13A4EA; Tue,  3 Jul 2007 16:58:44 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 67B6A13A3E1;
	Tue,  3 Jul 2007 16:58:40 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <alpine.LFD.0.999.0707022331080.26459@xanadu.home>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51455>

Nicolas Pitre wrote:
>> Add an option to git-repack that makes the repack run suitable for
>> running very often.  The idea is that packs get given a "generation",
>> and that the number of packs in each generation (except the last one)
>> is bounded.
> 
> Please explain again why this should be useful and is worth the 
> complexity it brings along.  Last time this was discussed I wasn't 
> convinced at all, and I'm still not convinced this time either.

First I think we should establish some common ground.

1. Do you agree that some users would want their git repositories to be
"maintenance free"?

2. Do you agree that having thousands of packs would add measurable
overhead?

Sam.
