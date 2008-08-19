From: James Pickens <jepicken@gmail.com>
Subject: Re: [RFC PATCH 0/9] Narrow/Sparse checkout round 3: "easy mode"
Date: Tue, 19 Aug 2008 21:10:03 +0000 (UTC)
Message-ID: <loom.20080819T210550-149@post.gmane.org>
References: <20080815142439.GA10609@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 23:11:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVYUB-0003jB-PW
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 23:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbYHSVKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 17:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbYHSVKX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 17:10:23 -0400
Received: from main.gmane.org ([80.91.229.2]:42689 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbYHSVKW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 17:10:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KVYT1-0007K5-K7
	for git@vger.kernel.org; Tue, 19 Aug 2008 21:10:16 +0000
Received: from fmfwpr06.fm.intel.com ([192.55.52.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 21:10:15 +0000
Received: from jepicken by fmfwpr06.fm.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 21:10:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.55.52.5 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92923>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> writ=
es:

> From user POV, we can now checkout a single file or a
> subdirectory (checking out subdirectory non-recursively is
> possible too). You may start with a narrow clone like:

Is there any reason for the change in terminology from "sparse"
to "narrow"?  I understand the difference between "partial"
and "sparse", but I can't tell if there's any difference
between "narrow" and "sparse".  If they are the same thing, then
I think "sparse" is the better term.

> Last bit. "Narrow rules" for --path|--add-path|--remove-path is
> currently wildcards separated by colons. While it does the job,
> it does not allow to checkout easily a subdirectory
> non-recusively. I was thinking about '*' as "match everything
> except slashes" and '**' as "match everything even slashes".

I like this idea - it would make this much more intuitive to use,
since '*' and '**' would work the same as they do in the
shell (for shells that support '**' at least).  I tried the patch
in it's current form, and it took me a while to figure out that
paths were non-recursive and '*' was matching everything,
including slashes.

James
