From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit-0.61
Date: Sat, 25 Jun 2005 02:03:02 -0700 (PDT)
Message-ID: <20050625090302.5601.qmail@web26308.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: mingo@elte.hu, berkus@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 25 10:56:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm6Sx-0007Pv-Un
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 10:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbVFYJDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 05:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbVFYJDJ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 05:03:09 -0400
Received: from web26308.mail.ukl.yahoo.com ([217.146.176.19]:52353 "HELO
	web26308.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263324AbVFYJDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 05:03:03 -0400
Received: (qmail 5603 invoked by uid 60001); 25 Jun 2005 09:03:02 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iWZd1ud/g0ISznqFihacikFq4tGbE39kWbKda476II5PCcZUM72SqJx1FuykmDTEmiqt4yg6RfwnvMN1nMXGAztlox5fEim6JfhyMWzGAWkAxYq+s9dSPEfRLaPSSiSDP9ZTZc9HfB5VlZ/KpmILg7mUDwipqE16fMvsZnefs/c=  ;
Received: from [151.42.53.104] by web26308.mail.ukl.yahoo.com via HTTP; Sat, 25 Jun 2005 02:03:02 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is qgit-0.61

This is mainly a fix release with some work in annotation code.

Changelog from qgit-0.6:

- improve annotation algorithm to detect annotations behind merges

- qgit arguments parsing: switch to use git-rev-parse

- added find function in file viewer

- double click in annotate shows revision

- set Monospace font in file and diff viewer (suggested by Radoslaw Szkodzinski)

- added filter on path in main view

- pretty format annotation header

- fixed annotate alignement

- detect also cogito type tags, i.e. tags shown with cg-tag-ls

Download from:
http://prdownloads.sourceforge.net/qgit/qgit-0.61.tar.bz2?download

Annotation code should be much improved now, but still experimental. 
I need more time to workout all corner cases ( and there are a lot ;-) )


And now a wish:

If may I ask, should be possible to add the object type and name, togheter with sha
in git-rev-list --objects output?
This new option looks very promising to speed up my startup loading.


Thanks
Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
