From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Mention the fact that 'git annotate' is only for
	backward compatibility.
Date: Fri, 5 Sep 2008 10:07:59 +0200
Message-ID: <20080905080759.GN10360@machine.or.cz>
References: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com> <1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr> <20080904123046.GX10544@machine.or.cz> <7v63pb3emm.fsf@gitster.siamese.dyndns.org> <vpqaben6r3n.fsf@bauges.imag.fr> <7v3akfxd74.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 10:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbWNV-00006m-9G
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 10:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbYIEIIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 04:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbYIEIIG
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 04:08:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33558 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbYIEIIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 04:08:04 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 77DB2393A367; Fri,  5 Sep 2008 10:07:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3akfxd74.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95001>

On Fri, Sep 05, 2008 at 12:29:51AM -0700, Junio C Hamano wrote:
> diff --git c/Documentation/git-annotate.txt w/Documentation/git-annotate.txt
> index 8b6b56a..78dc5e2 100644
> --- c/Documentation/git-annotate.txt
> +++ w/Documentation/git-annotate.txt
> @@ -14,6 +14,11 @@ DESCRIPTION
>  Annotates each line in the given file with information from the commit
>  which introduced the line. Optionally annotate from a given revision.
>  
> +The only difference from this command and linkgit:git-blame[1] is that
                       ^^^^ between?
> +they use slightly different output formats, and this command exists only
> +for backward compatibility to support existing scripts, and provide more
> +familiar command name for people coming from other SCM systems.
> +
>  OPTIONS
>  -------
>  include::blame-options.txt[]

I like this one. I'm still not too happy about leaving the command in
the command list and tab completion since I believe reducing the number
of commands (which is still quite intimidating for the user), even just
by a little, is more important than encouraging people to use
compatibility aliases. I don't feel very strongly about it, though.

Acked-by: Petr Baudis <pasky@suse.cz>
