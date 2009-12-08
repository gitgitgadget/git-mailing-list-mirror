From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] t7508-status: test all modes with color
Date: Tue, 08 Dec 2009 12:10:58 +0100
Organization: At home
Message-ID: <hflc82$sf8$1@ger.gmane.org>
References: <cover.1260266027.git.git@drmicha.warpmail.net> <39211ecec866882503d1188d359e1183341faeb1.1260266027.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 12:11:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHxyc-00081o-Np
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 12:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbZLHLLT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 06:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbZLHLLS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 06:11:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:49039 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753867AbZLHLLS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 06:11:18 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NHxyS-0007xL-N9
	for git@vger.kernel.org; Tue, 08 Dec 2009 12:11:20 +0100
Received: from abwp196.neoplus.adsl.tpnet.pl ([83.8.239.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 12:11:20 +0100
Received: from jnareb by abwp196.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 12:11:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwp196.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134854>

Michael J Gruber wrote:

> +decrypt_color () {
> +=A0=A0=A0=A0=A0=A0=A0sed \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-e 's/.\[1m/<WHITE>/g' =
\
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-e 's/.\[31m/<RED>/g' \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-e 's/.\[32m/<GREEN>/g'=
 \
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-e 's/.\[34m/<BLUE>/g' =
\
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-e 's/.\[m/<RESET>/g'
> +}

Shouldn't this be better in test-lib.sh, or some common lib=20
(lib-color.sh or color-lib.sh; we are unfortunately a bit inconsistent
in naming here)?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
