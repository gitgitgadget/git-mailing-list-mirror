From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 03 Dec 2009 13:15:31 +0100
Message-ID: <4B17ABE3.6060003@drmicha.warpmail.net>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org> <m2hbs85koj.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Dec 03 13:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGAc6-00012O-FY
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 13:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbZLCMQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 07:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbZLCMQi
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 07:16:38 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34285 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751933AbZLCMQi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 07:16:38 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B70A7C1F74;
	Thu,  3 Dec 2009 07:16:44 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 03 Dec 2009 07:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kr2UTggkK3xCc17zE6Hr7FguNyc=; b=BciGkw6fteKoEjNmo64fZjZ05w0gkIrtEkKFte6fJTWPBcoYN2J1sONqVWrfNXRw9zbtGbJTHIxFYaSlPLJD/hJRwVUBkfKgtKFsk4CYEuwgXOcmEu40bFw9vNsBrzMuabg+Ns+YoJ5LFnCxfptmUDQgm/uKs8U0xKGbODG1YlI=
X-Sasl-enc: Qj/7U39YwMMLr02gvYxqIxuWbIjDL4NgnIRTvwixgWwr 1259842604
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 193FC4A3D96;
	Thu,  3 Dec 2009 07:16:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <m2hbs85koj.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134451>

Andreas Schwab venit, vidit, dixit 03.12.2009 13:03:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>       Unconditionally set man.base.url.for.relative.links
> 
> rm -f git-add.1 && \
>         xmlto -m manpage-normal.xsl  --stringparam man.base.url.for.relative.links= man git-add.xml
> xmlto: unrecognized option '--stringparam'
> make[1]: *** [git-add.1] Error 1
> 
> Andreas.
> 

and

uname -a
xmlto --version

says?

Michael
