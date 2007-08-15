From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: git-cvsexportcommit getting out of sync with CVS status	requests
Date: Wed, 15 Aug 2007 17:53:50 +0200
Message-ID: <46C3218E.6020309@fs.ei.tum.de>
References: <1187178510.13096.46.camel@murta.transitives.com> <1187182726.13096.50.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: alex.bennee@transitive.com
X-From: git-owner@vger.kernel.org Wed Aug 15 17:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILLC9-0003is-T0
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 17:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762608AbXHOPxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 11:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762574AbXHOPxz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 11:53:55 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:50488 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762539AbXHOPxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 11:53:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 5AEBD280E9;
	Wed, 15 Aug 2007 17:53:52 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UPLpOXDvb0zO; Wed, 15 Aug 2007 17:53:50 +0200 (CEST)
Received: from [128.178.149.21] (nslpc6.epfl.ch [128.178.149.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id A8DDF280E5;
	Wed, 15 Aug 2007 17:53:50 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <1187182726.13096.50.camel@murta.transitives.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55914>

Alex Bennee wrote:
> It looks like running a single CVS query for each file is the only
> solution.

I think internally CVS is doing single queries anyways.  At least that was my impression.

Or we find out which order cvs is reporting the status.  Maybe a simple sort of the pathnames could be sufficient?

cheers
  simon
