From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Configurable name(s) for .gitmodules
Date: Mon, 10 Dec 2007 17:54:36 +0100
Message-ID: <20071210165436.GG3490MdfPADPa@greensroom.kotnet.org>
References: <46dff0320712070800j6dd83714j265b3f7b291b855c@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1luJ-0004hZ-FD
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbXLJQyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbXLJQyk
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:54:40 -0500
Received: from psmtp09.wxs.nl ([195.121.247.23]:52740 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbXLJQyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 11:54:39 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JSU001L4EZ0O2@psmtp09.wxs.nl> for git@vger.kernel.org; Mon,
 10 Dec 2007 17:54:38 +0100 (MET)
Received: (qmail 3186 invoked by uid 500); Mon, 10 Dec 2007 16:54:36 +0000
In-reply-to: <46dff0320712070800j6dd83714j265b3f7b291b855c@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67736>

On Sat, Dec 08, 2007 at 12:00:12AM +0800, Ping Yin wrote:
> I have a super project with many submodules. Each kind of role may
> check out different set of submodules. There are some common modules
> which are almost checked out by every role.
> 
> Here comes my question: how to implement this elegantly? If all
> submodules are put in the same .gitmodules, every role has to in the
> command line manually designate all submodules to be checked out.

You could have submodules (roles in your case) containing
other submodules, as proposed in the thread that ends in
http://thread.gmane.org/gmane.comp.version-control.git/48643/focus=48939

skimo
