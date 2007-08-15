From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: git-cvsexportcommit getting out of sync with CVS status requests
Date: Wed, 15 Aug 2007 18:34:56 +0200
Message-ID: <46C32B30.8040504@fs.ei.tum.de>
References: <1187178510.13096.46.camel@murta.transitives.com> <1187182726.13096.50.camel@murta.transitives.com> <46C3218E.6020309@fs.ei.tum.de> <Pine.LNX.4.64.0708151810000.19496@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alex.bennee@transitive.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:35:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILLpq-00057M-0o
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 18:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933357AbXHOQe7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 12:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933325AbXHOQe7
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 12:34:59 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:43847 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933056AbXHOQe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 12:34:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id C2933280E9;
	Wed, 15 Aug 2007 18:34:56 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6sUInfvq3LhT; Wed, 15 Aug 2007 18:34:56 +0200 (CEST)
Received: from [128.178.149.21] (nslpc6.epfl.ch [128.178.149.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 7A633280D5;
	Wed, 15 Aug 2007 18:34:56 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <Pine.LNX.4.64.0708151810000.19496@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55921>

Johannes Schindelin wrote:
>> Alex Bennee wrote:
>>> It looks like running a single CVS query for each file is the only
>>> solution.
>> I think internally CVS is doing single queries anyways.  At least that 
>> was my impression.
> Why then was cvsexportcommit so much slower without 
> c56f0d9c661dc918a088e60d0ab69dd48019a9be?

Ah, my bad.  Didn't use such a recent cvsexportcommit.  So we need to mimic the cvs sorting.

cheers
  simon
