From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why git-ls-tree has no --stdin option?
Date: Fri, 18 Aug 2006 19:44:54 +0200
Organization: At home
Message-ID: <ec4ual$9k8$1@sea.gmane.org>
References: <ec45ca$id8$1@sea.gmane.org> <7v7j16aqpv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Aug 18 19:45:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE8PN-0004yR-8j
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 19:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWHRRpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Aug 2006 13:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWHRRpV
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 13:45:21 -0400
Received: from main.gmane.org ([80.91.229.2]:14769 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751440AbWHRRpU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 13:45:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GE8P6-0004u4-LV
	for git@vger.kernel.org; Fri, 18 Aug 2006 19:45:08 +0200
Received: from host-81-190-24-244.torun.mm.pl ([81.190.24.244])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 19:45:08 +0200
Received: from jnareb by host-81-190-24-244.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 19:45:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-244.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25684>

Junio C Hamano wrote:

>> Also, is there a combination of options which would display only exa=
ct
>> matches to path limit, i.e. tree entry only if path is directory, an=
d file
>> (blob) entry only if path is ordinary file?
>=20
> I probably am misunderstanding the question but an empty set is
> the combination you want perhaps?
>=20
> $ git ls-tree HEAD -- t Document sha1 sha1_name.c
> 100644 blob e9eb6ce882ea92523c9a871c7581457af2dc78c5=A0=A0=A0=A0sha1_=
name.c
> 040000 tree 3fb2bfdfef59e4ed10f525ef10ad8b43b8bc459e=A0=A0=A0=A0t

Yes, thank you very much.=20

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
