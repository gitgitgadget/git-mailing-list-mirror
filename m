From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: RFC: submodule terminology
Date: Sun, 20 May 2007 17:32:49 -0700
Message-ID: <1179707569.11098.1.camel@localhost>
References: <20070520214417.GM5412@admingilde.org>
	 <200705210006.47266.johan@herland.net>
	 <20070520230352.GQ5412@admingilde.org>
	 <200705210116.25079.johan@herland.net>
	 <20070520233913.GT5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 06:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpzWj-0000NP-D0
	for gcvg-git@gmane.org; Mon, 21 May 2007 06:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292AbXEUE3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 00:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757377AbXEUE3h
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 00:29:37 -0400
Received: from smtp-4.smtp.ucla.edu ([169.232.46.137]:39026 "EHLO
	smtp-4.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757292AbXEUE3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 00:29:35 -0400
X-Greylist: delayed 2061 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 May 2007 00:29:35 EDT
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.151])
	by smtp-4.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l4L3t2wd025874;
	Sun, 20 May 2007 20:55:02 -0700
Received: from [169.232.244.64] (wl-s244-64.resnet.ucla.edu [169.232.244.64])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l4L3t1on030268
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Sun, 20 May 2007 20:55:01 -0700
In-Reply-To: <20070520233913.GT5412@admingilde.org>
X-Mailer: Evolution 2.10.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.46.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47962>

On Mon, 2007-05-21 at 01:39 +0200, Martin Waitz wrote:
> hoi :)
> 
> On Mon, May 21, 2007 at 01:16:24AM +0200, Johan Herland wrote:
> > The term "gitlink" is ambiguous/confusing? I didn't know. What's the 
> > other meaning of gitlink?
> 
> there was some talk about lightweight checkouts using some .gitlink
> file instead of a .git directory.
> 

This was my project, but if I end up trying to do lightweight checkouts
I'll avoid a .gitlink file most likely (and go with something
in .git/config instead).  Gitlink is therefore quite safe.

-Eric
