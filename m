From: Peter <vmail@mycircuit.org>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Wed, 25 Mar 2009 11:52:15 +0100
Message-ID: <49CA0CDF.7060203@mycircuit.org>
References: <49C9246E.3030508@mycircuit.org> <alpine.LFD.2.00.0903241226570.3032@localhost.localdomain> <49C94B02.5010604@mycircuit.org> <alpine.LFD.2.00.0903241510010.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 11:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmQkE-0005SS-Vl
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 11:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756889AbZCYKw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 06:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbZCYKw1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 06:52:27 -0400
Received: from mailfe02.tele2.ch ([212.247.154.40]:50225 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756227AbZCYKw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 06:52:26 -0400
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=rOj5MoUHdesA:10 a=zs1h1pAyPHAA:10 a=Qy6mu5jw0WABpOr/wumM4A==:17 a=o30em-Qy1RgtSPJGeIMA:9 a=HD890zjZ-Z4dBavPh0_axERKX2oA:4 a=M3PvEdNFSBYA:10
Received: from mail.mycircuit.org (account cxu-8g8-ypb@tele2.ch [83.180.79.156] verified)
  by mailfe02.swip.net (CommuniGate Pro SMTP 5.2.6)
  with ESMTPA id 1218467881; Wed, 25 Mar 2009 11:52:22 +0100
Received: from [192.168.1.192] (unknown [192.168.1.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "p_email", Issuer "192.168.2.2" (verified OK))
	by mail.mycircuit.org (Postfix) with ESMTP id 03BD8D0360;
	Wed, 25 Mar 2009 11:52:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <alpine.LFD.2.00.0903241510010.3032@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114582>


>
> Here's an idea: if this is reproducible for you, does the behavior change 
> if you do
>
> 	[core]
> 		core.fsyncobjectfiles = true
>
>   
Yes, that works !
Thanks a lot !

Peter
