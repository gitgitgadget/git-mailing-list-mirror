From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [spf:guess,iffy] Re: [spf:guess] Re: Approaches to SVN to Git
 conversion (was: Re: [RFC] "Remote helper for Subversion" project)
Date: Thu, 08 Mar 2012 20:51:44 +0000
Message-ID: <4F591BE0.4070709@pileofstuff.org>
References: <ab5eb5a7-a446-4dc3-b8e8-e3f7ec306452@mail> <4F56A4DF.8060807@vilain.net> <4F57DBF0.4060101@pileofstuff.org> <4F57EC04.8060705@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stephen Bash <bash@genarts.com>, Nathan Gray <n8gray@n8gray.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5kJX-0005w1-0f
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 21:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab2CHUvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 15:51:50 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:24115 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978Ab2CHUvt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 15:51:49 -0500
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120308205147.QLVP4985.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Thu, 8 Mar 2012 20:51:47 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120308205147.IHVZ5924.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Thu, 8 Mar 2012 20:51:47 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <4F57EC04.8060705@vilain.net>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=-DmM2z4uaqYA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=8UEZmXJCJS43ksfY2ToA:9 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192647>

Thanks - this has really helped my thoughts to crystalise.
Here's my plan at this point:

1. Create an "SVN History description" project

This will build on the ASCII format I've been proposing so far.  The
goal will be to produce a human- and machine-readable format that
describes SVN history in terms of an idealised version control system;
and to produce a set of tests that any SVN history exporter can use as a
testing framework.

2. Create an SVN history exporter

This will build on the svn-branch-export.pl script I previously made
available.  That script ran in exactly two passes ("configure" and
"make") which wrote pointlessly different file formats.  The new script
will accept an SVN history file as input and create another SVN history
file as output, allowing users to iteratively improve the file as Sam
described.

3. Create an SVN history importer for git

This will resemble the git-branch-import.pl script I previously made
available, but written in C based on the final SVN history format.  This
thread has convinced me this would be a nice little SoC project, and
I'll propose it in another thread if I've got project 1 to a reasonable
state before it's too late.  Failing that, and if nobody else wants to
take this project, I'll have a go myself some day when project 2 is
approaching completion.

My next step will be to write up the SVN history work thrown up by this
thread.  I'll come back to the list for advice when I've got something
presentable.

	- Andrew
