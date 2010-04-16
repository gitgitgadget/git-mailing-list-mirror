From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH RFC 0/5] Patches to avoid reporting conversion changes.
Date: Fri, 16 Apr 2010 21:02:09 +0300
Organization: Private
Message-ID: <874ojbqnry.fsf@jondo.cante.net>
References: <cover.1271432034.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 20:02:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ps3-0000LG-Dg
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 20:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921Ab0DPSCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 14:02:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:41054 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757785Ab0DPSCV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 14:02:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O2prv-0000HW-VP
	for git@vger.kernel.org; Fri, 16 Apr 2010 20:02:19 +0200
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 20:02:19 +0200
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 20:02:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:7ru2FlM1O5G1fRK3NBZ54fURFYo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145089>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Jari" == Jari Aalto <jari.aalto@cante.net> writes:
>
> Jari> It would be interesting to know why not. These magic variables are hard
> Jari> to read and remember without consulting the manual pages.
>
> Because it was observed over time that the aliases were *also* hard to
> remember without consulting the manpages. :)
>
> So you were merely trading one problem for another, and since far more
> code is out there that does *not* use English than does, we agreed that
> use English was an interesting but failed experiment.

Who found out? In what study?

Honestly, that's not believable. There is no way reading the most common
alphabetic variables would not be readable over puctuation:

    $OUTPUT_AUTOFLUSH = 1;
    if ( $OS_ERROR ) ...
    if ( $EVAL_ERROR ) ...
    open(...)   or die "$ERRNO"

Versus:

    $| = 1;
    if ($?) ...
    if ($@) ...
    open(...) or die $!

It *may* be the case with exotic (seldomly used) ones, but they are even
more exotic in they short form:

     print $^V;

Eh?

    print $PERL_VERSION;

I compute sir,
Jari
