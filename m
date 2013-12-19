From: Eric Andrew Lewis <eric.andrew.lewis@gmail.com>
Subject: [Feature Request] Did you mean `git ...`? should ask user for
 feedback, not return to the prompt
Date: Thu, 19 Dec 2013 17:38:56 -0500
Message-ID: <CAMi+fEnVekrWYrG6sGiRPmOXxaJ1-Y9xd83W7Wvw3GwWz8DuBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 19 23:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtmNb-0002mw-To
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 23:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822Ab3LSWrj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Dec 2013 17:47:39 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:52651 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab3LSWrj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Dec 2013 17:47:39 -0500
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2013 17:47:39 EST
Received: by mail-ig0-f182.google.com with SMTP id c10so5384155igq.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 14:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=io8j9XH2TW5QAJG7OP0fLnO2QJCOBDVPyT3tBhcZf8o=;
        b=Du2PrTQtdu25zwPQv3hmR6WvBt9Ik+tLDrB3z/i+4DRDprTyNivgplTcxJv8FJ538V
         NoJOnzTksfTxO3rty5jPHr6gvTdRNTPYifitUZeY8ZGjvhnNy9cg9S6O9LapmDKLj+nz
         /5zK2dtRuwBsMkxUKvvsCf+U6V9349c/XoJDWB6eGqOLYkZNdcsdqL3fLKE5ES4rrQuw
         J2ApZkIfmXR7+yhccyKClrRVoxUKn5Jrc4RClBJew8B1x+4JtQJPKHnqu+GBxfIZyCIO
         Ut42mx+Mbuzjhay3GRVa2pAWZa4ifj0g1TdXLuOAGfnOW5xD87aqZcyGBPMRxoE4GTlJ
         2W+g==
X-Received: by 10.50.153.50 with SMTP id vd18mr5157456igb.6.1387492776166;
 Thu, 19 Dec 2013 14:39:36 -0800 (PST)
Received: by 10.43.133.7 with HTTP; Thu, 19 Dec 2013 14:38:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239550>

Git is smart enough to realize when you make a spelling error and
enter a non-existent git command. Since you probably do mean what it
suggests, it follows that the user would want to immediately say =93yes=
,
I did want to do that,=94 rather than return to the command line to
enter the command again.

e.g.

$ git psh
git: 'psh' is not a git command. See 'git =97help'.
Did you mean 'push'[y/n]?

--
Eric Andrew Lewis
