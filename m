From: Michael Menegakis <arxeio@gmail.com>
Subject: git-gui appears to not respect Windows 7 settings on Display Language.
Date: Sun, 31 Oct 2010 21:53:37 +0200
Message-ID: <AANLkTin6jP0N4gbiNU3=h0eYrYSOj-e65JfWS5tf1iSd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 20:54:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCdz1-0005Pl-8J
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 20:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab0JaTxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 15:53:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32810 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab0JaTxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 15:53:38 -0400
Received: by iwn10 with SMTP id 10so6176041iwn.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=sUTsc70Vcdae9TYQ/tdT/BW0/AE4TlZPTNFcRDVzlaw=;
        b=P9YxBsSPsgl841eggzMHtcrOjAGxifvyNcnomjT1SRHNYmXkRo+YQhjG58te9eOt5H
         mA4+adwBetNOzGWXMcTkE9idZVPeSKWOJzXcuMeuSv8i/AZeK3UFp0wSQroFF9oUnpIy
         heXCfnCE0IoVNPJk71XFhPpX0ts/cTo0xB1GU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=KBKv1b9GWTo1LJ9H/gp/bFx3s/7B+i2Tpm8bH0yEdwwJAtdMAf2Lmrqqt+rv2iWjC5
         emk1+4jW/LbnfpAbONDKE+Xoz6oDLCU4NMiGS8LCux1AULqf5Ox79HAer8jMZ/DgVDu9
         TBqQibN4ouhRtvPfZLBvnx0ipAx+gNfeqbd+Y=
Received: by 10.231.173.7 with SMTP id n7mr6291107ibz.135.1288554818035; Sun,
 31 Oct 2010 12:53:38 -0700 (PDT)
Received: by 10.231.173.17 with HTTP; Sun, 31 Oct 2010 12:53:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160447>

For some unknown sorcery Microsoft does not refer to 'Locale' the same
as UNIX. There is only a display-characters method, only if a
character set is not unicode. For actual display of language they have
now on 7 a package downloading mechanism to have the whole system show
a language.

On 7 right now I have locale on Greek so that any non-unicode programs
will work with that. But the display language is English and no Greek
or other non-English package has been installed. The location is also
Greece but that doesn't affect other programs either.

In general these settings make almost all programs to display English
by default. Only a minority like git-gui don't.
