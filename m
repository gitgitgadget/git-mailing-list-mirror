From: Federico Lucifredi <federico@canonical.com>
Subject: Git Bug report
Date: Tue, 04 Oct 2011 17:24:03 -0400
Organization: Canonical USA
Message-ID: <1317763443.17036.15.camel@skyplex>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 23:24:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBCTF-0004fR-8b
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 23:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185Ab1JDVYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 17:24:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37579 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932867Ab1JDVYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 17:24:07 -0400
Received: from [12.53.206.2] (helo=[10.12.24.178])
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <federico@canonical.com>)
	id 1RBCT6-0002iT-Tk
	for git@vger.kernel.org; Tue, 04 Oct 2011 21:24:05 +0000
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182805>

Hello Git list,
 Found a minor bug in git today - the error message reported is not
correct when trying to access a repo that is not accessible
permission-wise:

> federico@skyplex:/etc$ git log
> fatal: Not a git repository (or any of the parent directories): .git

with correct access permissions, everything works as expected.

> federico@skyplex:/etc$ sudo git log
> commit 10a1d0eefcc100a513a9dff46839cff2c4f9b5a0
> Author: root <root@skyplex>
> Date:   Mon Oct 3 16:53:33 2011 -0400
>
>    saving uncommitted changes in /etc prior to apt run
>
> commit 2abb2b397631c7f48757bbcb029ebc38e37659d6
> Author: federico <federico@skyplex>
> Date:   Mon Oct 3 16:50:16 2011 -0400
>
>    updating firefox packages next
>federico@skyplex:/etc$ 

> drwx------   8 root root      4096 2011-10-03 16:53 .git

That's it... I am not subscribed to the list, CC me in reply as needed.

Best -Federico

-- 

_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish
(Federico L. Lucifredi) - federico at canonical.com - GnuPG 0x4A73884C
