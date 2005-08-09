From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Tue, 09 Aug 2005 05:56:23 -0700
Message-ID: <7vk6ivw9oo.fsf@assigned-by-dhcp.cox.net>
References: <1123306575.7588.17.camel@dv.roinet.com>
	<7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
	<20050808231036.GA22778@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 14:58:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Tee-0001NP-C0
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 14:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVHIM40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 08:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVHIM40
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 08:56:26 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58583 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932530AbVHIM4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 08:56:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809125625.RXCF19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 Aug 2005 08:56:25 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050808231036.GA22778@mythryan2.michonline.com> (Ryan
	Anderson's message of "Mon, 8 Aug 2005 19:10:36 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> I haven't really given a lot of thought to this yet, but I was thinking
> of something along these lines:
>
> Rename tools/ to mail-tools/, push git-send-email-script into that.
> Create a "porcelain" directory for things like git-bisect-script
> Create a "core" directory for things like "git-commit-script"
> Create a "src" (?) directory for *.[ch]
> Maybe move documentation into the same directory as the scripts they
> belong to.

A good place to start may be to reorganize the categorized list
of commands in Documentation/git.txt.
