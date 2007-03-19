From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 11:01:09 +0100
Organization: At home
Message-ID: <etlmro$l1s$1@sea.gmane.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <vpq8xdtpp3g.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 10:59:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTEdy-0001x8-UX
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 10:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbXCSJ63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Mar 2007 05:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbXCSJ62
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 05:58:28 -0400
Received: from main.gmane.org ([80.91.229.2]:39198 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788AbXCSJ61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 05:58:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HTEdB-0006uy-OG
	for git@vger.kernel.org; Mon, 19 Mar 2007 10:58:21 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 10:58:21 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 10:58:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42603>

Matthieu Moy wrote:

> * Create a bare repository on machine A, and clone it to a non-bare
> =A0 repo on which I'll work. But that means duplicating the repositor=
y
> =A0 on the same filesystem of the same machine. Not really satisfacto=
ry
> =A0 either. The "light checkout" feature would make it better, but I'=
m
> =A0 still worried about what will happen to my light checkout when
> =A0 someone pushes to the repository.

You can share repository object database using alternates.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
