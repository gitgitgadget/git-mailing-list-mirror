From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: Merge format documented?
Date: Mon, 23 Mar 2009 08:18:19 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903230818.20044.agruen@suse.de>
References: <200903230419.50000.agruen@suse.de> <7vtz5k99tr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 08:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LleRv-0003eh-9X
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 08:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbZCWHSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 03:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbZCWHSY
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 03:18:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38048 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbZCWHSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 03:18:23 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2E51D86EE4;
	Mon, 23 Mar 2009 08:18:20 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vtz5k99tr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114249>

On Monday, 23 March 2009 4:50:24 Junio C Hamano wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> > is the format that git normally uses for indicating merge conflicts in
> > files (the <<< === >>> markers) documented somewhere?  How exactly does
> > it differ from the diff3 format (<<< ||| === >>>)?  Diff3's -m mode seems
> > to come close to what git does, except that git doesn't produce the |||
> > section:
>
> It is an imitation of output from "merge" program of RCS suite Paul you
> know maintains ;-)

So it's the same format except that diff3's ||| section isn't shown. I was 
wondering if there are any additional tricks.

Patch should support that too, even from the more limited information it has.

> Recent versions of git supports merge.conflictstyle 
> configuration variable and --conflict option in 'git-checkout' to write
> the conflicts out in a format that is an imitation of "diff3 -m" output.
>
> As far as I know, neither "git" format is documented anywhere, but I
> didn't find an official format specification of the "upstream" formats,
> and that is why I keep saying "imitation" in the above paragraph ;-)

The diff info pages describe the diff3 format; that may be enough 
documentation:

  info -f diff -n "Marking Conflicts"

Thanks,
Andreas
