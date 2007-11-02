From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is	strict subset of remote ref
Date: Fri, 2 Nov 2007 15:49:37 +0100
Message-ID: <8C8648EB-8434-46FC-A6F6-9DE146ACB373@zib.de>
References: <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@zib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <!47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de> <472AF5F8.40208@op5.se> <20071102132446.GA31758@hermes.priv> <472B2B8F.1060203@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tom Prince <tom.prince@ualberta.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InxsG-0007uQ-S7
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 15:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbXKBOvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 10:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbXKBOvf
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 10:51:35 -0400
Received: from mailer.zib.de ([130.73.108.11]:43521 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688AbXKBOve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 10:51:34 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA2EmGsS006771;
	Fri, 2 Nov 2007 15:49:40 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA2EmFw0023616
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 2 Nov 2007 15:48:15 +0100 (MET)
In-Reply-To: <472B2B8F.1060203@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63122>


On Nov 2, 2007, at 2:52 PM, Andreas Ericsson wrote:

>> I haven't had occasion to use git-bisect much, but I was under the
>> impression that bisect could already handle merges, or any other  
>> shaped
>> history just fine.
>
> It appears the code supports your statement. I started writing on my
> hack-around about a year ago, and the merge-handling code got in with
> 1c4fea3a40e836dcee2f16091bf7bfba96c924d0 at Wed Mar 21 22:16:24 2007.
> Perhaps I shouldn't be so paranoid about useless merges anymore then.
> Hmm. I shall have to look into it. Perhaps Junio can clarify how it
> works? The man-page was terribly silent about how git-bisect handles
> merges.

So eventually there's coming something good out of this thread,
without actually writing any code ;)

	Steffen
