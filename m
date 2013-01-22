From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH v3 1/6] Change old system name 'GIT' to 'Git'
Date: Tue, 22 Jan 2013 10:44:26 +0100 (CET)
Message-ID: <1543684041.1817103.1358847866882.JavaMail.ngmail@webmail19.arcor-online.net>
References: <7vfw1udpav.fsf@alter.siamese.dyndns.org> <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1335904329.632749.1358795780375.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com, git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Tue Jan 22 10:44:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxaPU-0008EZ-2c
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 10:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308Ab3AVJo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 04:44:29 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:37717 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752181Ab3AVJo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2013 04:44:28 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id F04F3D839F;
	Tue, 22 Jan 2013 10:44:26 +0100 (CET)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id E420F1F6007;
	Tue, 22 Jan 2013 10:44:26 +0100 (CET)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id DFE422D680E;
	Tue, 22 Jan 2013 10:44:26 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-10.arcor-online.net DFE422D680E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358847866; bh=TXuPJlCZDCMjqJySvj2FHb/68lrXrC6PFooB6JvALpM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=QgeTYbh9UCOlnkHySnykk9DFwVT7RZJfF0ujJo3TNLbjpw2XcoOrexo+7l5ktJSja
	 lz5nKAi7xFc1dDn7+RQIF91JZkd93QxPoI+kAQW5oHzzOCbr6zxmT3ZDdUjp9NGgtb
	 nWtanzFVo6TRNg47sJm3HplD0pMsPDYN+2ZKbN/8=
Received: from [194.138.39.60] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 22 Jan 2013 10:44:26 +0100 (CET)
In-Reply-To: <7vfw1udpav.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 194.138.39.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214226>

> 
> I think it misses "GIT - the stupid content tracker" in README, but
> probably it is OK (it is not an end-user facing documentation).
> 
I only checked ./Documentation; but this should be changed also.

> I noticed that these two places still use poor-man's small caps
> after this patch.
> 
Thanks.

>  * Documentation/SubmittingPatches:
>  that are being emailed around. Although core GIT is a lot
>
I will change this.
 
>  * Documentation/git-credential.txt:
>  TYPICAL USE OF GIT CREDENTIAL
>
This is to be debated because here all caps is used as "poor man's bold face"
and it would look odd if we write 'TYPICAL USE OF Git CREDENTIAL'?
 
> 
> Not commenting on other 5 patches in the series yet, but if they
> interact with other topics in flight, they may have to be separated
> out. We'll see.
> 
Perhaps it would be best to separate this into 2 series:
[1/6]+[6/6] and [2/6]-[5/6]?



---
Thomas
