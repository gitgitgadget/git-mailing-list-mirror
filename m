From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: Using git for code deployment on webservers?
Date: Wed, 17 Jun 2009 19:42:42 +0200
Message-ID: <200906171942.43002.ioe-lkml@rameria.de>
References: <200906160111.47325.ioe-git@rameria.de> <20090616071328.GB6615@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, ioe-git@rameria.de
X-From: git-owner@vger.kernel.org Wed Jun 17 19:40:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGz7r-0000ug-W3
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 19:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbZFQRkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 13:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755976AbZFQRkK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 13:40:10 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:56942 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbZFQRkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 13:40:09 -0400
X-Greylist: delayed 929 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2009 13:40:09 EDT
Received: from [91.62.59.75] (helo=axel.localnet)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ioe-lkml@rameria.de>)
	id 1MGz7K-0004PE-TJ; Wed, 17 Jun 2009 19:40:11 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; x86_64; ; )
In-Reply-To: <20090616071328.GB6615@lifeintegrity.com>
Content-Disposition: inline
X-Df-Sender: 849595
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121764>

Hi Allan,

On Tuesday 16 June 2009, Allan Wind wrote:
> If you do not mind having a full repository on the web servers, 
> then pushing changes might work better.  This appears to be what 
> you are doing now though.

No, at the moment we have built our own version of a content addressable 
filesystem and are distributing changes to it. We have symlinks to real file names.

I just thought, that git can do sth. similiar with its core, 
before trying to solve a solved problem :-)

> If I had to scale this I would probably build a master image 
> (either locally or remotely) and use rsync to distribute the 
> content instead of git.

We do sth. similiar at the moment. De-duplication is important, because
web people copy lots of data for images and flash around when doing things.

> > - Nearly atomic update of file tree (easy to implement outside git)
> 
> stow can be handy for this.

Ah! Will have a look.

Many Thanks!


Best Regards

Ingo Oeser
