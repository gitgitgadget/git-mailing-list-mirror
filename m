From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] apply --unidiff-zero: loosen sanity checks for --unidiff=0 patches
Date: Sun, 17 Sep 2006 10:30:52 +0200
Organization: At home
Message-ID: <eej12j$36t$2@sea.gmane.org>
References: <20060915132225.12040.qmail@a0896f98af57b2.315fe32.mid.smarden.org> <7vzmcz6mrq.fsf@assigned-by-dhcp.cox.net> <7vsliq7vqr.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Sep 17 10:31:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOs3D-0007ld-Lv
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 10:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWIQIaf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 17 Sep 2006 04:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWIQIaf
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 04:30:35 -0400
Received: from main.gmane.org ([80.91.229.2]:24006 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932161AbWIQIae (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 04:30:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOs2h-0007dr-AM
	for git@vger.kernel.org; Sun, 17 Sep 2006 10:30:23 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 10:30:23 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 10:30:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27164>

Junio C Hamano wrote:

> This adds a new flag, --unified-zero, to allow bypassing these
> checks. =A0If you are in control of the patch generation process,
> you should not use --unified=3D0 patch and fix it up with this
> flag; rather you should try work with a patch with context. =A0But
> if all you have to work with is a patch without context, this
> flag may come handy as the last resort.

Doesn't -C0 option to git-apply bypass those checks?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
