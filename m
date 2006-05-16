From: Junio C Hamano <junkio@cox.net>
Subject: Re: Ouput of git diff with <ent>:<path>
Date: Tue, 16 May 2006 15:44:17 -0700
Message-ID: <7vwtcl4mke.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160605161524j5d7e672eo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 00:44:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg8HB-0003Ew-AW
	for gcvg-git@gmane.org; Wed, 17 May 2006 00:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWEPWoW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 18:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWEPWoV
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 18:44:21 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16348 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932256AbWEPWoT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 18:44:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516224418.LHTW27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 18:44:18 -0400
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160605161524j5d7e672eo@mail.gmail.com> (sbejar@gmail.com's
	message of "Wed, 17 May 2006 00:24:12 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20146>

Santi <sbejar@gmail.com> writes:

> ... I didn't expect the rename from/to neither the
> similarity index 0%.
>
> diff --git a/v1.3.3:Makefile b/Makefile
> similarity index 0%
> rename from v1.3.3:Makefile
> rename to Makefile
> index b808eca..55d1937 100644
> --- a/v1.3.3:Makefile
> +++ b/Makefile

Yes I am aware of this one; I just haven't bothered to deal with
it.

It looks at two strings, "v1.3.3:Makefile" and "Makefile", and
says "they have different names -- they are renamed".

Patches welcome as long as you do not break more usual cases
;-).
