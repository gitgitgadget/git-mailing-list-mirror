From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: BUG: For first push to a bare repo, using "--tags" prevents creation of master branch
Date: Fri, 29 May 2015 17:45:06 +0200
Message-ID: <vpq4mmvs7zx.fsf@anie.imag.fr>
References: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
	<vpqbnh4hro7.fsf@anie.imag.fr>
	<xmqq617bflzh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Darling <darlingm@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 17:45:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyMTH-0003J5-U5
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 17:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756394AbbE2PpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 11:45:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45829 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756381AbbE2PpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 11:45:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4TFj5U7030981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 May 2015 17:45:05 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4TFj6Zi003882;
	Fri, 29 May 2015 17:45:06 +0200
In-Reply-To: <xmqq617bflzh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 May 2015 08:21:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 May 2015 17:45:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4TFj5U7030981
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433519105.39738@7QJ6td/CrRqyUyi2fR0IHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270247>

Junio C Hamano <gitster@pobox.com> writes:

> Yeah.  I am not sure --tags-also is necessarily a good thing (I do
> not think "fetch --tags" is a good thing, either).  If --follow-tags
> does not touch lightweight ones, that may be a bug we would want to
> fix.  I did not mean to implement --follow-tags that way, and I do
> not offhand remember if there was a reason to omit lightweight ones.

It's documented to push only annotated tags both in the commit message
of c2aba15 (push: --follow-tags, 2013-03-04) and in the man page, so it
was done on purpose, but I don't know if it was a good thing.

Perhaps a justification is that annotated tags are clearly meant to be
public while lightweight tags can also be used as private bookmarks.

In any case, the fact that it's been this way and documented this way
since 2013 makes it a bit hard to change now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
