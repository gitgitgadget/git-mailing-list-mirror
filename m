From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Tue, 02 Jan 2007 21:30:21 +0100
Organization: At home
Message-ID: <enef73$467$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net> <20070102144940.GA23932@coredump.intra.peff.net> <7vps9xwd01.fsf@assigned-by-dhcp.cox.net> <20070102173410.GA25325@coredump.intra.peff.net> <7v1wmdure6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 02 21:28:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1qEh-0001Le-9a
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 21:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbXABU1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 2 Jan 2007 15:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755408AbXABU1s
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 15:27:48 -0500
Received: from main.gmane.org ([80.91.229.2]:34683 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755407AbXABU1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 15:27:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H1qES-0007Rt-VF
	for git@vger.kernel.org; Tue, 02 Jan 2007 21:27:37 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 21:27:36 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 21:27:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35812>

Junio C Hamano wrote:

> Obviously, the local names should matter more when you are doing
> local operations. =A0So if you are using mergeLocal to give a
> shorthand to "git merge" that does not explicitly say what to
> merge, the above discussion does not apply. =A0But if that is the
> case, mergeLocal should also not affect the selection of
> branches to be merged when "git pull" happens from a remote
> either.

You can always use remote =3D ".", and then remote and local branches
are the same...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
