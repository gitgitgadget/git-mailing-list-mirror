From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 09:38:01 +0200
Message-ID: <8FB380EB-CCA4-4BD3-8AD5-93630488D9C9@zib.de>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de> <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org> <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJP3h-00027z-J5
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 09:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbXHJHhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 03:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbXHJHhQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 03:37:16 -0400
Received: from mailer.zib.de ([130.73.108.11]:44522 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbXHJHhP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 03:37:15 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7A7bCYR014552;
	Fri, 10 Aug 2007 09:37:12 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1103e.pool.einsundeins.de [77.177.16.62])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7A7bBSV029738
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 09:37:12 +0200 (MEST)
In-Reply-To: <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55514>


On Aug 10, 2007, at 9:03 AM, Steffen Prohaska wrote:

> Marius, Johannes,
> I really think the right way to fix this would be to include
> tclsh.exe in mingw. I tried to push a commit to mob but failed
> to do so (see separate mail on submodule to the list).
>
> btw,
> I recognized that '.' is included in the PATH in /etc/profile.
> I don't think this is a good idea. At least it bit me once when
> I expected to run /bin/git but instead /git/./git was chosen.
> Shouldn't we remove '.' from the PATH

Ok, I finally defeated git-submodule and pushed two commits to
the mob branch.

e809cacf22d8dada9801403e19d85e423c51f0d9 profile: removed '.' from PATH
6cd2805a3a2ff5e0c941d1882232a22de9d19bf4 mingw: add tclsh.exe (needed  
by git gui)

	Steffen
