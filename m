From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: git rebase stops on empty commits
Date: Wed, 22 Jul 2009 09:08:55 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0907220907550.9220@ds9.cixit.se>
References: <33e2b2760907220022rbad30d7x255bcb63c5b8cc2f@mail.gmail.com> <loom.20090722T073645-17@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Blakeney <markb@berlios.de>
X-From: git-owner@vger.kernel.org Wed Jul 22 10:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTWt2-0000Co-Lj
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 10:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbZGVIJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 04:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbZGVIJA
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 04:09:00 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:49439 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753122AbZGVII7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 04:08:59 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n6M88tUU013300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Jul 2009 10:08:55 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n6M88tqk013297;
	Wed, 22 Jul 2009 10:08:55 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <loom.20090722T073645-17@post.gmane.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 22 Jul 2009 10:08:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123745>

Mark Blakeney:

> but all the "git commit --allow-empty" commits are committed with my own 
> name and current date+time.

If you edit the commit, you claim ownership of it. You should probably try 
using the -C option to commit, it should allow you to edit the message, 
while keeping the authorship and timestamp intact.

-- 
\\// Peter - http://www.softwolves.pp.se/
