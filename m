From: Andreas Gruenbacher <agruen@suse.de>
Subject: Missing trailing newline with git log --pretty=format
Date: Wed, 18 Mar 2009 22:23:58 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903182223.58800.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 22:27:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Hd-0003xZ-Pj
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbZCRVZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbZCRVZI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:25:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34031 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbZCRVZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:25:06 -0400
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 49E5186391
	for <git@vger.kernel.org>; Wed, 18 Mar 2009 22:25:04 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113671>

Hello,

with the latest version of git from right now (e986ceb):

While trying to get a reverse list of commit ids, I noticed that git log 
prints newlines between commits, but not at the end. This results in two 
joined lines with:

	$ git log --pretty=format:%h HEAD^^..HEAD | tac
	aab3b9a7d4e3a7
	e986ceb

Any chance of getting this fixed?

Thanks,
Andreas
