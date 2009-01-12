From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 1/4] Add color_fwrite(), a function coloring each line individually
Date: Mon, 12 Jan 2009 02:27:25 +0100
Organization: At home
Message-ID: <gke69p$ms0$1@ger.gmane.org>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901112058570.3586@pacific.mpi-cbg.de> <7vwsd1o44i.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901120048430.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901120049190.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 02:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMBbr-00067x-Rn
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbZALB1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 20:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbZALB1c
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:27:32 -0500
Received: from main.gmane.org ([80.91.229.2]:43298 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbZALB1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:27:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMBaU-0008Sz-9z
	for git@vger.kernel.org; Mon, 12 Jan 2009 01:27:30 +0000
Received: from abwj90.neoplus.adsl.tpnet.pl ([83.8.233.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:27:30 +0000
Received: from jnareb by abwj90.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:27:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwj90.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105267>

Johannes Schindelin wrote:

> We have to set the color before every line and reset it before every
> newline. =A0Add a function color_fwrite() which does that for us.

color_fwrite_lines(), but I guess Junio can correct this himself.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
