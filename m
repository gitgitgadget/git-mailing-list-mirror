From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn mirror in bare repo
Date: Mon, 23 Aug 2010 14:58:51 +0200
Message-ID: <4C72708B.202@drmicha.warpmail.net>
References: <20100823122425.GB12810@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: weigelt@metux.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 14:59:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnWc8-0000D0-MZ
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 14:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0HWM6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 08:58:54 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57488 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751805Ab0HWM6x (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 08:58:53 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B14802B2;
	Mon, 23 Aug 2010 08:58:52 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 23 Aug 2010 08:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lZgQOXrU5nUCiYkjvwxH5fCtAp0=; b=Nl2RQHQgYhQ9BjH1B+3EYoVBxxafcT2Mfm+edMSeEjT12+YyxXLKgdYqRXANFoZ8r1tZadf+GzhQWdpEHphrg6ZwZNucB+d+/KJtStjXlpa5S46H/AZHA8dWO36ayHzOj+i8BlARcfyyNifPPYoHRzeYoxcXI/Razs2urt98AOU=
X-Sasl-enc: PqV/eReNO+BHe/5zXpA3cqiDNDT+a61Zlfrv53zZ21IZ 1282568332
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 35D5C40A5DD;
	Mon, 23 Aug 2010 08:58:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9pre) Gecko/20100806 Lightning/1.0b2pre Lanikai/3.1.2
In-Reply-To: <20100823122425.GB12810@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154224>

Enrico Weigelt venit, vidit, dixit 23.08.2010 14:24:
> 
> Hi folks,
> 
> is it possible to use git-svn w/ an bare repository (eg. using
> an temporary workdir when necessary or directly creating tree
> and commit objects w/o going through workdir at all) ?

No.

> I'm running a dozen of mirrors (also from cvs), some from fairly
> large and I'd like to get rid of the working copies.

Your only option is a different conversion tool. GSoC resulted in a lot
of code in this direction, but I'm not sure it can do without a workdir.
It is based on svndump

Michael
