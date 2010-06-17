From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git pull (Your local changes to ... would be overwritten by 
 merge)
Date: Thu, 17 Jun 2010 13:58:05 +0200
Message-ID: <4C1A0DCD.2070906@drmicha.warpmail.net>
References: <AANLkTinokUxiDdetcrsrlSExQ7hmhLS5szbTt9KzGKr_@mail.gmail.com> 	<AANLkTimeIWseETfYiMajIqesjJ_p55pRislnQQIaCrbG@mail.gmail.com> 	<4C19FBF8.6010709@drmicha.warpmail.net> <vpq4oh1zzfs.fsf@bauges.imag.fr> <AANLkTinWS0zWhh0d-yrb7eWMEeQenoAF8tA6-l9BRP_q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Daniel Blendea <bdaniel7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 13:59:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPDkU-00048S-HM
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 13:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431Ab0FQL7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 07:59:04 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33321 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752164Ab0FQL7D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 07:59:03 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9AE65F8C94;
	Thu, 17 Jun 2010 07:58:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 17 Jun 2010 07:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=bHTh7UJXNdnij9F2s+yPwKamBtk=; b=ElBET+9E6h0Z1cSO9PPshbc/W03pivZDsjNj0SazU+bqVCs3INmljbny/RqrzQFrV1Yhjgl8OZKqaRiQ0OGW8dSp2nXM1jt0sUcHAct3kdDUY74PdhqInMQ9iupeQlOObZjv1fAYjXc6tCw2nTIDwtpL9k2Muz+X292xLZ3Vlqk=
X-Sasl-enc: skUN5Xp+x+N1uBgFFkv3dXvSUMT9TPAEL+6y0PgNAwLr 1276775920
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E12E8A89F;
	Thu, 17 Jun 2010 07:58:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTinWS0zWhh0d-yrb7eWMEeQenoAF8tA6-l9BRP_q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149301>

Daniel Blendea venit, vidit, dixit 17.06.2010 13:18:
> Windows 7, did not change anything related to crlf.
> 
> I solved the problem with
> 
> git fetch --all
> git reset --hard origin/master

I guess this shows that correct diagnostics is not a prerequisite for a
successful therapy ;)

(The diagnostics really indicate a work tree with local uncommitted
modifications.)

Michael
