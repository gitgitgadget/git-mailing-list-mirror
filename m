From: Marcus Karlsson <mk@acc.umu.se>
Subject: Re: git branch
Date: Mon, 23 May 2011 13:46:33 +0200
Message-ID: <20110523114633.GE7387@kennedy.acc.umu.se>
References: <BANLkTinzped82Njnw4ZUeHY6Qu4R4hKK-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gergely Buday <gbuday@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 13:57:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOTky-0007cA-5X
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 13:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab1EWL5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 07:57:01 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:34717 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309Ab1EWL5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 07:57:01 -0400
X-Greylist: delayed 625 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 May 2011 07:57:00 EDT
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id B7A35F79;
	Mon, 23 May 2011 13:46:34 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from kennedy.acc.umu.se (kennedy.acc.umu.se [130.239.18.157])
	by mail.acc.umu.se (Postfix) with ESMTP id 15CEDF78;
	Mon, 23 May 2011 13:46:34 +0200 (MEST)
Received: by kennedy.acc.umu.se (Postfix, from userid 24678)
	id 034CEDD6; Mon, 23 May 2011 13:46:33 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <BANLkTinzped82Njnw4ZUeHY6Qu4R4hKK-w@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174238>

On Mon, May 23, 2011 at 01:36:09PM +0200, Gergely Buday wrote:
> Hi there,
> 
> I created
> 
> git branch install_2.0
> 
> for my install script. Then pushed to
> 
> git push origin install_2.0
> 
> so that github stores by branch
> 
> after another commit I tried to push again but git told me that I'm
> not on that branch. Why git loses the state that I'm on a branch? What
> should I do to have my expected behaviour?
> 
> - Gergely

I'm not sure if I'm following you correctly, but with Git you need to
check out your branch after creating it. Run git checkout install_2.0
after you have created it.

	Marcus
