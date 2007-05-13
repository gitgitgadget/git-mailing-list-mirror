From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [RFC PATCH] Rename "bury" back to "sink".
Date: Sun, 13 May 2007 11:28:23 -0700
Message-ID: <87zm48wpbs.fsf@morpheus.local>
References: <20070504224639.26133.6157.stgit@gandelf.nowhere.earth> <f1gf8i$p52$1@sea.gmane.org> <20070505201307.GE19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 13 20:28:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnIoT-0007ID-8s
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbXEMS2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757573AbXEMS2w
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:28:52 -0400
Received: from main.gmane.org ([80.91.229.2]:43744 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757542AbXEMS2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 14:28:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HnIoA-0004u1-SA
	for git@vger.kernel.org; Sun, 13 May 2007 20:28:38 +0200
Received: from adsl-71-131-20-72.dsl.sntc01.pacbell.net ([71.131.20.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 May 2007 20:28:38 +0200
Received: from davidk by adsl-71-131-20-72.dsl.sntc01.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 May 2007 20:28:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-71-131-20-72.dsl.sntc01.pacbell.net
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:5ASbm9kUQRvHZ7iy4XAjNOS92lU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47160>

Yann Dirson <ydirson@altern.org> writes:

> Side note about the "stg move" name: yes it could possible to mistake=
 it
> for "move file" (especially as we don't have "stg mv").  My current
> state of mind would be to drop add/rm/cp from stgit, and move the "st=
g
> cp" logic to a new git-cp command.  This way, stgit would just be
> about handling series of patches, with git being used for the
> working-copy.  Any opinions on this ?

=46or this reason, and others, I think "stg reorder" would be better.
Especially if you implement Karl's suggestion of reordering all
patches in an editor.

--=20
David K=C3=A5gedal
