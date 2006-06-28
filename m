From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Quick merge status updates.
Date: Wed, 28 Jun 2006 09:32:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606280928540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 09:33:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvUXR-0002rg-6Y
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 09:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423203AbWF1Hcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 03:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423201AbWF1Hci
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 03:32:38 -0400
Received: from mail.gmx.net ([213.165.64.21]:62684 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423203AbWF1Hch (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 03:32:37 -0400
Received: (qmail invoked by alias); 28 Jun 2006 07:32:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 28 Jun 2006 09:32:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22775>

Hi,

On Tue, 27 Jun 2006, Junio C Hamano wrote:

> Immediately after 1.4.1 happens, I would like to pull in
> "Git.xs/Git.pm" series by Pasky into "next".

Earlier, you said that this is primarily for gitweb, not so much for the 
core of git. But...

> Breakage there would stop your "git pull" working, so this is somewhat 
> important.

May I respectfully offer my objection? This is the _heart_ of git. You do 
not want to muck around with this.

I am not opposed to a sane interface between Perl and git, but please 
please PLEASE do not make such an important part of git dependent on 
Git.pm. (Somehow I have the impressions there are echoes here.)

Ciao,
Dscho
