From: Stephen Bash <bash@genarts.com>
Subject: Re: Git EOL Normalization
Date: Thu, 26 May 2011 12:28:48 -0400 (EDT)
Message-ID: <22629514.41388.1306427328539.JavaMail.root@mail.hq.genarts.com>
References: <7v1uzlzbra.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:29:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPdQo-00023I-Aq
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 18:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757582Ab1EZQ24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 12:28:56 -0400
Received: from hq.genarts.com ([173.9.65.1]:19341 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754891Ab1EZQ2z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 12:28:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C3946EA2359;
	Thu, 26 May 2011 12:28:54 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GcIRtx83lRtT; Thu, 26 May 2011 12:28:48 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 9561AEA233B;
	Thu, 26 May 2011 12:28:48 -0400 (EDT)
In-Reply-To: <7v1uzlzbra.fsf@alter.siamese.dyndns.org>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174543>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> To: "Jakub Narebski" <jnareb@gmail.com>
> Sent: Thursday, May 26, 2011 12:07:21 PM
> Subject: Re: Git EOL Normalization
> 
> > I think git examines only first block of a file or so. The heuristic
> > to detect binary-ness of a file is, as I have heard, the same or
> > similar to the one that GNU diff uses.
> 
> Yes, the binary detection was designed to be compatible with GNU diff. But
> I do not think it has much to do with the topic of this thread. Aren't
> other people discussing the line ending?

The binary detection may be apropos because there are situations (core.autocrlf={true,input} and text=auto) where Git will only do line ending conversion if it detects a text file...  But I'll leave it to people who know the code better to say if this binary detection is in fact part of the decision process.

Thanks,
Stephen
