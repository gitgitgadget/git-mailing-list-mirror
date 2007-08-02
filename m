From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 02 Aug 2007 21:29:34 +0200
Message-ID: <46B2309E.3060804@fs.ei.tum.de>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B215E2.8010307@fs.ei.tum.de> <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	users@cvs2svn.tigris.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 21:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGgMe-000678-6d
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 21:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbXHBT3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 15:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbXHBT3h
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 15:29:37 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:48702 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbXHBT3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 15:29:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id D6294280EA;
	Thu,  2 Aug 2007 21:29:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UyMqdhHJWDiq; Thu,  2 Aug 2007 21:29:34 +0200 (CEST)
Received: from [128.178.149.21] (nslpc6.epfl.ch [128.178.149.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 88BEE280E3;
	Thu,  2 Aug 2007 21:29:34 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54589>

Steffen Prohaska wrote:
> I remember that togit reported a broken pipe. My feeling was
> that git-fastimport aborted, which may be reason why tohg
> worked better. I didn't try to understand more details. I never
> read ruby code before and it was already a challenge for me to
> get everything up and running (rcs, rbtree).

yah, that pretty much tells me it is shawn's bug :)  but without more details, it is very hard to diagnose.  tohg should tell you which rcs revs are the offenders.  be sure to use a recent fromcvs however.

cheers
  simon
