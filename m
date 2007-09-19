From: Sam Vilain <sam@vilain.net>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 12:23:40 +1200
Message-ID: <46F06C0C.8090201@vilain.net>
References: <20070917193027.GA24282@old.davidb.org> <20070918233749.GA19533@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXnKC-0005ht-0K
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 02:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbXISAVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 20:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbXISAVs
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 20:21:48 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:35983 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbXISAVr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 20:21:47 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 5965F21CFBA; Wed, 19 Sep 2007 12:21:46 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id C28A121CF28;
	Wed, 19 Sep 2007 12:21:42 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20070918233749.GA19533@old.davidb.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58665>

David Brown wrote:
> 
> An additional problem:
> 
>    - git-p4 doesn't preserve the execute permission bit from Perforce.

FWIW I found that bit on bit 9 of the 'file type' flag in the db, which
is the third column in the "db.rev" table.  It's used to come up with
the silly names like "text" vs "xtext" (difference?  well, one's
executable of course).

Sam.
