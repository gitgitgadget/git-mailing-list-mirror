From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Tue, 17 Jul 2007 14:39:33 +0100
Message-ID: <tnx4pk39mju.fsf@arm.com>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bradford Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 15:39:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAnHI-0002BI-Cu
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 15:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbXGQNjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 09:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752660AbXGQNjo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 09:39:44 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:54381 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505AbXGQNjo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 09:39:44 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l6HDdZbI023318;
	Tue, 17 Jul 2007 14:39:35 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Tue, 17 Jul 2007 14:39:35 +0100
In-Reply-To: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com> (Bradford
 Smith's message of "Sun, 15 Jul 2007 17:27:59 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 17 Jul 2007 13:39:35.0378 (UTC) FILETIME=[E9DFF320:01C7C877]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52760>

"Bradford Smith" <bradford.carl.smith@gmail.com> wrote:
> However, when I tried running 'git-config --global color.diff auto'
> today, it removed my symlink and replaced it with a real file.  This
> left me briefly a bit confused when the changes I had made didn't show
> up in ~/etc/gitconfig, but git-config reported them anyway.

Another problem I have with 'git config --global' is that it changes
the access permission bits of ~/.gitconfig. Since I use the same file
to store global StGIT configuration like SMTP username and password,
I'd like to make its access 0600 but it always goes back to 0644 after
'git config --global'.

Maybe fixing the symlink case would solve my problem as well.

Thanks.

-- 
Catalin
