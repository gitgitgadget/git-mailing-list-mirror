From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: The linkgit: Asciidoc macro broken (for some backends)?
Date: Thu, 04 Nov 2010 23:10:38 +0100
Message-ID: <87wrosg2ox.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 23:12:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE82Y-0005cY-QU
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab0KDWMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 18:12:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62505 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab0KDWMH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 18:12:07 -0400
Received: by bwz11 with SMTP id 11so2134075bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:user-agent
         :date:message-id:mime-version:content-type:content-transfer-encoding;
        bh=u58NMi/lpABl79FSC5+tZHofx1d7ArplFXAsnv4ahFo=;
        b=hMIncwYscQFgeCzxBZuZilalpUx8CTeWsg3UhyAviRw27AmtBtMTxxN1g4kfRXzkda
         3a3x5ORdtdPaEpcC11A1pBVuHp/NS2UhidDR/3R0dPZeULdVPf7i6Bif11v+qagTvbzN
         YGDgtdBZ+XTcLAjN5BJtsRu3RaJkW4UjaGUmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        b=aq5Rg/l+VV8hdNdzZaDVfGxA/JiZ3PhhrS6mBS0w5PqA30k7wJplRtoTlUZCoHW4Sh
         xDLyd4n2Gp/aGFGnWXjipLW+cccXeprK/sILzlvPH6O4/OHyWh3T/0trJfjFXYlTROEX
         s8bkk18CtBISNftEKeuhlQmfMGjCICQV91fjs=
Received: by 10.204.53.9 with SMTP id k9mr1181247bkg.102.1288908726098;
        Thu, 04 Nov 2010 15:12:06 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id 4sm403893bki.13.2010.11.04.15.12.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 15:12:05 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160783>


I noticed that even though all the links to gitrevisions(7) in the
documentation sources point correctly to manual section 7 (where it
belongs and is actually installed), the links are rendered in manpages
as gitrevisions(1) (cf. e.g. git-diff(1)). The fact that the online doc=
s
have gitrevisions(7) would indicate that only some backends are broken
(I can confirm the man backend at least). Could some Asciidoc wizard
have a look at the macro definition in Documentation/asciidoc.conf?

  =C5=A0t=C4=9Bp=C3=A1n
