From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Making binary diffs
Date: Sun, 1 Jul 2007 15:44:24 +0930
Message-ID: <93c3eada0706302314m20616a17s762704606c881278@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 01 08:14:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4shh-0004ei-B8
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 08:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbXGAGO1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 02:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbXGAGO0
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 02:14:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:48861 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbXGAGO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 02:14:26 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1062310ugf
        for <git@vger.kernel.org>; Sat, 30 Jun 2007 23:14:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=towN2Qis2YIffJTTpBew6AEaa8G8Lo2m7x8Eqi22lucwTi1USvxiimoMRde3gBrvqUO7OIA04j0OzqL6VetPpU4Ml0lGi5npnH0aPuHQ9pKUqR4FqvgDN7WoeMC0m9vu9UoJcc4oU2Ah0aOek/5PQEtOx6MosJCG80RIgTO0NWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BAifA+MvfpgVfmiPy/wpcudOqsf1CEXmvxUE3QTImAYDtXqVm+pRYbtK/d3B0xtl8Yw7oJRzcTpM6a/PAXtd9tkgagLZRquzE1jyKxH22Fq07sVSc8McaH14p0t3SAiIR530hKor4Vk0gLqhSlUVpdC0XREGPaUn1ZW86xpwQh8=
Received: by 10.82.186.5 with SMTP id j5mr10017015buf.1183270464623;
        Sat, 30 Jun 2007 23:14:24 -0700 (PDT)
Received: by 10.82.141.14 with HTTP; Sat, 30 Jun 2007 23:14:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51278>

Hi,

"git format-patch" generates binary diffs for binary files (e.g pdfs)
in its patches,
but "git diff -p" just tells me that a binary file is different and doesn't
generate the actual diff.

Is there some switch I'm missing to tell "git diff" to generate a
binary diff on binary files?

Cheers,
Geoff Russell
