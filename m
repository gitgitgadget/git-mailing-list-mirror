From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: git-svn and empty directories
Date: Mon, 22 Dec 2008 09:58:55 +0100
Organization: Intra2net AG
Message-ID: <200812220958.55614.thomas.jarosch@intra2net.com>
References: <200812161353.49796.thomas.jarosch@intra2net.com> <20081221070854.GA22014@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Deskin Miller <deskinm@umich.edu>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Dec 22 10:01:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEgfU-00019A-OQ
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 10:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbYLVI67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 03:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbYLVI67
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 03:58:59 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:50792 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbYLVI67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 03:58:59 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 5141D3E5E;
	Mon, 22 Dec 2008 09:58:57 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id CBB592AC4B;
	Mon, 22 Dec 2008 09:58:56 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id C91052AC4A;
	Mon, 22 Dec 2008 09:58:55 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.7-53.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <20081221070854.GA22014@hand.yhbt.net>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-22_04)
X-Spam-Status: hits=-2.9 tests=[ALL_TRUSTED=-1.8,BAYES_05=-1.11]
X-Spam-Level: 971
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103750>

Hello Eric,

On Sunday, 21. December 2008 08:08:54 Eric Wong wrote:
> Modern git-svn never touches the working tree during fetch, it hashes
> objects into the database and adds those to the indexes directly.

Ok

> However, I don't think your proposal is a good idea since it adds too
> much "magic".  Complex special cases for delta application if the
> .gitignore gets real content and backwards-incompatibility since I know
> some git-svn users already rely on pushing .gitignore files (empty or
> otherwise) to an upstream SVN repo.
>
> The minor problem of missing empty directories isn't big enough to be
> worth the trouble IMHO.

Ok, this seems to be too much effort to fix. I manually added the directories
to my HEAD version and really hope I don't have to ever checkout
and build something from the past *fingers crossed* :-)

Cheers,
Thomas
