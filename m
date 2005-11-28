From: Petr Baudis <pasky@suse.cz>
Subject: Re: lost again on syntax change - local repository?
Date: Mon, 28 Nov 2005 21:53:06 +0100
Message-ID: <20051128205306.GU22159@pasky.or.cz>
References: <861x118r9t.fsf@blue.stonehenge.com> <20051128104831.GN22159@pasky.or.cz> <86d5kk7wbv.fsf@blue.stonehenge.com> <20051128134111.GP22159@pasky.or.cz> <86zmno6g3v.fsf@blue.stonehenge.com> <20051128143428.GS22159@pasky.or.cz> <868xv86dam.fsf@blue.stonehenge.com> <20051128191546.GT22159@pasky.or.cz> <86psok378t.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 21:55:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egpzh-0007fu-5u
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 21:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVK1Uw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 15:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVK1Uw5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 15:52:57 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42625 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932097AbVK1Uw4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 15:52:56 -0500
Received: (qmail 3409 invoked by uid 2001); 28 Nov 2005 21:53:06 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86psok378t.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12903>

Dear diary, on Mon, Nov 28, 2005 at 08:25:06PM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
>     localhost:..Git/Play/local.git % cg-push
>     WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol.
>     WARNING: The host:path syntax is evil because it is implicit. Please just use a URI.
>     ssh: \033]2;[zsh] localhost: No address associated with nodename
>     fatal: unexpected EOF

Could you please strace it, to see what argument does git-send-pack
take? (Or hijack git-send-pack if you cannot strace on your system.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
