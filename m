From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Thu, 07 Jun 2007 10:53:41 +1200
Message-ID: <46673AF5.1070901@vilain.net>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz> <7vlkewya4s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:53:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw4O4-0002r9-Pm
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935059AbXFFWxt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934903AbXFFWxt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:53:49 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53881 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935059AbXFFWxs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:53:48 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 7794513A4F6; Thu,  7 Jun 2007 10:53:46 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id E3B2513A4EA;
	Thu,  7 Jun 2007 10:53:41 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <7vlkewya4s.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49332>

Junio C Hamano wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> writes:
>   
>> +			c_gen=`eval "echo \\\$c_gen_$i"`
>> +			packs=`eval "echo \\\$gen_$i"`
>>     
>
> I used to write something like these myself when I was young
> ;-), but it is enough to write:
>
> 	eval 'c_gen=$c_gen_'$i
> 	eval "packs=\$gen_$i"
>   

Would've re-written it in Perl ages ago :P

Sam.
