From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] mergetool: make Apple's FileMerge available as a merge_tool
Date: Sun, 17 Jun 2007 18:13:11 +0200
Message-ID: <B12626B9-766E-4EA4-888F-B3E2DA889D15@zib.de>
References: <11820959413590-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 17 18:12:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzxMF-0006Vx-1B
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 18:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbXFQQMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 12:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbXFQQMF
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 12:12:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:40067 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbXFQQME (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 12:12:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5HGC1C0021695
	for <git@vger.kernel.org>; Sun, 17 Jun 2007 18:12:01 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db117e6.pool.einsundeins.de [77.177.23.230])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5HGC1mk015812
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 17 Jun 2007 18:12:01 +0200 (MEST)
In-Reply-To: <11820959413590-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50358>


On Jun 17, 2007, at 5:59 PM, Steffen Prohaska wrote:

> Apple's developer tools include the application FileMerge,
> which supports graphical three way merges with ancestor.
> This patch makes the tool available through git-mergetool.
>
> FileMerge is assumed to be installed at its default location.

Hmm, now I found out that opendiff, which was already available
as an option, actually launches FileMerge.

I wasn't aware of this fact. git-mergetool proposed to use vimdiff
although I had preferred the graphical application FileMerge, which
would have been launched by opendiff.

Don't know if my patch makes any sense. Probably a note in the
documentation that opendiff launches the GUI would be nice.

	Steffen
