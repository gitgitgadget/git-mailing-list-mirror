From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] make commit --interactive lock index
Date: Thu, 29 May 2008 20:56:17 +0200
Message-ID: <20080529185617.GC5596@steel.home>
References: <E1K1eXH-00063c-Bt@fencepost.gnu.org> <alpine.DEB.1.00.0805291343120.13507@racer.site.net> <483EABD8.3050600@gnu.org> <alpine.DEB.1.00.0805291454270.13507@racer.site.net> <483EC079.1050008@gnu.org> <20080529175157.GB5596@steel.home> <483EEF57.6060304@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 29 20:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1nJH-0003Gg-TY
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 20:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYE2S4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 14:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753207AbYE2S4T
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 14:56:19 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:19533 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbYE2S4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 14:56:19 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyO1Gg==
Received: from tigra.home (Faca8.f.strato-dslnet.de [195.4.172.168])
	by post.webmailer.de (fruni mo8) (RZmta 16.38)
	with ESMTP id f02002k4TGoQfn ; Thu, 29 May 2008 20:56:17 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3C0F2277BD;
	Thu, 29 May 2008 20:56:17 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1F73156D28; Thu, 29 May 2008 20:56:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <483EEF57.6060304@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83236>

Paolo Bonzini, Thu, May 29, 2008 20:00:55 +0200:
>
>>> The "if() die ()" thingie is already in builtin-commit.c, so we won't 
>>>  ever get a pathspec in the "add --interactive" case.  If we do,   
>>> something else has already been done incorrectly before -- not by the 
>>>  user but by the programmer.
>>
>> What could that be?
>
> Nothing, but it documents to whoever reads the code what is the path  
> that will be taken.  Anyway if it happened it would be very bad.

Why is a comment not enough?
