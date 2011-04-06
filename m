From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] git-svn: --no-metadata related bug
Date: Wed, 06 Apr 2011 15:04:43 +0200
Message-ID: <4D9C64EB.5060703@drmicha.warpmail.net>
References: <20110405190722.GB25644@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 15:08:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7STA-0001je-2F
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 15:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab1DFNIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 09:08:18 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34418 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754743Ab1DFNIR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 09:08:17 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5D72B209AD;
	Wed,  6 Apr 2011 09:08:17 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 06 Apr 2011 09:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=u6DlxcLay5W1o05ilHCUleOtH/Y=; b=T3zMm6Lzs2YrgXy19XpxWvmi2O0Q1f6okQrdkAU3IER0pk2+d2yK7Q1anbAQFnFgPMr4m+G6R928qUM8ZyzRk+Oa3514KkgxlqdDtUvyvdf0feq6ap/65jOq1YiFjx1rvo4+uq3xZhUWx8GOi48dEnpSRnrgXsNJglI8eA50398=
X-Sasl-enc: ALApFefkB9qqTibWNsdlk3VrwTVLPwHBmm2ki1hDeXi5 1302095297
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D56964471D1;
	Wed,  6 Apr 2011 09:08:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110405190722.GB25644@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170974>

Ramkumar Ramachandra venit, vidit, dixit 05.04.2011 21:07:
> git svn clone --no-metadata -T trunk http://dxirc.googlecode.com/svn/

Works fine for me, using:

git svn --version
git-svn version 1.7.5.rc0.365.g23929a (svn 1.6.16)

What are the affected versions?

Michael
