From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Question about .git/objects/info/alternates
Date: Wed, 24 Mar 2010 23:07:29 -0700
Message-ID: <1269497251-13103-1-git-send-email-judge.packham@gmail.com>
References: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com, bebarino@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 07:10:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NugGf-000584-4r
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 07:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab0CYGJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 02:09:50 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:58135 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0CYGJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 02:09:49 -0400
Received: by pzk32 with SMTP id 32so1476442pzk.4
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JzdkGXXG38wfZLrkgnOr6Vr1jhto71N99/giaU2J5eQ=;
        b=KSoER12SMBTcv8wQv1f3dHtOqYEn9cOb4PpSY8br2LlnxxbnsLutehL5M7utBHrbDv
         uKMqiWu6gWMPClA8r7v8E6x0HCKKPkYy3hCRJDcDkfazeNeoociAS9Y3+foGtSrjXfF7
         bmZC4HBNNChpSZ4Y45K2RISj2xJNFuJpTuZhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JTw1x2jJBl9eyetjDzAySkbXNzFICdVJKM+Oz6I7HlwbGeZ0/SsEejUaDqr+xTr5Ua
         RkTSvTnUJ5tHbUlWfKkUJRjheVy6phiJEaZrW9YXCHCQ0NgkjyDz/8BQiUDs83sad2QW
         PQjsn2+48rzI6UFVutc8SJU4UAdbaV8wQSkX0=
Received: by 10.140.58.10 with SMTP id g10mr6413491rva.85.1269497387786;
        Wed, 24 Mar 2010 23:09:47 -0700 (PDT)
Received: from localhost.localdomain (adsl-71-131-190-40.dsl.sntc01.pacbell.net [71.131.190.40])
        by mx.google.com with ESMTPS id 20sm650523pzk.7.2010.03.24.23.09.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 23:09:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143163>

Heres my updated patch. I think I've addressed all the comments except
Stephen's.

I've also added some tests in the 2nd patch but I'm running into a problem
where all the tests pass but the overall test fails:
  FATAL: Unexpected exit with code 0
  make: *** [t9800-git-alternate.sh] Error 1

My current TODO list is
- fix the test
- add tests for git alternate --delete
- add documentation
- refine the display output, its a bit jumbled at the moment it could be better

I'm travelling for the next couple of weeks so I may not be that quick to
respond to comments.
