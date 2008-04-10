From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: permissions and packed-refs?
Date: Thu, 10 Apr 2008 13:30:50 +0100
Message-ID: <320075ff0804100530s2af22cc9r43208101e46a8154@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 10 14:31:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjvwH-0008Id-QD
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 14:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbYDJMax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 08:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbYDJMax
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 08:30:53 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:26028 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203AbYDJMax (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 08:30:53 -0400
Received: by mu-out-0910.google.com with SMTP id i10so4138206mue.5
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=5s9xxKDj3pBeVXQC/WyqNunh2PkXJV4+t/Fx3L1FHE4=;
        b=j4F2LQ47AGmpxEpzzLwxekYLptTDTu/pRQThD57jUhgfqirifJ39Gk+VW20bmw0MzAnO8GJO7/JHhOD5UQBfh1Xhma0krgRHZEVXfJLI9emJGJATdB64sQEOO+rUkNLDFACr+afVR80q87UoQDuD83ncEy0HQWWROd2OuqCxcSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kU5ikuWXX5CRrSUqTU4VMu01Njw7avzzjG3WOcstXIQNzgteWKbj9SVcKtKpWgumZaD52HBvDDHPqYsTnkkFs2231IQcIO6RP4LD05XQlG/4jQJMqqbwtnNxI7zB9h7OIMtKrthXGJuXOJURcx6QoZ6tP3LdV+y+TI+obSqUuMI=
Received: by 10.82.115.8 with SMTP id n8mr2151948buc.35.1207830650433;
        Thu, 10 Apr 2008 05:30:50 -0700 (PDT)
Received: by 10.82.169.1 with HTTP; Thu, 10 Apr 2008 05:30:50 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79213>

This is likely a really stupid question... a repo that was working,
has now stopped accepting a push with

Counting objects: 43, done.
Compressing objects: 100% (18/18)   Compressing objects: 100% (18/18),
done.
Writing objects: 100% (23/23)   Writing objects: 100% (23/23), 4.65 KiB,
done.
Total 23 (delta 10), reused 0 (delta 0)
error: Unable to append to logs/refs/heads/realtime: Permission denied
Pushing to ssh://10.1.3.153/pub/scm/git/git-svn/realtime.git
To ssh://10.1.3.153/pub/scm/git/git-svn/realtime.git
 ! [remote rejected] realtime -> realtime (failed to write)
error: failed to push some refs to
'ssh://10.1.3.153/pub/scm/git/git-svn/realtime.git'

I think git gc was run on the server at some point, as the head in
question has been shifted into packed-refs.

Server is linux (1.5.4.4) client is msysGit.
