From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Tue, 4 Mar 2008 21:47:14 +0100
Message-ID: <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com>
References: <20080304051149.GS8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 21:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWe3I-0002p4-II
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 21:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbYCDUrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 15:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbYCDUrT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 15:47:19 -0500
Received: from gv-out-0910.google.com ([216.239.58.190]:53096 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYCDUrS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 15:47:18 -0500
Received: by gv-out-0910.google.com with SMTP id s4so737109gve.37
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 12:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8P4X18tgdBM6uUSS2dDo9Q3o97DiY2d56BLPIkNRqxU=;
        b=Eo4aghiYIRyLgyZF8RXb2x0j+sEwXeOzyZ5VFW42DhEOdZ1NWWVY0mlUrS5/+bxU8hLIBwru+JSV1Sh/OKMOzomfbq98L9HVKK6Lv9ksFXGK90kl4VvZ7SdioCWPDyqWSPo++PT+vhZeuzXzOS/aWnYwtIF3wzSzxnNMbapXupE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hBaq4+IotAfivDXGFLTOSPyE2fpmLvL7pVbBZh6ok2kYfsTv9LlzMHSGFr54O1uPJPnHwlDnFsuM3ULMACdeKICfezLnG3/O908Snd2FnvEb95JGyt3pMySQI/UV2vwgge4A8k4YSa1vO9sIXBRacALk40AE9llnngsIji4ZZ48=
Received: by 10.142.125.5 with SMTP id x5mr608499wfc.124.1204663634643;
        Tue, 04 Mar 2008 12:47:14 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Tue, 4 Mar 2008 12:47:14 -0800 (PST)
In-Reply-To: <20080304051149.GS8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76136>

On Tue, Mar 4, 2008 at 6:11 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
>  OK, enough, onto the project list!
>
>   http://git.or.cz/gitwiki/SoC2008Ideas

Gitster talked today about libification as a project for the GSoC
(I mangled some comments, I accept complaints):

gitster> For the record, i've never said I am not interested in libification.

gitster> However.

gitster> (1) I know of many places whose design is based on
run-once-and-exit, and that was done for very good reasons (simpler
clean-up, no risk of reusing stale data, simpler codepath in general),
and

cehteh> gitster: yes anyone is interested .. i rather meant it would
be nice if you and others make it primary concern for accepting
patches/future development imo .. but well yes still your decision,
just a mild critic

* cehteh currently uses libgit and doesnt really feel comfortable with it

gitster> (2) cleaning up to make functions re-entrant can happen
incrementally, but should not have horrible performance issues for
run-once-and-exit users  --- see what we did to libify merge_base(),
for example, as that one is done the right way;

cehteh> yes

cehteh> we could even #ifdef LIBGIT or such for cleanup/reentrancy
stuff .. but someone has to lead supervise that, and others shouldent
throw bricks in the way which still sometimes happens

gitster> (3) and I know it would be a very large effort to do it all,
so a project that can be described with an umbrella "libification"
name would exceed GSoC size.

gitster> (4) and "should not" list in (2) includes maintainability.
Mindless #ifdefs are out.

gitster> So, I would not oppose it, but I just warn anybody that this
is a long term subproject.  I won't have time to commit myself on it,
unless everybody will be happy not to see any new developments merged
outside libification, that is.

gitster> So "libify merge-base" would have been a focused and well
defined subproject of GSoC size.  "libification" is not.

cehteh> ack

gitster> So was "libify the active_cache[] access".

gitster> "rewrite git-submodule, put the repository for submodules in
the superproject $GIT_DIR/modules, and use .git-file (currently in
'pu') to point at it", would be a good sized one.

gitster> "refine diffcore-rename to add a postprocessing phase so that
if we find rename from i386/foo.c to x86/foo.c but i386/bar.c was
rewritten too much and did not match new x86/bar.c make them match"
would be a good one as well.  Throw in "refine diffcore-rename further
so that it can tell a whole directory movement by summarizing the
constituent files' movement" and you will get a gold star ;-)

gitster> "teach 3-way fallback logic git-am has to git-apply".

....
