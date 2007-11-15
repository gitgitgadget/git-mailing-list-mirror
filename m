From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN
 cc.
Date: Thu, 15 Nov 2007 23:00:44 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711152253430.4090@bianca.dialin.t-online.de>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
 <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-945524817-1195164044=:4090"
Cc: gitster@pobox.com, raa.lkml@gmail.com, git@ostkamp.fastmail.fm,
	git@vger.kernel.org
To: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:01:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ismln-0007pL-En
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759440AbXKOWAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 17:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759439AbXKOWAt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:00:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37034 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758873AbXKOWAs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 17:00:48 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 8496D48B83;
	Thu, 15 Nov 2007 17:00:47 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 15 Nov 2007 17:00:47 -0500
X-Sasl-enc: YQVKw48m9VbjGomTA99dC8aspkXbSfXAga2CJdyA+SjB 1195164046
Received: from [192.168.2.101] (p549A10B1.dip0.t-ipconnect.de [84.154.16.177])
	by mail.messagingengine.com (Postfix) with ESMTP id 289E42A571;
	Thu, 15 Nov 2007 17:00:46 -0500 (EST)
In-Reply-To: <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65168>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-945524817-1195164044=:4090
Content-Type: TEXT/PLAIN; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 15 Nov 2007, Björn Steinbrink wrote:
> Some versions of SUN's cc have a bug that causes them to complain about
> a redeclared identifier when you use a function declaration that takes a
> struct with a FAM and this struct has only been declared but not yet
> defined.
> [...]
> Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
> ---
> Guido, could you please test this patch?

I tested it and the file in question compiled ok for the two versions of 
Sun Forte and Workshop compilers that I have available.

I could also link & run the main git binary after applying my own 
mkdtemp() patch.

I hope your patch will get officially included.

Regards

Guido
--8323584-945524817-1195164044=:4090--
