From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHES] CURLDIR support, more usable cmd-rename.sh
Date: Mon, 19 Sep 2005 23:25:52 -0700
Message-ID: <7vfys08dcf.fsf@assigned-by-dhcp.cox.net>
References: <1127128475.781.6.camel@divert>
	<20050919133731.GB2903@pasky.or.cz> <1127139079.781.9.camel@divert>
	<7vhdchqan8.fsf@assigned-by-dhcp.cox.net>
	<1127151642.781.15.camel@divert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 08:27:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHbZo-0005sZ-IS
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 08:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbVITGZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 02:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVITGZ5
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 02:25:57 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:32142 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932699AbVITGZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 02:25:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920062553.MOBB4028.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Sep 2005 02:25:53 -0400
To: Patrick Mauritz <oxygene@studentenbude.ath.cx>
In-Reply-To: <1127151642.781.15.camel@divert> (Patrick Mauritz's message of
	"Mon, 19 Sep 2005 19:40:42 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8981>

Patrick Mauritz <oxygene@studentenbude.ath.cx> writes:

>> Not relevant to the current topic as far as I can tell (unless
>> your non-standard curl include files trip under -Wall).
> the only issue with this is that sunpro's cc doesn't like -Wall

Since you will be saying "make CURLDIR=blah" anyway, I'd ask you
to say "make CURLDIR=blah CFLAGS='-O -g'" and will forget about
this part.

The rest of your patch I am keeping a variant based on it, done
slightly differently, in the proposed updates branch.  I'll have
it graduate to the master branch when I hear from somebody (can
be you) with SunPro that the it is OK (or an improvement patch).

Thanks.
