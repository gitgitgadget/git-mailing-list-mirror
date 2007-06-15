From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation/gitmodules: fix asciidoc
Date: Fri, 15 Jun 2007 15:53:40 +1200
Message-ID: <46720D44.2040409@vilain.net>
References: <11818789512948-git-send-email-sam.vilain@catalyst.net.nz> <20070615034915.GE18491@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 05:53:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz2sl-0008Rc-1O
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 05:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbXFODxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 23:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbXFODxu
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 23:53:50 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:58487 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbXFODxt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 23:53:49 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id CFA2B13A4F8; Fri, 15 Jun 2007 15:53:47 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 5D79813A4F0;
	Fri, 15 Jun 2007 15:53:43 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <20070615034915.GE18491@spearce.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50239>

Shawn O. Pearce wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
>   
>> ---
>>   I was getting documentation build errors without this
>>     
>
> Yea, I got doc build errors today too from `next` but did not have
> time to track down what was causing them.  Something about the XML
> not matching the DocBook DTD.

Yep, the synopsis section did not have enough in it to satisfy the
requirements of asciidoc, so it generated an empty <refsynopsisinfo>
section which doesn't match the DocBook 4.2 DTD.

Perhaps there is another solution by fixing the asciidoc.conf... but
looks like voodoo to me :)

Sam.
