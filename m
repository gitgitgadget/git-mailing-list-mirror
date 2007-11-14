From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-clean: consider core.excludesfile
Date: Wed, 14 Nov 2007 10:44:19 +0100
Organization: At home
Message-ID: <fheg1c$eh8$1@ger.gmane.org>
References: <30046e3b0711132340y2c503dd4laea24b9b1c79a160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 10:46:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsEpO-0000XA-EX
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 10:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbXKNJqR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 04:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbXKNJqR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 04:46:17 -0500
Received: from main.gmane.org ([80.91.229.2]:51009 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbXKNJqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 04:46:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IsEnk-0002dp-D7
	for git@vger.kernel.org; Wed, 14 Nov 2007 09:44:52 +0000
Received: from abwy6.neoplus.adsl.tpnet.pl ([83.8.248.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 09:44:52 +0000
Received: from jnareb by abwy6.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 09:44:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwy6.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64971>

shunichi fuji wrote:

> + =A0 =A0 =A0 core_excl=3D"`git-config core.excludesfile`"

  +       core_excl=3D"$(git-config core.excludesfile)"

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
