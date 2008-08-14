From: "Eric Raible" <raible@gmail.com>
Subject: bash completion: 'git apply' should use 'fix' not 'strip'
Date: Thu, 14 Aug 2008 10:12:54 -0700
Message-ID: <279b37b20808141012l460e2218lbe440dfe3ee44462@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: spearce@spearce.org, "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 19:14:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTgOg-0008R6-Ug
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 19:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301AbYHNRM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 13:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbYHNRM4
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 13:12:56 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:15171 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbYHNRMz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 13:12:55 -0400
Received: by wf-out-1314.google.com with SMTP id 27so829248wfd.4
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=JLdI/5ALTTibr99eEC0bM7pLq4QD9P4TZh2Ehr/Ii5w=;
        b=WJqChCCO7DltjjER8JHjgZrKHdZF0RwG8T6bU3lUx9WPU7repZOFf1Qyde5GDS6mBm
         +fofjhgpx40DugHkn8W5mMP6CFKJGByfZquZ5kkZXd7XfBFmUdB3GY4kFRu+In6oNruL
         F9P89kHGpYEw+ENseURP2kCROwS/4G7m4k5LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=MhVsk/nZOvLsK2bvDIlsv1/uBm3ZqKPCXQ23Z0ti5ypd/7kxj3w4kqYduHf2UbCSDT
         u0ivfBLGUmH7yQgBLhaTqnTwXTD3D/YwODyD7WyFkOCXsAAd0v6AbI1Tf4pk3g94Fepl
         gFIwE4UOLnx0ry89+UDnUkrLyWYDGZUMnooMs=
Received: by 10.142.14.18 with SMTP id 18mr588431wfn.62.1218733974378;
        Thu, 14 Aug 2008 10:12:54 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Thu, 14 Aug 2008 10:12:54 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92372>

Bring completion up to date with the man page.

Signed-off-by: Eric Raible <raible@gmail.com>
---
Seems to me that this qualifies as "obviously correct"...

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 3396e35..95040bd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -501,7 +501,7 @@ __git_has_doubledash ()
       return 1
 }

-__git_whitespacelist="nowarn warn error error-all strip"
+__git_whitespacelist="nowarn warn error error-all fix"

 _git_am ()
 {
--
1.6.0.rc1.1206.gff2cf
