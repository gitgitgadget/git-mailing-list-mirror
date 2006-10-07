From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: prepare for repositories with packed refs.
Date: Sat, 07 Oct 2006 13:31:06 +0200
Organization: At home
Message-ID: <eg8349$2uq$2@sea.gmane.org>
References: <7vsli5pwqf.fsf@assigned-by-dhcp.cox.net> <20061006154059.GQ20017@pasky.or.cz> <7v1wpks9qf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Oct 07 13:35:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWASf-0005uw-Ae
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 13:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWJGLfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 7 Oct 2006 07:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWJGLfH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 07:35:07 -0400
Received: from main.gmane.org ([80.91.229.2]:52450 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750929AbWJGLfE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 07:35:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GWASL-0005qa-Sq
	for git@vger.kernel.org; Sat, 07 Oct 2006 13:35:01 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 13:35:01 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 13:35:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28474>

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
>=20
>> Having HEAD a dangling
>> symlink is just wrong...
>=20
> While I still disagree with this statement, as a practical
> issue, I think it might make sense to have an option to
> pack-refs to pack only tags, which are supposed to be mostly
> immutable. =A0Or even introduce --all option and make the default
> pack only tags.

+1. I was actually to asck if there is a way to pack only tags,
or perhaps even only true tags (i.e. using tag objects).

It's usually the number of tags that limits performance by being
I/O bound (for example for gitweb), and tags change rather rarely
so modyfying/adding/deleting packed ref need not to be over-optimized
for speed.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
