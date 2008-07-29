From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Tue, 29 Jul 2008 21:11:05 +0200
Message-ID: <164D011C-D862-43F6-8DAC-1309AC0E91F4@orakel.ntnu.no>
References: <7vej5kfs0w.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807231817460.8986@racer> <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <alpine.DEB.1.00.0807260407170.11976@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNucE-0001iQ-2S
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbYG2TLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbYG2TLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:11:09 -0400
Received: from eyvind.bernhardsens.net ([84.49.228.97]:55350 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYG2TLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:11:08 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.221])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 158C81B3137;
	Tue, 29 Jul 2008 21:11:06 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0807260407170.11976@eeepc-johanness>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90669>


On 26. juli. 2008, at 04.09, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 25 Jul 2008, Eyvind Bernhardsen wrote:
>
>> That is an excellent argument for why setting "autocrlf=true" by  
>> default
>> on Windows was a bad idea.  Thanks! :)
>
> Well, these days, I tend to give a flying nothing to opinions that  
> are not
> backed up by any effort toward the project.

Yeah, sorry, I'll stop complaining about this until I have actual code  
to back me up.
-- 
Eyvind Bernhardsen
