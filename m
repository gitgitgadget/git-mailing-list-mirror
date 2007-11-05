From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull opinion
Date: Mon, 05 Nov 2007 23:28:16 +0100
Organization: At home
Message-ID: <fgo5dt$avh$1@ger.gmane.org>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 23:28:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpAR5-0006g4-5N
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbXKEW2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbXKEW2d
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:28:33 -0500
Received: from main.gmane.org ([80.91.229.2]:47694 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129AbXKEW2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:28:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IpAQh-0005cL-4D
	for git@vger.kernel.org; Mon, 05 Nov 2007 22:28:23 +0000
Received: from abvt3.neoplus.adsl.tpnet.pl ([83.8.217.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 22:28:23 +0000
Received: from jnareb by abvt3.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 22:28:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvt3.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63574>

Aghiles wrote:

> I am not sure this is the best place to write about this. Anyway,
> we just switched a couple of repositories to git (from svn) here
> at work and one thing people find annoying is a pull into
> a dirty directory. Before the "stash" feature it was even worse
> but now we can type:
>=20
> =A0 =A0 git stash
> =A0 =A0 git pull
> =A0 =A0 git stash apply
>=20
> But isn't that something we should be able to specify to the "pull"
> command ?

If I remember correctly there is/was some preliminary work (at most 'pu=
'
stages) about adding --dirty option to git-merge, git-pull and git-reba=
se.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
