From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Sep 2013, #08; Wed, 25)
Date: Thu, 26 Sep 2013 08:10:21 +0200
Message-ID: <5243CFCD.6090604@web.de>
References: <20130925234121.GD9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershau?= =?ISO-8859-1?Q?sen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 26 08:10:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP4mY-0005PS-Sq
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 08:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab3IZGKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 02:10:31 -0400
Received: from mout.web.de ([212.227.15.14]:60589 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab3IZGKa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 02:10:30 -0400
Received: from [192.168.2.107] ([79.223.124.27]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Ma2YF-1V9roa3BkN-00Lmg6 for <git@vger.kernel.org>;
 Thu, 26 Sep 2013 08:10:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20130925234121.GD9464@google.com>
X-Provags-ID: V03:K0:91lyrovnYgMDnq5gLrgJFetD6KgZdeO+dtvzJyM68MQOS/UAAX4
 C58VSKyUpvwJVmZwZyY/PUywA+tuD2/2Rv6jpkXEDsZE57xVLi0bJmtlKn8XL4LcJbSIjkZ
 b3kslTbsc+yTuOuy/PrXXHAo/irpw9p6P0AW3/w27YOL+JjQyF6Jxonp4Gg+TBP212mSYFN
 0Hg317h18QP0I8mVA5u1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235401>

> * jx/relative-path-regression-fix (2013-09-20) 3 commits
>  - Use simpler relative_path when set_git_dir
>  - relative_path should honor dos-driver-prefix
>  - test: use unambigous leading path (/foo) for mingw
> 
>  Waiting for the review to settle.
Is this V3, which is both fixing a regression
and adding support for UNC path ?

My understanding is that V2
commit 5a515ecc086dd8d0b74b0aff1248f4d1dc87f556
jx/relative-path-regression-fix
git://github.com/gitster/git.git


is only fixing the regression and 
could be merged into next, master and possibly maint.
