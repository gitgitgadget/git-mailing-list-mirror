From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 0/4] stripspace: Implement and use --count-lines option
Date: Sat, 17 Oct 2015 12:28:09 +0200
Message-ID: <20151017102809.GB2468@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
 <vpqsi5a69ey.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 17 12:28:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnOit-0006I5-13
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 12:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbbJQK2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 06:28:19 -0400
Received: from sym2.noone.org ([178.63.92.236]:54486 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbbJQK2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 06:28:12 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ndLCZ72NpzQWhr; Sat, 17 Oct 2015 12:28:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqsi5a69ey.fsf@grenoble-inp.fr>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279781>

On 2015-10-16 at 18:54:45 +0200, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
> 
> >   - Split patch 2/3 into two patches: patch 2/4 switches git stripspace
> >     to use parse-options and patch 3/4 introduces the new option.
> 
> Much better now.
> 
> >   - Implement line counting in cmd_stripbuf() instead of (ab-)using
> >     strbuf_stripspace() for it.
> 
> Also short and sweet, I like it.
> 
> >   - Drop -C short option
> >   - Correct example command output in documentation.
> >   - Adjust commit messages to not include links to the wiki, fully
> >     describe the motivation in the commit message instead.
> 
> Good.
> 
> I read the patches again, and the whole series is now
> 
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thank you for the review!
