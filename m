From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Encoding problems using git-svn
Date: Sun, 2 Nov 2008 01:48:45 -0800
Message-ID: <20081102094845.GB16003@untitled>
References: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com> <20081030074114.GA26926@yp-box.dyndns.org> <8b168cfb0810300814i53a264c2x997543e145d5e15a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: James North <tocapicha@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:50:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZbC-0008T2-VP
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbYKBJsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbYKBJsr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:48:47 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60236 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbYKBJsq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:48:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 18DE02DC01B;
	Sun,  2 Nov 2008 09:48:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8b168cfb0810300814i53a264c2x997543e145d5e15a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99835>

James North <tocapicha@gmail.com> wrote:
> Hi Eric,
> 
> Don't worry about not seeing the patch and thanks for the answer :)
> 
> Your patch works great.
> 
> Messages appear without problems on "svn log" and "git log", I haven't
> found any gotcha that I know of.

Thanks for the confirmation.

> The weird thing is that this problem was not found by anyone before, I
> guessed there should be some people with a setup similar to mine.

Squeaky wheel gets the grease :)

Honestly, I think most folks have just moved onto UTF-8 entirely and
left legacy encodings behind.  Especially people using modern tools like
git (along with SVN enforcing UTF-8 at the repository/protocol level).


Junio:

I've pushed the following out to git://git.bogomips.org/git-svn.git:

Eric Wong (2):
      git-svn: don't escape tilde ('~') for http(s) URLs
      git-svn: respect i18n.commitencoding config

I'll try to get around to the more robust escaping checks
and splitting out the monolithic git-svn.perl source next
week.

-- 
Eric Wong
