From: Junio C Hamano <junkio@cox.net>
Subject: Re: (patch) calloc->xcalloc in read-cache.c
Date: Mon, 08 May 2006 13:54:50 -0700
Message-ID: <7vzmhsdyp1.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0605081101w3dc3a60cof5a524e9b4a3f555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 22:55:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdCko-0000xg-Jl
	for gcvg-git@gmane.org; Mon, 08 May 2006 22:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWEHUyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 16:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWEHUyw
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 16:54:52 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32432 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750797AbWEHUyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 16:54:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508205450.YYAW25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 16:54:50 -0400
To: "Yakov Lerner" <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0605081101w3dc3a60cof5a524e9b4a3f555@mail.gmail.com>
	(Yakov Lerner's message of "Mon, 8 May 2006 21:01:40 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19778>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> --- read-cache.c.000    2006-05-08 15:13:57.000000000 +0000
> +++ read-cache.c        2006-05-08 15:15:35.000000000 +0000
> @@ -557,7 +557,7 @@
>
>        active_nr = ntohl(hdr->hdr_entries);
>        active_alloc = alloc_nr(active_nr);
> -       active_cache = calloc(active_alloc, sizeof(struct cache_entry *));
> +       active_cache = xcalloc(active_alloc, sizeof(struct cache_entry *));
>
>        offset = sizeof(*hdr);
>        for (i = 0; i < active_nr; i++) {
>
> Yakov

While I do not mind hand generated patch, your mailer setting
seems to be seriously broken.  

Mind checking Documentation/SubmittingPatches and try again?
