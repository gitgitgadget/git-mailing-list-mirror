From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] builtin-grep: workaround for non GNU grep.
Date: Wed, 17 May 2006 10:42:48 -0700
Message-ID: <7vhd3ofsyv.fsf@assigned-by-dhcp.cox.net>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
	<Pine.LNX.4.64.0605161904260.16475@g5.osdl.org>
	<7vejythvkr.fsf@assigned-by-dhcp.cox.net>
	<7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
	<4fb292fa0605170839r259732dcw1c1bae3f1808db32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 19:43:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgQ3H-0006hi-BX
	for gcvg-git@gmane.org; Wed, 17 May 2006 19:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWEQRmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 13:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWEQRmv
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 13:42:51 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:47016 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750812AbWEQRmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 13:42:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517174249.SHSJ15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 13:42:49 -0400
To: "Bertrand Jacquin" <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605170839r259732dcw1c1bae3f1808db32@mail.gmail.com>
	(Bertrand Jacquin's message of "Wed, 17 May 2006 17:39:26 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20215>

"Bertrand Jacquin" <beber.mailing@gmail.com> writes:

> Sorry, maybe a C code beginner question but while you define
> NO_H_OPTION_IN_GREP in Makefile, why don't use a build time ``if''
> instead of a runtime one ?
>
> Like :
>
> #if NO_H_OPTION_IN_GREP
>               push_arg("/dev/null");
> #else
>               push_arg("-H");
>               push_arg("--");
> #fi

Exactly because I wanted to avoid conditional compilation using
C preprocessor directive (#if).
