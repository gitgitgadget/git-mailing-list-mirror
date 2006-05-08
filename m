From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #2
Date: Sun, 07 May 2006 19:51:09 -0700
Message-ID: <7v3bfli602.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605041627310.6713@iabervon.org>
	<Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
	<7vhd43vgnm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
	<BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE>
	<Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
	<BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE>
	<Pine.LNX.4.64.0605061008340.16343@g5.osdl.org>
	<7vvesirh0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0605062332420.6423@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy7xekwbs.fsf@assigned-by-dhcp.cox.net> <e3km6q$f7p$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 04:51:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcvqE-00083f-8i
	for gcvg-git@gmane.org; Mon, 08 May 2006 04:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWEHCvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 22:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWEHCvM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 22:51:12 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:42155 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932261AbWEHCvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 22:51:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508025111.OTLP17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 22:51:11 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e3km6q$f7p$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	07 May 2006 13:38:16 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19755>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>>             char *value; /* "existence" bool may have NULL,
>>                           * otherwise probably a string "= value"
>>                           */
>
> Probably " = value" to preserve whitespace (e.g. justify on equal sign in
> hand crafted config file).

Probably even better is to remove the separate *value_comment,
and make this thing point at the entire " = value ; this is the
comment for the value\n" thing.
