From: Junio C Hamano <junkio@cox.net>
Subject: Re: as promised, docs: git for the confused
Date: Tue, 13 Dec 2005 00:01:03 -0800
Message-ID: <7vd5k1bf40.fsf@assigned-by-dhcp.cox.net>
References: <20051209215414.14072.qmail@science.horizon.com>
	<7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
	<20051212195319.11d41269.tihirvon@gmail.com>
	<Pine.LNX.4.64.0512121010550.15597@g5.osdl.org>
	<86y82qyrqs.fsf@blue.stonehenge.com>
	<20051213035842.GF10371@always.joy.eth.net>
	<86d5k1y7dp.fsf@blue.stonehenge.com>
	<7vzmn5bmlk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 13 09:18:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Em5Ky-0001gA-OV
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 09:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVLMIQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 03:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVLMIQg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 03:16:36 -0500
Received: from fed1rmmtai10.cox.net ([68.230.241.49]:48557 "EHLO
	fed1rmmtai10.cox.net") by vger.kernel.org with ESMTP
	id S932528AbVLMIQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 03:16:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213080108.YASQ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 03:01:08 -0500
To: git@vger.kernel.org
In-Reply-To: <7vzmn5bmlk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 12 Dec 2005 21:19:19 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13573>

Junio C Hamano <junkio@cox.net> writes:

> The only Plumbing support is that ls-files takes --exclude-from=
> and --exclude-per-directory= options.  It is up to the Porcelain
> layer what names to use.
>
> We agreed upon a convention to use .gitignore as per-directory
> and .git/info/exclude (I think this came from existing practice
> by Cogito back then) as the tree-wide fallback, when these two
> flags were introduced to ls-files, for interoperability across
> Porcelains.

... and as Linus pointed out already, the barebone Porcelain-ish
that ship with git follows that convention as well.

Now those commands are not Porcelain, so please do not call them
with any bathroom fixture names ;-).
