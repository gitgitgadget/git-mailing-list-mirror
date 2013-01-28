From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Port 22
Date: Mon, 28 Jan 2013 10:20:22 +0100
Message-ID: <510642D6.1000108@drmicha.warpmail.net>
References: <55B0A474-AD5B-44B5-91E7-FA5253FA5682@gmail.com> <CAO54GHBFo94Pes1cJ9MVvVJGD5ZMK4yMv9+_shtT8iPP-DVtsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Craig Christensen <cwcraigo@gmail.com>, git <git@vger.kernel.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:20:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzktQ-0005fr-DY
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 10:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763Ab3A1JUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 04:20:24 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:32976 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753068Ab3A1JUW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 04:20:22 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AA722209E2;
	Mon, 28 Jan 2013 04:20:21 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 28 Jan 2013 04:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=1y8XGJeo8QtX1te8/WDOJU
	PPjfU=; b=O5vfB4H9TL+KozerpHH+aLRuS3WOr8JcJgjYcXbip0W9vOiHwG9qEc
	g8ljuU6bIMYEY98v+da37VRZE9JVEYYTiQKyTZUJApboeSP5RCFr8III1DCu7oyX
	MgvZpxQArkSSZ9JgmqF8gOraB3K/6vFeqxVRw9r2sVApu3iONfmlw=
X-Sasl-enc: iDEKMLUUlocEYWXkn5dmu9uQEpzdQGUzso7rTaKH7n3p 1359364821
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0656D8E08B5;
	Mon, 28 Jan 2013 04:20:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <CAO54GHBFo94Pes1cJ9MVvVJGD5ZMK4yMv9+_shtT8iPP-DVtsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214823>

Kevin venit, vidit, dixit 28.01.2013 09:06:
> This is not really a git problem, but more of an ssh problem.
> 
> Are you in the position to change the port where the SSH daemon
> listens on? Then you could use a different port which isn't blocked
> (443 perhaps?).
> 
> On Sat, Jan 26, 2013 at 7:56 PM, Craig Christensen <cwcraigo@gmail.com> wrote:
>> I am currently a student at Brigham Young University - Idaho and we are use Pagoda Box and Git for our Mobile Apps class.  However, the school's network has blocked incoming trafic on port 22.  I have been searching through all the tutorials and documents provided by Pagoda Box and Git but have not been able to find a solution to solve this problem.  We can use sftp but we then have to manually deploy the latest using the admin panel.  Can you help provide a simple solution?

So how is your setup:

- Pagoda Box instance at BYU
- sftp uploads allowed, but not ssh
- drive Git on the box using the admin interface

Or do you use a Pagoda server? Do you have read access to the git repo
on the box?

ssh allows to restrict commands to only a subset, such as ssh only. If
the port were blocked for incoming traffic you wouldn't be able to use
(ssh at all thus) sftp either.

Michael
