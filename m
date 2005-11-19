From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 19:28:47 -0800
Message-ID: <7v64qpco40.fsf@assigned-by-dhcp.cox.net>
References: <200511181833.40048.ismail@uludag.org.tr>
	<200511181926.10357.ismail@uludag.org.tr>
	<200511182127.06958.ismail@uludag.org.tr>
	<20051118200217.GA2831@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 19 04:29:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdJPI-0002Gj-TP
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 04:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161235AbVKSD2u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 22:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbVKSD2u
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 22:28:50 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:52966 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161235AbVKSD2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 22:28:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119032735.EDCK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 22:27:35 -0500
To: git@vger.kernel.org
In-Reply-To: <20051118200217.GA2831@vrfy.org> (Kay Sievers's message of "Fri,
	18 Nov 2005 21:02:17 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12320>

I just looked at the diff this commit introduces:

	e6bd23911efd0a2bd756c77d9e7ba6576eb739a1
        Documentation: asciidoc sources are utf-8

with gitk (BTW, I pulled from paulus today, so "master" branch
has the latest gitk) while my locale set to LC_CTYPE=en_US.utf8.

Surprisingly, the diff to Documentation/git-pack-redundant.txt,
which changes Lukas' name originally incorrectly encoded in
iso-8859-1 to utf-8, was shown and both pre-image and post-image
lines are readable.

I do not know how tcl/tk does it, but it is doing the right
thing.
