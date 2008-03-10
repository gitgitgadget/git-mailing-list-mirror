From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "git checkout" branch switching safety broken in 'next'
Date: Mon, 10 Mar 2008 10:29:00 +0100
Organization: At home
Message-ID: <fr2v0s$cdb$1@ger.gmane.org>
References: <7vmyp7j8ui.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 10:30:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYeKY-0000Om-C9
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 10:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbYCJJ3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 05:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbYCJJ3Y
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 05:29:24 -0400
Received: from main.gmane.org ([80.91.229.2]:39682 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbYCJJ3M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 05:29:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JYeJe-0008Oc-QL
	for git@vger.kernel.org; Mon, 10 Mar 2008 09:29:06 +0000
Received: from abwl132.neoplus.adsl.tpnet.pl ([83.8.235.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 09:29:06 +0000
Received: from jnareb by abwl132.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 09:29:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwl132.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76710>

Junio C Hamano wrote:

> Traditionally, when you have a change in the work tree, and switch to
> another branch that has different contents in the modified path, we
> errored out by saying:
>=20
> =A0 =A0 error: Entry 'foo' not uptodate. Cannot merge.

By the way, could this error message be made less cryptic? It is there
since the very beginning, and was not changed during making error
messages more user friendly...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
