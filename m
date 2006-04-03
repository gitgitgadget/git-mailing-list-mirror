From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: git-svn and svn sw --relocate
Date: Mon, 03 Apr 2006 18:20:17 +0200
Message-ID: <44314B41.3050902@iaglans.de>
References: <4430123E.5090605@iaglans.de> <20060402222100.GA17888@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 03 18:22:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQRoT-0005lZ-Fx
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 18:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWDCQVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 12:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWDCQVy
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 12:21:54 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:24083 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751779AbWDCQVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 12:21:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 11C3F436F
	for <git@vger.kernel.org>; Mon,  3 Apr 2006 18:21:51 +0200 (CEST)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19890-01 for <git@vger.kernel.org>;
	Mon, 3 Apr 2006 18:21:51 +0200 (CEST)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 8B9E2434A
	for <git@vger.kernel.org>; Mon,  3 Apr 2006 18:21:50 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
In-Reply-To: <20060402222100.GA17888@localdomain>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18341>

Eric Wong wrote:
> Nicolas Vilz 'niv' <niv@iaglans.de> wrote:
>>i have now my repository locally and i want to get it remotely on a
>>server, in order to have a few collaborators...
>>
>>the steps on the svn-side are clear. But what do i have todo on the
>>git-svn-side of this life?
>>
>>does a simple "svn sw --relocate" do the job in the git-svn meta-dir?
> 
> 
> Yes, you'll need to do that in .git/git-svn/tree and also update
> .git/git-svn/info/url by hand.

Will there be any other sha1-sums for that repository so that i have to
merge them again and again? This issue occured to me the last time i
encountered the git-svn-change with the external sources, where i had to
repair my external git-svn-tree, which resulted in new sha1sums
somehow... that was very unpleasant to my collegue..

Although the uuids there should remain the same... so i think, that
would be no problem to try.

Thanks for the tip.

Nicolas
