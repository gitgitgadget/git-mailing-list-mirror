From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Wed, 22 Feb 2006 11:54:23 -0800
Message-ID: <7vmzgjmaog.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060220191011.GA18085@hand.yhbt.net>
	<7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
	<81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
	<43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
	<43FB9656.8050308@vilain.net>
	<81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
	<43FCC0D0.5050307@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 20:54:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC04C-0006Ui-OS
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 20:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWBVTy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 14:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWBVTy0
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 14:54:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16581 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750831AbWBVTyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 14:54:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222195249.COKG6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 14:52:49 -0500
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <43FCC0D0.5050307@vilain.net> (Sam Vilain's message of "Thu, 23
	Feb 2006 08:51:44 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16613>

Sam Vilain <sam@vilain.net> writes:

> Checking in Module::CoreList, that module goes right back to the Perl
> 5.0 release, so every normal Perl 5 distribution should have it.

Good digging, but IIRC this thread started because something
that _claims_ to be 5.8 does not grok open(F, '-|') correctly,
so...
