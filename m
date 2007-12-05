From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 05 Dec 2007 12:08:03 +0100
Organization: At home
Message-ID: <fj60qj$er$1@ger.gmane.org>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org> <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 12:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzsAO-0003wV-RL
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 12:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbXLELLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 06:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbXLELLU
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 06:11:20 -0500
Received: from main.gmane.org ([80.91.229.2]:36246 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbXLELLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 06:11:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Izs9L-0007l9-Ke
	for git@vger.kernel.org; Wed, 05 Dec 2007 11:10:43 +0000
Received: from abvr161.neoplus.adsl.tpnet.pl ([83.8.215.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 11:10:43 +0000
Received: from jnareb by abvr161.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 11:10:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvr161.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67143>

Junio C Hamano wrote:

> * ns/checkout-push-pop (Wed Dec 5 07:04:06 2007 +0900) 1 commit
> =A0- git-checkout --push/--pop
>=20
> A reasonably cleanly written cute hack, and I do not see this breakin=
g
> the normal codepath, so I do not mind merging this as long as people
> find it useful.

I like it, although I probably would create and use 'pushb' and 'popb'
aliases, with analogy to 'pushd' and 'popd'.

I don't remember if there is a way to list this "branch stack"...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
