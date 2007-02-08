From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG] Empty reflogs and "git log -g"
Date: Thu, 08 Feb 2007 20:37:44 +0100
Organization: At home
Message-ID: <eqfu36$lb3$1@sea.gmane.org>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com> <Pine.LNX.4.63.0702082021210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 20:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFF5D-0001uU-5x
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 20:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423271AbXBHTge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Feb 2007 14:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423274AbXBHTgd
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 14:36:33 -0500
Received: from main.gmane.org ([80.91.229.2]:38137 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423271AbXBHTgd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 14:36:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFF49-0003Tz-JW
	for git@vger.kernel.org; Thu, 08 Feb 2007 20:36:21 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 20:36:21 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 20:36:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39078>

Johannes Schindelin wrote:

> On Thu, 8 Feb 2007, Santi B=E9jar wrote:
>=20
>>  when a reflog entry do not have a reflog message the refs@{num} syn=
tax=20
>> gives a different result than with 'git log -g'. Actually 'git log -=
g'=20
>> just skips this ref.
>=20
> I could be that some older git version produces empty messages. But I=
'd=20
> regard the empty messages to be the problem. Or is the current Git ve=
rsion=20
> still producing such entries?

StGIT used to produce no reflog messages; I don't know if this has impr=
oved.
But you can have old reflog entries with empty messages; git log -g sho=
uld
deal with them IMHO.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
