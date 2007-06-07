From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Fri, 08 Jun 2007 09:36:51 +1200
Message-ID: <46687A73.6080100@vilain.net>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>	 <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>	 <46676D44.7070703@vilain.net>	 <alpine.LFD.0.99.0706062314410.12885@xanadu.home> <46a038f90706071246y7dd14f55t199b8ed4e7617b68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Dana How <danahow@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 23:37:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwPfH-0002p8-P4
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 23:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764044AbXFGVhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 17:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbXFGVhG
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 17:37:06 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43135 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454AbXFGVhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 17:37:04 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 001F41574BD; Fri,  8 Jun 2007 09:37:01 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id CDCFB1574BB;
	Fri,  8 Jun 2007 09:36:56 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <46a038f90706071246y7dd14f55t199b8ed4e7617b68@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49390>

Martin Langhoff wrote:
> On 6/7/07, Nicolas Pitre <nico@cam.org> wrote:
>> Run git-repack without -a from some hook.  You can even launch it in the
>> background.
> 
> I posted an RFC patch a while ago doing exactly that, and Linus shot
> it down, indicating we should instead print a message suggesting
> repack to the user.
> 
> Relevant thread around
> http://www.gelato.unsw.edu.au/archives/git/0606/22977.html
> 
>> Or what am I missing?
> 
> I don't think people were comfortable at the time with concurrent
> repacks -- though the semantics are safe if we don't hit any bug. My
> guess is that noone wants to risk the .001% chances of data corruption
> for this nice-to-have.

Ok.  But if repack is generational you probably don't mind waiting for
it on commit so don't need to background it.

Sam.
