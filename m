From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 22:28:10 +0200
Message-ID: <20070611202810.GB4649@steel.home>
References: <20070608202236.GJ25093@menevado.ms.com> <20070611142525.GN25093@menevado.ms.com> <200706111656.33696.simon@lst.de> <20070611164127.GS25093@menevado.ms.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 22:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxqUu-0000H5-Pe
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 22:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXFKU2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 16:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbXFKU2O
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 16:28:14 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:57625 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbXFKU2N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 16:28:13 -0400
Received: from tigra.home (Fca0c.f.strato-dslnet.de [195.4.202.12])
	by post.webmailer.de (fruni mo46) (RZmta 7.2)
	with ESMTP id G01bfdj5BJOukf ; Mon, 11 Jun 2007 22:28:10 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CDA8E277BD;
	Mon, 11 Jun 2007 22:28:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B4201D261; Mon, 11 Jun 2007 22:28:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070611164127.GS25093@menevado.ms.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv0bw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49883>

Kevin Green, Mon, Jun 11, 2007 18:41:27 +0200:
> Is git-p4import.py still used and maintained?

Not really: there is only 5 changes which touch the file and only two
of them have something to do with the import.

> I submitted a patch to fix something trivial on Friday, but didn't
> here any response to that either, which led me to believe that it's
> not the tool being used most often for p4->git migration...

That's not the tool. It is the migration from p4 to anything which
does not happen too often: this company did very good job tying the
customers to this product. Once you reached some critical mass in
your perforce repo you cannot simply stop using it and go with
something else. Not without much pain, anyway.

Getting the development history out of it is the hardest. I'd say it
is impossible, as the states of development directories, unloaded in
"clients", are fluid and not recoverable after they are changed.
Imagine git with just index and no object database support.
