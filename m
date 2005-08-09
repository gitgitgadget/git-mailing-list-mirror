From: Junio C Hamano <junkio@cox.net>
Subject: Re: Sanity check of git-commit patch, was Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Tue, 09 Aug 2005 10:00:39 -0700
Message-ID: <7vd5onvydk.fsf@assigned-by-dhcp.cox.net>
References: <1123306575.7588.17.camel@dv.roinet.com>
	<7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
	<20050808231036.GA22778@mythryan2.michonline.com>
	<Pine.LNX.4.63.0508090140100.3695@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vpssnyge0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508091212170.6752@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vu0hzw9sx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508091618320.7995@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 19:00:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2XT2-0000UK-TS
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 19:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVHIRAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 13:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVHIRAm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 13:00:42 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:19887 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964876AbVHIRAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 13:00:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809170040.WIB1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 Aug 2005 13:00:40 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508091618320.7995@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 9 Aug 2005 16:19:13 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> True.  My bad old habit.
>
> An elegant method to do that:
>
> case --some-long-option in "$1"*) ..; esac

You are almost correct, but you need to realize that I generate
that long "case -s|--s|--so|--som|..." chain using a script that
takes all potential option names as its arguments, and makes
case arms that contain only unambiguous ones, so that I can
handle --some-long-option and --some-other-long-option sensibly.

Also you forgot to grok --some-option-with-args=* in your
version ;-).
