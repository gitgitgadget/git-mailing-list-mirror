From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 15:15:37 +0200
Message-ID: <20070716131537.GA26675@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716104342.GB24036@cip.informatik.uni-erlangen.de> <86644kaaf1.fsf@lola.quinscape.zz> <20070716123913.GJ24036@cip.informatik.uni-erlangen.de> <86myxw8pzg.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 15:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAQQQ-0004GM-FF
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 15:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758445AbXGPNPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 09:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757638AbXGPNPi
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 09:15:38 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:58331 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756125AbXGPNPi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 09:15:38 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 212263F446; Mon, 16 Jul 2007 15:15:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86myxw8pzg.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52672>

Hello David,

> Hm?  The hard link counter is "broken" by creating or not creating
> subdirectories, since their ".." is a hard link.

exactly. The question is: Is it a Solaris bug or is it something that is
supposed a user is able to do (it doesn't make sense for me)? I posted
this problem to comp.unix.solaris and also contacted the UFS Maintainer
of Solaris (it is not the first UFS bug I original found). If I don't
receive feedback, I am going to open a call with Sun. Whatever is going
on (hopefully it isn't PEBKAC - but I don't think so) and this time it
isn't broken hardware either (like the last time I reported a serious
git bug) because it happens on two machines.

        Thomas
