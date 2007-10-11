From: "Patrick Doyle" <wpdster@gmail.com>
Subject: yet another workflow question...
Date: Thu, 11 Oct 2007 10:11:58 -0400
Message-ID: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 16:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifylo-0001dk-4w
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 16:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbXJKOMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 10:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbXJKOMB
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 10:12:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:19399 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbXJKOMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 10:12:00 -0400
Received: by ug-out-1314.google.com with SMTP id z38so453186ugc
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=E9xKRo/5mCxITI/pzCK3XsIfXc2dWRBtF6TE0YZfygk=;
        b=UcJQscihABm+JreYm5HOuqNHXL1KWtc0Wik+AOmx6jVuyCkTwNWq4Cb7KMpRQDZ4EU8eteQhBUXneHFqwhWk55PQUSVDkb44WldIFHMgMLP8JHVsE/h67R8MDlkN9ldj6fysAza/aH0hfIetXNpJ0TtUe46bZFowd+0c4Lfv+QA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qNUcMGIiMcv73Xu4ns8MPr2nxTfToo08oWx9bnBw1xnsne2dMDglmE5v2VrERIh4AhrrjJAPkPB16yEaYnutmZKlhYGp21VraiXxMpw1R9VzCqsaZu5CVTPF+WzLEAdS52sIlMusYSp79AoS/GUuJk8+YG2oBB0VUXURccEz5LE=
Received: by 10.78.201.15 with SMTP id y15mr1471215huf.1192111918597;
        Thu, 11 Oct 2007 07:11:58 -0700 (PDT)
Received: by 10.78.193.15 with HTTP; Thu, 11 Oct 2007 07:11:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60599>

Sorry for cluttering up the list with yet another very basic workflow
question, but I'm still struggling with finding an answer to the
burning question, "What can git do for me?"  (So far, I have come to
the conclusion that, for my simple, single developer, branchless,
linear projects, there's not much that git can do for me that any
other SCM could do for me.  It appears to have been designed to solve
problems for which I have absolutely no appreciation whatsoever. :-))

Anyway, on to basic newbie quesion #107...

I've been working on my project and I realize that I have 3-4 files
modified with two orthogonal sets of changes.  (I didn't realize this
until I said to myself -- "Self, I should really check in these files
before I go too much further down this path".)  So I start "git
diff"-ing the files and I find that most files have differences
related to only one change or the other, but one file has differences
related to both changes.

What do others do in this situation?
a) Not allow themselves to get into this situation in the first place
by careful planning?

b) Copy the file to "file.bothchanges", edit out one set of changes,
commit that with one log message, edit back in the other set of
changes, edit in the other set of changes, commit that with another
log message?

c) Use some sort of automation to do option (b) for them?

d) Something else?

--wpd
