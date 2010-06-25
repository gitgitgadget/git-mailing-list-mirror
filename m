From: Bartosz Wiklak <bwiklak@gmail.com>
Subject: Maintaing database schemas using GIT
Date: Fri, 25 Jun 2010 14:56:59 +0200
Message-ID: <AANLkTind3ZYRb3NqrO8a9Lg06_Vt2crWP7yKX2bKYorx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 25 15:02:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS8Xv-000628-VS
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 15:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab0FYM5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 08:57:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63667 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab0FYM5C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 08:57:02 -0400
Received: by bwz7 with SMTP id 7so692700bwz.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=GzL9Re3aZE6GEd5Hj1XGNepGo9evoeIjk7ZsjsEYHJ4=;
        b=c46w1R6mBCj1znqxfbpFut5ieLJbj3zt2XdtAe2rEMWHLotUhyfba6eyiqz6wUJJic
         5nKL8EN1cwILoWhGb2XCFOCVdM9lyr0Gd9PMbKc6aG6TA4FGkcNUKxkUWNVelPX5kfgB
         A+hOPE0dhh/JXuS3MjCR0WZR8b9pINqepj0Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=VsdZfC0zkJansNlHPWZd1AEyYoPZgz3yHe2d/tKRAVJRBkRg7F3t64rYqDfXj3UvqZ
         Cb6KvavgxRcyAzARxv2hLz+Wu1NQFy0JQXb2sQe+40n2tbUhc3S11c7JyJmSgNF5hZ51
         QAiTPJuiaQ1ZShiQKwT8CC+RU4sSF6UBeg4qs=
Received: by 10.204.175.12 with SMTP id v12mr473792bkz.174.1277470619273; Fri, 
	25 Jun 2010 05:56:59 -0700 (PDT)
Received: by 10.204.52.199 with HTTP; Fri, 25 Jun 2010 05:56:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149680>

Hi,

I am interested in maintaing database schemas using GIT. I found very
promising tool apgdiff http://apgdiff.sourceforge.net/ that I believe
can be used to manage other databases than postrgresql.

My problem is:

How to make git process sql dumps differently then other text and
binary files - apply apgdiff to them and eventually provide some merge
functionality?
Is this possible? Is this sensible rational?

What do you think?
Thanks,
Bartek
