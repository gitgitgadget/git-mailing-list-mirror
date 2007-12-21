From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: git consistency and --help
Date: Fri, 21 Dec 2007 04:37:19 -0500
Message-ID: <8bd0f97a0712210137m438355e5i225dca361880951f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 10:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5eKA-0003lf-Ew
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 10:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbXLUJhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 04:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXLUJhW
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 04:37:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:22244 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbXLUJhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 04:37:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so265953rvb.1
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 01:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=QvCrzj6wkzIIDlANwAmV5Vf0Kc9knJAfcbJs7tL5zEI=;
        b=H3Mzdj49emKpLywM/HpJSB9fdn3UGscZyPOdL0hPPEHwqiT5Oe979rTo/UwZFh8EkxNbbWgxC04Z/SY3tk8NoO2HzN9UrFV0m6epbqA1sNcVYTkGkRChFWs9KbktFjqjpKQjAemfV/KLcwICQpypyODtgm6iLpzqxjC/cb4bXwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iKEZb6IZ+uhz3r+KU71cKlnfspkiXEJrdi4frGeOkDGY0uiNvs1n6KO4Hjfg4Wigqnhr2FeXViq9O+/RMT0dP/JOvcje25OSNo65BtJgRxVJUX3JbNYlKgzjlfyMhvKbsGikbSndenIOBglETSdPlekAv6VC8j0MT3t2PDJwKps=
Received: by 10.141.177.2 with SMTP id e2mr577819rvp.268.1198229839644;
        Fri, 21 Dec 2007 01:37:19 -0800 (PST)
Received: by 10.141.50.18 with HTTP; Fri, 21 Dec 2007 01:37:19 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69049>

along the lines of the different aspects of git being consistent,
shouldnt the shell scripts all be changed to call `man` ?

these call `man`:
git diff --help
git log --help
git stash --help
git rebase --help
git-diff --help
git-log --help

these show a short usage:
git-stash --help
git-rebase --help

looking at the code, it comes down to the git-sh-setup.sh file mostly ...
-mike
