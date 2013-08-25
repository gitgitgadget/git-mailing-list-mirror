From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 09/13] Improve section "Merge multiple trees"
Date: Sun, 25 Aug 2013 14:06:19 +0200 (CEST)
Message-ID: <2127851205.483802.1377432379441.JavaMail.ngmail@webmail16.arcor-online.net>
References: <20130825052327.GK2882@elie.Belkin> <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1473018875.1091101.1377329545934.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: jrnieder@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sun Aug 25 14:06:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDZ5O-00085j-2O
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 14:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab3HYMGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 08:06:21 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:33125 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752678Ab3HYMGU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Aug 2013 08:06:20 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id 6DEAA273C4;
	Sun, 25 Aug 2013 14:06:19 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 6713131A004;
	Sun, 25 Aug 2013 14:06:19 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 622E8107AA9;
	Sun, 25 Aug 2013 14:06:19 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 622E8107AA9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377432379; bh=WGw5Qg+uCsrLvjywkNkG89UmoeWlYcHoO1ACP4zoduo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=f2RP1QYdzNo0MnmQxONpF4Jh/c8g2h+rNWy31QIYaZhom1osAy2Qi4Mxs1mChtBe7
	 oRrKqCBXOM4Onwnp3KG7qJhcG6h9iy1sfp/BKJP8y2MFouePVYZqLRl7eQGiLp+c7B
	 kwBed0OEgdywF6els1gPmmHqfO5Uo6JMIz0713GY=
Received: from [178.7.23.208] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Sun, 25 Aug 2013 14:06:19 +0200 (CEST)
In-Reply-To: <20130825052327.GK2882@elie.Belkin>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.23.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232951>

> 
> Maybe the intent is
> 
> 	Git can help you perform a three-way merge, which can in turn be
> 	used for a many-way merge by repeating the merge procedure several
> 	times.  The usual situation is that you only do one three-way merge
> 	(reconciling two lines of history) and commit the result, but if
> 	you like to, you can merge several branches in one go.
> 
> 	To perform a three-way merge, you start with the two commits you
> 	want to merge, find their closest common parent (a third commit),
> 	and compare the trees corresponding to these three commits.
> 
> 	To get the "base" for the merge, look up the common parent of two
> 	commits:
> 
> 		$ git merge-base <commit1> <commit2>
> 
> 	This prints the name of a commit they are both based on.
> 	...
> 

Thanks! Your text is much better than the original one (and my small changes didn't
even try to improve the text per se). 
If you don't mind I will use your text and add your sign-off for this patch.



---
Thomas
