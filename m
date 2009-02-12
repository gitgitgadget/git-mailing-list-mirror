From: Chris Packham <judge.packham@gmail.com>
Subject: git am and Evoultion
Date: Fri, 13 Feb 2009 11:13:40 +1300
Message-ID: <a038bef50902121413p784c2563l8823c7dc758a73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 23:15:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjq7-0000QL-Bx
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 23:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761083AbZBLWNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 17:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760994AbZBLWNm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 17:13:42 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:60415 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761081AbZBLWNl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 17:13:41 -0500
Received: by wa-out-1112.google.com with SMTP id v33so453938wah.21
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=q5glguUxLPH7p21k9DKms5ntzGDl54LCaCVbPYTNNH4=;
        b=DdhPwP3Sirtb/UNa8sbzT8uVjgOoh4MY5a13Ws0EtDzSancafytvQUAfdLzpURI409
         FjvWaVvredGigLHNiOveMOQ8vzUitINgBd+wGjwjxyMXZQAFUDQFqxTuLFy+2V5Qt0jb
         TZXuzS2PIcrJ05LV6rGYEnHu51d84kb2fs+M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=dqTcZCDty5MbfTvJrMGrU1uy0hQRuGp63QQCvmK43lo2MimJzbb+aiHyPLuTem0YXZ
         6de6J2PdB/wjrKtjId7KqFJdcwRmFkMce4TA21nZR8bDjUpdg53lGprBIqWiMqr/5lWM
         DqhRCyobpToVZmGNr3Os/bUw134mgZxDYxI9g=
Received: by 10.114.125.18 with SMTP id x18mr565578wac.220.1234476820681; Thu, 
	12 Feb 2009 14:13:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109672>

Hi,

I want to apply patches by running git am directly on one of my Evolution mail
folders. From what I've read this should be possible. The magic incantation
I'm using is
  git am -s -i -3 ~/.evolution/mail/local/patches

I seem to be running into a problem with CRLF differences. If I run the command
mentioned above the patch fails to apply. If I extract the parts with
git mailinfo and
use git apply the patch fails.

If I use Evolution to save the file and run git am on the saved file
no problems (I'm
pretty sure Evolution is correcting the CRLF for me). Same deal if I
run git mailinfo
and dos2unix on the extracted patch.

So Is there something I'm missing here, do I need to tell git am or
git apply about the
line encoding? Do I need to tell Evolution something?  Is it safe to
run dos2unix on
an Evolution mbox?

Caveat: I'm running an old version of git (1.5.4.5). I've been putting
off upgrading
as the corporate overlords are planning a wider distro version upgrade
which would
include a newer version of git.

Thanks,
Chris
