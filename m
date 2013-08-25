From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH 03/13] Use current output for "git repack"
Date: Sun, 25 Aug 2013 10:37:48 +0200 (CEST)
Message-ID: <2117090477.480920.1377419868272.JavaMail.ngmail@webmail16.arcor-online.net>
References: <20130825041553.GC2882@elie.Belkin> <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
 <1172777180.1090921.1377329200690.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, wking@tremily.us
To: jrnieder@gmail.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sun Aug 25 10:38:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDVpi-0007Mu-5N
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 10:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141Ab3HYIhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 04:37:51 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:48409 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756109Ab3HYIhu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Aug 2013 04:37:50 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id 4C8CCE3BCC;
	Sun, 25 Aug 2013 10:37:48 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id 437863F83D1;
	Sun, 25 Aug 2013 10:37:48 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 3F1731975E1;
	Sun, 25 Aug 2013 10:37:48 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-09.arcor-online.net 3F1731975E1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377419868; bh=91fagm0pwAB0T2dCOK78moRoekxZzsiSoXzyatR4BZI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=sHn1g9g/XgOtbRpzNf87HgB6olRvAeE/viSrtGKHnvqO9vkLoAG+Ddx1q+FwZSutV
	 ZzmxEk7gFD1PtsIHZKTXi2ujbF94AdFpdQemCso2MeYaW5djKX42vzkmZRu77Qh0XX
	 vAi1Fd3neujUPG9NvJg97YMJXbeRbiLanj0M42PU=
Received: from [178.7.23.208] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Sun, 25 Aug 2013 10:37:48 +0200 (CEST)
In-Reply-To: <20130825041553.GC2882@elie.Belkin>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.23.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232937>

 
> 
> Sure.  I wonder if there should be some text to replace the output
> that mentions the pack being created, though.  E.g.:
> 
> >  ------------------------------------------------
> >  
> >  You can then run
> 
> 	Total 6020 (delta 4070), reused 0 (delta 0)
> 	------------------------------------------------
> 
> 	This creates a single "pack file" in .git/objects/pack/ containing
> 	all currently unpacked objects.  You can then run
> 

OK; thanks! I will add this.

---
Thomas
