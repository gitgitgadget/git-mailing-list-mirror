From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 10:15:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201006360.6467@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <426583D5.2020308@mesatop.com>
 <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org> <dnbr898k0k.fsf@magla.zg.iskon.hr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 19:11:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOIhU-0002BY-TI
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDTRNi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDTRNi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:13:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:27838 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261683AbVDTRNe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 13:13:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KHDSs4013063
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 10:13:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KHDR5f014807;
	Wed, 20 Apr 2005 10:13:28 -0700
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
In-Reply-To: <dnbr898k0k.fsf@magla.zg.iskon.hr>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Zlatko Calusic wrote:
> 
> I see this -avz incantation mentioned everytime when rsync is
> involved. But, is the -z part (compression) really necessary knowing
> that we're dealing with an already compressed tree? Doesn't it put
> additional strain on the rsync server without any benefit in this
> case?
> 
> Or I might be too ignorant and not understand some internals well, but
> then... I would like to know the reason. :)

I'm not a big rsync user, so I just copied the examples of others.

You're right, for git, you should not use compression for files (I don't 
know if rsync compresses the directory listings by default, I assume it 
does). 

		Linus
