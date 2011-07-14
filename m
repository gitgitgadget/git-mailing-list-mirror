From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: How to provide authentication along with git command itself ?
Date: Thu, 14 Jul 2011 12:50:46 +0200
Message-ID: <1310640646.18730.10.camel@bee.lab.cmartin.tk>
References: <20110714161508.2378c155@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 14 12:50:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhJVR-0000Z7-7o
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 12:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab1GNKuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 06:50:52 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:60414 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab1GNKuw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 06:50:52 -0400
Received: from [192.168.1.22] (brln-d9ba36b2.pool.mediaWays.net [217.186.54.178])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 56317461FA;
	Thu, 14 Jul 2011 12:50:11 +0200 (CEST)
In-Reply-To: <20110714161508.2378c155@shiva.selfip.org>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177111>

On Thu, 2011-07-14 at 16:15 +0530, J. Bakshi wrote:
> Hello list,
> 
> During git push or fetch over http , I need to provide username and
> password every time, as protected by apache htpasswd file. How can I
> provide the same along with git command ? Or something so that It save
> the authentication info somewhere within .git 

The http transport uses the ~/.netrc file to get its authentication
data.  `man netrc` will tell you about the syntax; for git, you need the
'machine', 'login' and 'password' fields.

Cheers,
   cmn
