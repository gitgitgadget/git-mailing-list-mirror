From: linux@horizon.com
Subject: Re: Test fails on ubuntu breezy
Date: 13 Apr 2006 07:54:47 -0400
Message-ID: <20060413115447.11819.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Thu Apr 13 13:55:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU0Pb-0005ah-CZ
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 13:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWDMLyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 07:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWDMLyy
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 07:54:54 -0400
Received: from science.horizon.com ([192.35.100.1]:50478 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964888AbWDMLyy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 07:54:54 -0400
Received: (qmail 11820 invoked by uid 1000); 13 Apr 2006 07:54:47 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18659>

I've recently encountered the same problem with t/t3600-rm.sh step 9,
but I put it down to compiling as root.

Basically, the chmod of the directory didn't stop the delete from
happening, since I had umask 002 and it was g+w.

Anyway, that test is fragile.
