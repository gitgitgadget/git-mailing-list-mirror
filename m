From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 10:25:25 -0400
Message-ID: <20070611142525.GN25093@menevado.ms.com>
References: <20070608202236.GJ25093@menevado.ms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 16:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxkwN-0002IL-AK
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 16:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbXFKOcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 10:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbXFKOcO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 10:32:14 -0400
Received: from hqmtabh1.ms.com ([205.228.12.101]:63212 "EHLO hqmtabh1.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbXFKOcN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 10:32:13 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jun 2007 10:32:13 EDT
Received: from hqmtabh1 (localhost.ms.com [127.0.0.1])
	by hqmtabh1.ms.com (output Postfix) with ESMTP id 38AC548276
	for <git@vger.kernel.org>; Mon, 11 Jun 2007 10:25:26 -0400 (EDT)
Received: from ny16im02.ms.com (unknown [144.14.206.243])
	by hqvsbh2.ms.com (internal Postfix) with ESMTP id 1CF4D1E13
	for <git@vger.kernel.org>; Mon, 11 Jun 2007 10:25:26 -0400 (EDT)
Received: from menevado.ms.com (menevado [144.14.26.134])
	by ny16im02.ms.com (Sendmail MTA Hub) with ESMTP id l5BEPPF24073;
	Mon, 11 Jun 2007 10:25:25 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id l5BEPPq5029017; Mon, 11 Jun 2007 10:25:25 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070608202236.GJ25093@menevado.ms.com>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 11062007 #321105, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49855>

Reading this again, the subject was probably misleading...  Sorry for that.

In the meantime I've been scouring the archives looking for the proper way to
import p4 history into a project.

I'm attempting to use git-p4import.py as that's what came with my version of
git.  I ran into the problems below.

How can I properly migrate a project from perforce to git? 

Thanks

--Kevin


On 06/08/07 16:22:36, Kevin Green wrote:
> 
> Very new to git.  Was hoping this would be much more straightforward and I'm
> assuming I'm just missing something fundamentally easy.
> 
> I'm using git-p4import.py which came with my release of git.
> 
> I have a small project I'd like to move from perforce to git ( 111 files, 165
> revisions ).
> 
> I've used a number of different approaches to do this, all of them resulting
> in my files being deleted.
> 
> 1)
> $ git init
> $ git-p4import //depot/path master
> 
> bombs out with missing .git/index
> 
> 2)
> $ p4 sync ...
> $ git init
> $ git add .
> $ git commit
> $ git-p4import --stitch //depot/path
> 
> This imports all the comment history, but deletes all of my files!!
> 
> 3)
> $ p4 sync ...
> $ git init
> $ git add .
> $ git commit
> $ git-p4import //depot/path new
> ### new branch with no files, but all my files in master
> $ git checkout master
> $ git merge new
> ### Now I see it deleting all of my files, but it pulls in all of the history. 
> 
> 
> NOTE:  All of the commits pulled in have no file information associated with
> them...
> 
> 
> What am I missing?
> 
> 
> Thanks
> 
> --Kevin
