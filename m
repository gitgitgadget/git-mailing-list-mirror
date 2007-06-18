From: "Brian L. Troutwine" <goofyheadedpunk@gmail.com>
Subject: The --no-commit blues
Date: Mon, 18 Jun 2007 08:06:26 -0700
Message-ID: <200706180806.26255.goofyheadedpunk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 17:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0IoN-0004x8-E8
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 17:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbXFRPGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 11:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763293AbXFRPGd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 11:06:33 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:32798 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbXFRPGc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 11:06:32 -0400
Received: by py-out-1112.google.com with SMTP id a29so3145660pyi
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 08:06:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mhR5sVSf4fMvv3F4OrPb2QeXS/uu8PcPqU/mn5jGzlC1a81+Ysin7dy2qowGkdlXC50R8dNh5vRQkMMbh6DPPtqKIi7zi9UDNVRV/+PGzGDFaipMEclboARfEuSrPUZZiCPcUNNWYRtSj4g8RQhI90RSIxKX6xXVzW7Lh4YPex0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z3Qzgr1+tXQUlLBCsqbAT1yhHg0vdiLsb095ScvLS0pXt5Hfa7jyOa1dJe5K3XJgIgKRwNLufAv9W/aZDe+bYnb7FbnYJpxeGYq2vbgD4x81SIG+jt/0jCporA78O7sbFWlFxf9InyVNQdCjMe1OWTh8KOxtvX5ukbPV31SOJXk=
Received: by 10.114.106.1 with SMTP id e1mr6279203wac.1182179192023;
        Mon, 18 Jun 2007 08:06:32 -0700 (PDT)
Received: from doritos.local ( [66.93.39.139])
        by mx.google.com with ESMTP id l36sm14743167waf.2007.06.18.08.06.28
        (version=SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 08:06:30 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50399>

I've got two branches, one which I commit to quite frequently and another only 
periodically, call them inward and outward. Inward is where I do my work, 
outward tracks an SVN repository. I'd like to merge inward to outward without 
committing the merge so that I may provide a commit message appropriate for 
checking in to the SVN repo. 

`git merge --no-commit inward' from branch outward, I thought, should do it. 
Performing a `git status' and a `git log' directly afterward seem to indicate 
that the merge was committed. `git commit' insists the branch is now up to 
date.

Am I going about this the wrong way? What does --no-commit mean, if I am?

(Also, I asked this on #git earlier. If anyone happens to idle there, pardon 
me for re-posting this so quickly. I've got terrible lag this morning, enough 
to time out frequently.)
