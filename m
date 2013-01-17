From: Jay Vee <jvsrvcs@gmail.com>
Subject: git pull - reporting that I modified files, but I did not
Date: Thu, 17 Jan 2013 12:29:07 -0700
Message-ID: <CADq_mb-k8mP6PAsPciYEkx6fvFNdGK+ejsFEZ4nCJVcUQ6odGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 20:29:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvv9Y-0003IJ-GS
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 20:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab3AQT3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 14:29:11 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48980 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986Ab3AQT3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 14:29:10 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so4597062qaq.5
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=71QlVYxUnIolxitW9s5TfzJDyrb6Jm1aL66oHHixoeA=;
        b=TF9Z7Bktk4g7A59d678srQNI8KOrhPv7vucykLGtF0q7vTbBJP5JmVIZDkIQC9j1vk
         R8VKxYAVf1f3ThKtcvvlEXCMdAzNA1dDsta3ULUh0uzvClu51mbG3IAIA0SAAcxZ3Ak5
         hI/LI3gBXgEgeRWQ+UkHVwVA35+qlF4ZUsMdLxFJ6THdXXV0hGxxCBqe0Cc3mcArlGZD
         m9SqndA/OwtUcbneM0/DCWdd0SQWrCkZ7LdECp0d3SWGAcMzCsqJ5qGDwFcWhNeGNK9f
         CCNTFGtlntM1t4BMalE81ocstGxTdA1JUGvq80nDM4/lD4BtV9g/RPAKq+U1jYOXKyQD
         EQnw==
X-Received: by 10.229.178.101 with SMTP id bl37mr1487070qcb.131.1358450947694;
 Thu, 17 Jan 2013 11:29:07 -0800 (PST)
Received: by 10.229.75.194 with HTTP; Thu, 17 Jan 2013 11:29:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213873>

When I do a git pull, I am getting a messages that changes to local
files would be overwritten by a merge, but  I have not changed these
files locally at all, I have not opened them in my IDE.
This happens every now and then.

1) Why does this happen?

2) How do I prevent this from happening in the future?

3) How do I get out of this state so that I can do a git pull and
rebuild my code?

---
In other instances, when I do a git pull (not getting the message
above,  I will see something like:
M      src/MyClass.java      <= a file that I did not touch or modify
D       src/AnotherClass.java   <= a file that I did not delete or touch
M     src/MyModifiedClass.java   <= a file that I indeed modified for
which in the pull there are no merge conflicts.

and the pull is successful, (then I want to push my changes), but I
did not change either of the above two files

If I see the above, am I OK to push?  My thinking is that git thinks I
changed 'src/MyClass.java' and if I do a diff there are differences,
but I do not want to push because I NEVER TOUCHED THAT FILE IN ANY
WAY.

What is going on here?  Maybe this is normal and I simply do not
understand correctly.

What is happening?  I would expect to see only line items 'M' and 'D'
for files that I personally have modified and deleted.
If I push at this point, will I overwrite changes in the repo pushed
by others and muck things up?

thanks


J.V.
