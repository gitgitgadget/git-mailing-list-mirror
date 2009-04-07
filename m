From: =?iso-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: git over http not re-authenticating after 301 redirect?
Date: Tue, 7 Apr 2009 10:42:43 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0904071041200.5901@localhost.localdomain>
References: <5591393c0904061914y5ea26812kcfc0d14b52ed4300@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Vincent Craven <paul@cravenfamily.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:44:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5yo-0003MU-NC
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbZDGHmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbZDGHmt
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:42:49 -0400
Received: from smtp2.abo.fi ([130.232.213.77]:34977 "EHLO smtp2.abo.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbZDGHms (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:42:48 -0400
Received: from albin.abo.fi (albin.abo.fi [130.232.81.192])
	by smtp2.abo.fi (8.14.3/8.12.9) with ESMTP id n377ghcZ012665;
	Tue, 7 Apr 2009 10:42:44 +0300
X-X-Sender: mstorsjo@localhost.localdomain
In-Reply-To: <5591393c0904061914y5ea26812kcfc0d14b52ed4300@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (smtp2.abo.fi [130.232.213.77]); Tue, 07 Apr 2009 10:42:44 +0300 (EEST)
X-Virus-Scanned: by roxy.abo.fi (roxy.abo.fi: Tue Apr  7 10:42:44 2009)
X-Scanned-By: MIMEDefang 2.67 on 130.232.213.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115920>

Hi Paul,

On Mon, 6 Apr 2009, Paul Vincent Craven wrote:

> Note that after the 301 redirect, I don't seem to have a username sent
> anymore. I'm not sure this is the issue, but is seems like a
> possibility.
> 
> I have the same issue on other computers that have cloned the repository.
> 
> The /my_repo.git/info/ directory does exist.
> 
> I thought I had this working the first day I set it up, but now it no
> longer does. If someone could point me in the correct direction, I'd
> appreciate it.

It's a long shot, but try see if you can upgrade to a newer version of 
libcurl; I think I saw some issue like this when I was experimenting with 
different http auth setups last week, that was solved by using newer 
versions...

// Martin
