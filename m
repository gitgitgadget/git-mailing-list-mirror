From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] gitweb: Document that gitweb deals with bare repositories
Date: Fri, 15 May 2009 16:24:36 -0500
Message-ID: <4A0DDD94.1010901@freescale.com>
References: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com> <20090515211611.27697.82605.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 23:24:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M54tm-0007uj-LR
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 23:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbZEOVYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 17:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541AbZEOVYk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 17:24:40 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:64454 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbZEOVYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 17:24:39 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n4FLObaV019067;
	Fri, 15 May 2009 14:24:37 -0700 (MST)
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4FLOaqD013065;
	Fri, 15 May 2009 16:24:36 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090504 SeaMonkey/2.0a3
In-Reply-To: <20090515211611.27697.82605.stgit@localhost.localdomain>
X-Brightmail-Tracker: AAAAAQAAAWE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119299>

Jakub Narebski wrote:

> Does this explanation help?

Yes, it does, but I wish it weren't true.  I don't see why gitweb can't be enhanced to support non-bare repositories without using symlinks or other hackery.

To avoid the overhead of gitweb scanning all of my repositories for other respitories, I use a packages_list, which is automatically recreated whenever I add a new repo.  However, I think having to create a shadow bare repository with a cron job to keep it more-or-less update is wrong.

Just my two cents.

-- 
Timur Tabi
Linux kernel developer at Freescale
