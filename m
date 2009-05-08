From: Dave O <cxreg@pobox.com>
Subject: Re: Segfault during merge
Date: Thu, 7 May 2009 21:37:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 08 06:37:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Hq2-0002Ln-G1
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 06:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbZEHEhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 00:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZEHEhY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 00:37:24 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:49115 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293AbZEHEhY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 00:37:24 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id n484bI68027991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 May 2009 23:37:21 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118561>

On Thu, 7 May 2009, Johannes Schindelin wrote:

>> Hi, I've encountered a particular merge that causes a segfault, and was
>> able to successfully bisect git to commit 36e3b5e.
>
> As you already found the commit, you could have Cc:ed me already.  It is
> pure luck that I did not miss your bug report.

Sorry, didn't think to do so.

After some thought, I was able to come up with a simple script that
reproduces this crash.  I'm not sure what the policy on this list is for
attachments, so I've put it at this URL:

http://www.genericorp.net/~count/git-merge-crash

It requires bash and the perl /usr/bin/rename command for simplicity's
sake.  At the top of the script is a diagram of what it does.

Hopefully this helps you identify what's happening here.  Let me know if
I can help further.

     Dave
