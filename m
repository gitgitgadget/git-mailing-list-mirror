From: "Steven E. Harris" <seh@panix.com>
Subject: Understanding git.git's branch policy
Date: Sun, 24 Jan 2010 18:34:11 -0500
Organization: SEH Labs
Message-ID: <83pr4znklo.fsf@torus.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 00:34:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZBym-0000Ul-Fn
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 00:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab0AXXel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 18:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793Ab0AXXek
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 18:34:40 -0500
Received: from lo.gmane.org ([80.91.229.12]:42405 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab0AXXek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 18:34:40 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NZByV-0000Ss-S6
	for git@vger.kernel.org; Mon, 25 Jan 2010 00:34:35 +0100
Received: from 75-144-0-121-busname-pa.hfc.comcastbusiness.net ([75.144.0.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 00:34:35 +0100
Received: from seh by 75-144-0-121-busname-pa.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 00:34:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 75-144-0-121-busname-pa.hfc.comcastbusiness.net
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (windows-nt)
Cancel-Lock: sha1:Khg1NxAjZQCREAujnhJp5Yc6sB4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137926>

Radding the maintain-git.txt document=C2=B9, there are a few points tha=
t I'm
having trouble decoding. Under "The Policy", it notes

,----
| The tips of 'master', 'maint' and 'next' branches will always
| fast-forward, to allow people to build their own customization on top
| of them.
`----

I understand that a "fast-forward merge" means that one's current HEAD
commit is an ancestor of the evolved branch's head, so that the HEAD
pointer can move forward to "catch up" without needing to combine
disparate content.

How does this relate to the prescribed use of the "master", "maint", an=
d
"next" branches? What operations or patterns does it constrain against?


=46ootnotes:=20
=C2=B9 http://kernel.org/pub/software/scm/git/docs/howto/maintain-git.t=
xt

--=20
Steven E. Harris
