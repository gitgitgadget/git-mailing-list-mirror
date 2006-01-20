From: Junio C Hamano <junkio@cox.net>
Subject: Re: /etc in git?
Date: Fri, 20 Jan 2006 09:55:14 -0800
Message-ID: <7vlkxabx8d.fsf@assigned-by-dhcp.cox.net>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>
	<7vlkxckf7o.fsf@assigned-by-dhcp.cox.net>
	<b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com>
	<7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
	<43CF3061.2030504@michonline.com>
	<7vvewgirlt.fsf@assigned-by-dhcp.cox.net>
	<43D0EAA2.8090308@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 18:55:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F00Tr-00031Q-D7
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 18:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWATRzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 12:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWATRzS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 12:55:18 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:28878 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751066AbWATRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 12:55:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060120175236.XLBF17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 Jan 2006 12:52:36 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <43D0EAA2.8090308@michonline.com> (Ryan Anderson's message of
	"Fri, 20 Jan 2006 08:50:26 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14969>

Ryan Anderson <ryan@michonline.com> writes:

>>...  This does not match typical "package" use.
>>
> To provide an off-topic, but perhaps useful, counter-example, where I
> work, I've made a package that does something similar...

Ah, haven't thought about the use of postinstallation scripts.
If your environment is more or less uniform that is an excellent
way of doing it.

Unfortunately, our Solaris boxen do not understand .deb postinst
scripts, so that is why we are not doing it X-<.  Maybe after we
get rid of them perhaps..
