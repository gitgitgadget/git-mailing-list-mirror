From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 14:19:48 +0100
Organization: At home
Message-ID: <fijptj$a47$1@ger.gmane.org>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site> <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org> <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711281307420.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 14:20:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxMq1-0002d5-Tt
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 14:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234AbXK1NUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 08:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757266AbXK1NUG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 08:20:06 -0500
Received: from main.gmane.org ([80.91.229.2]:43684 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756317AbXK1NUF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 08:20:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IxMpX-0003rA-Qs
	for git@vger.kernel.org; Wed, 28 Nov 2007 13:19:56 +0000
Received: from abvr156.neoplus.adsl.tpnet.pl ([83.8.215.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 13:19:55 +0000
Received: from jnareb by abvr156.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 13:19:55 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvr156.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66326>

Johannes Schindelin wrote:

> @@ -52,6 +55,12 @@ do
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0esac
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0strategy_args=3D"${st=
rategy_args}-s $strategy "
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0;;
> +=A0=A0=A0=A0=A0=A0=A0-r|--r|--re|--reb|--reba|--rebas|--rebase)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rebase=3Dtrue
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0;;
> +=A0=A0=A0=A0=A0=A0=A0--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--=
no-rebase)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0rebase=3Dfalse
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0;;
> =A0=A0=A0=A0=A0=A0=A0=A0-h|--h|--he|--hel|--help)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0usage
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0;;

Hmmm... rebase doesn't use git-rev-parse --parseopt?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
