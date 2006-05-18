From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: cvsimport weird
Date: Thu, 18 May 2006 03:00:17 +0200
Message-ID: <4fb292fa0605171800n4f041dd2l8af06d82bdbe6bff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 18 03:00:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgWsJ-0002gh-4O
	for gcvg-git@gmane.org; Thu, 18 May 2006 03:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWERBAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 21:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWERBAT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 21:00:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:27059 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751157AbWERBAT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 21:00:19 -0400
Received: by nf-out-0910.google.com with SMTP id p46so42260nfa
        for <git@vger.kernel.org>; Wed, 17 May 2006 18:00:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EfKKBZiOH8RfFhSmggLbykGYYDjedgjr1oZUYK9OXdCaqDiHwOlL2VuKkONQF5A+4QExxL54za8dW2aNVO5j+hKZDqk0aKAy6KUXq+2gRTu+SNyLKIkuzEyr7NvQ+PJnBX2jwPXJUdxJkjwxnAVUParRa8l6LtmXZohH6hENVHU=
Received: by 10.49.88.4 with SMTP id q4mr1256693nfl;
        Wed, 17 May 2006 18:00:17 -0700 (PDT)
Received: by 10.49.5.5 with HTTP; Wed, 17 May 2006 18:00:17 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20255>

Hi,

I would like to make some git-cvsimport test on a public repo. And I
get some problem and don't know if it's a remote server
(enlightenment) problem or a git-cvsimport one.

Here is the log :

/mnt/data/src/e-tmp % git-cvsimport -v
-d:pserver:anonymous@anoncvs.enlightenment.org:/var/cvs/e e17
connect error: Network is unreachable
WARNING: malformed CVS version str: Server:
WARNING: Your CVS client version:
[Client: Concurrent Versions System (CVS) 1.12.12 (client)]
and/or server version:
[Server: ]
are too old to properly support the rlog command.
This command was introduced in 1.11.1.  Cvsps
will use log instead, but PatchSet numbering
may become unstable due to pruned empty
directories.

cvs [log aborted]: end of file from server (consult above messages if any)
DONE.
Already up-to-date.
/mnt/data/src/e-tmp %

I use cvs 1.12.12, cvsps 2.1, git 1.3.3

I don't why it tell me that Network is unreachable as I can do normal
cvs checkout.

Also, I have the repo in another directory, and I don't know how to
use a :local: CVSROOT

-- 
Beber
#e.fr@freenode
