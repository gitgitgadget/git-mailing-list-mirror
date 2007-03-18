From: Sam Vilain <sam@vilain.net>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 09:51:03 +1200
Message-ID: <45FDB447.5070507@vilain.net>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <7vr6rml4fb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3HU-0005PG-2R
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 22:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306AbXCRVvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933310AbXCRVvJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 17:51:09 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:46471 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933306AbXCRVvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 17:51:08 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id ED1F613A384; Mon, 19 Mar 2007 09:51:06 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 7922213A302;
	Mon, 19 Mar 2007 09:51:03 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <7vr6rml4fb.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42528>

Junio C Hamano wrote:
>> I don't understand the design choice here: git had two options to
>> avoid this scenario:
>>     
>
> Actually, there are no such "design choices".  That's entirely
> up to the repository owners to arrange post-update hook, to
> allow you to do anything you want.  
>
> The default is not to encourage people (who do not know what
> they are doing anyway) to push into non-bare repository.
>   

Maybe it's worth making it an error (that can be forced) if you're
pushing to the head that's checked out in a non-bare repository ?

It's pretty nasty behaviour for people used to darcs / bzr et al.

Sam.
