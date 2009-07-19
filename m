From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: how to start with non-master branch?
Date: Sun, 19 Jul 2009 20:26:45 +0200
Message-ID: <4A636565.2000703@drmicha.warpmail.net>
References: <f46c52560907190553x4e21ffbdn6d55c43f2d6b08ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 20:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSb77-00020W-EV
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 20:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbZGSS1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 14:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbZGSS1G
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 14:27:06 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49384 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755204AbZGSS1D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2009 14:27:03 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6FF363BBAE8;
	Sun, 19 Jul 2009 14:27:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 19 Jul 2009 14:27:02 -0400
X-Sasl-enc: YSEzZdlYZHDYn3qezj9uoDGO/Y5LrBthWPlNGvC7hrvM 1248028022
Received: from localhost.localdomain (p5DCC04E2.dip0.t-ipconnect.de [93.204.4.226])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B05864CCCD;
	Sun, 19 Jul 2009 14:27:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090718 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <f46c52560907190553x4e21ffbdn6d55c43f2d6b08ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123559>

Rustom Mody venit, vidit, dixit 19.07.2009 14:53:
> I want my first commit to be on a non-master branch.
> So after the git init I do
> $ git checkout -b newbranch
> 
> I get
> fatal: You are on a branch yet to be born
> 
> Of course I can get by with making the first commit on master and then
> switching.
> 
> But wondering if I am missing something basic?

You can do

git symbolic-ref HEAD refs/heads/newbranch

and your first commit will be to that branch. (checkout as above tries
to branch off the non-existing branch master.)

Cheers,
Michael
