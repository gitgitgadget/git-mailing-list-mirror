From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: compare log of two different repos
Date: Thu, 31 Mar 2011 08:05:05 +0200
Message-ID: <4D941991.6070707@drmicha.warpmail.net>
References: <1301514556812-6224714.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sri <nkf364@motorola.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 08:08:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5B3k-0005zy-If
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 08:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab1CaGIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 02:08:39 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43129 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147Ab1CaGIi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 02:08:38 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 795EB208D2;
	Thu, 31 Mar 2011 02:08:37 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 31 Mar 2011 02:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=cbWhKndHS4rEjVRaLXu3H7kcL7s=; b=XezUpD8iejR/9dxfQyNeXPVvuw0n3sireK+VLeq370xtNyCUaTUijsZUqWdCavEwpwpPi2omDqeiC+XJtGnCdbdF9X8yJE4DvScIh3+TTnemMySJw0a1toxlR1PK5arqusPVAnMbnHk9wCaAJC8YFBxGdcD2OtRk+yznNXgTB18=
X-Sasl-enc: BqF90/tee4G7PkaOW+kFDzUs4e4QthFOzGKfMRW7rYSg 1301551717
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F3C4E441466;
	Thu, 31 Mar 2011 02:08:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1301514556812-6224714.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170455>

Sri venit, vidit, dixit 30.03.2011 21:49:
> Hi
> This is my scenario:
> -  Server has 2 different repos say x & y
> - I created a branch out of x ( say xx) and a branch out of y (say yy)
> - Now I made changes to xx/folder1/file1- change 1and commit it ;then I made
> changes to to yy/folder1/file1 -change 1 and yy/folder1/file 1 -change 2 and
> commit it ( Folder 1,file 1, change 1 are same in both xx and yy)
> - Now I want the log of unique commits between both branches ( which will be
> change 2 commit in yy)
> 
> How do I get this using GIT? Right now am doing it manually which is very
> tedious...

You could add one as a "remote" to the other, or both as remotes to a
new repo, and then use

git log --cherry-mark xx...yy

or "--cherry-pick" or the "cherry" command.

Michael
