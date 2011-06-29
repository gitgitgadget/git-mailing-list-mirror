From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: Front GIT with an ssh or http service
Date: Wed, 29 Jun 2011 19:39:45 +0200
Message-ID: <1309369185.2417.62.camel@oxylap>
References: <1309348950907-6528631.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eugene <eugene@oggtrading.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 19:39:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbyjy-0001Ck-Cp
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 19:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351Ab1F2Rju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 13:39:50 -0400
Received: from vserver.localhost.li ([85.214.46.152]:49553 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab1F2Rjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 13:39:49 -0400
Received: from p5794c8fc.dip.t-dialin.net ([87.148.200.252]:40918 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1Qbyjq-0001Oj-Pm; Wed, 29 Jun 2011 19:39:47 +0200
In-Reply-To: <1309348950907-6528631.post@n2.nabble.com>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176452>

On Mi, 2011-06-29 at 05:02 -0700, Eugene wrote:
> Good morning,
>   I have a local Git for windows. I want to put an ssh or web service in
> front so somebody else can use me and also set up automatic builds (via
> cruisecontrol) out of my local git.
Setting up a ssh or http server under Windows is not directly a git
question, so don't be too disappointed if you won't receive step-by-step
instructions on this list. A quick google search brought up
http://www.timdavis.com.au/git/setting-up-a-msysgit-server-with-copssh-on-windows/
This looks like a lot of text too me, so in case your repository can be
made available public, you should consider using a service like
github.com or similar. Or maybe you know someone with a linux box who
could help you out.  You could then set up the remove repository with
remote.*.mirror=true if you want to easily mirror all your branches with
just one command.

Regards,
  Chris
