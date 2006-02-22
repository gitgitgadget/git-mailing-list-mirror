From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Wed, 22 Feb 2006 14:25:36 -0800
Message-ID: <7v4q2rm3of.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060220191011.GA18085@hand.yhbt.net>
	<7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
	<43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
	<43FB9656.8050308@vilain.net>
	<81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
	<Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:26:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC2Qy-0008EG-Rn
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 23:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWBVWZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 17:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWBVWZo
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 17:25:44 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:22756 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751560AbWBVWZn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 17:25:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222222259.EGTQ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 17:22:59 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 22 Feb 2006 23:00:45 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16618>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 22 Feb 2006, Alex Riesen wrote:
>
>> IPC::Open2 works!
>
> Note that there is a notable decrease in performance in my preliminary 
> tests (about 10%).

Doesn't open(F, "| foo bar") or open(F, "foo bar |") with
careful shell quoting work?
