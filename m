From: Tony Sales <vinux.development@gmail.com>
Subject: I want to report a bug/anomaly in Git
Date: Tue, 11 Jan 2011 22:22:29 +0000
Message-ID: <AANLkTimt+U3oo4FaywUr86ArG8d29yWAeVYhpRkBYa_K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 11 23:22:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcmbw-0005i9-8A
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 23:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364Ab1AKWWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 17:22:32 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:54273 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab1AKWWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 17:22:31 -0500
Received: by yib18 with SMTP id 18so5884764yib.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 14:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=GTFZNNgLByusXCoxiF9diuHvTn7MsB1KGad/qeVhvV4=;
        b=QjA9pI8/udquMSb+9qldPcU5aEwqjsNCFZZtEcQXOK46LJTdZrBaCXTtqA2BXKmxvZ
         buP1tLs4JG3cTvj65FdPsd6CN55hiwLnYqo7UqhlpbB9O1dvru/lttbePO2av7fkAdDz
         RZw5PYRqTlA/Dq3CvC9zpn5a7tZ+iL5sTpjm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=UN0yUmX/DzHje9yu1LGrcpnaRqth8/KygKDvVM/yo8qy817rUiOcJaMs4oznmZ3phH
         uwLtrR7jni2wLrRZS/R6TLT9PyXNlhBsl9moGSicd81ca6x7ucDdm1pFcbGNlF/gGYaS
         /OL2/h/NTkciQikJMQ8zjwthnRMKJeHYfhnyw=
Received: by 10.100.173.20 with SMTP id v20mr112284ane.133.1294784549996; Tue,
 11 Jan 2011 14:22:29 -0800 (PST)
Received: by 10.100.4.6 with HTTP; Tue, 11 Jan 2011 14:22:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164997>

Hi, how do I report a bug/anomaly in git? I have looked on the git
website and tried to ask on the git irc on freenode but couldn't post,
even after requesting a 'voice'. The bug is that if you happen to
create a new remote branch which shares it's name with an existing
directory in the top level of the git repository, git then seems to
get confused and the: git checkout <branch> - command doesn't switch
to that branch or turn tracking on (and seems to think it was created
from origin/<branch> rather than from refs/remotes/origin/<branch>),
which it does if the branch doesn't share a name with an existing top
level directory. This can be rectified by running: git checkout
--track -b debian origin/debian - but this confused me for several
hours and it was only because I had another repository with the same
branch names, but different top level directories where the command
worked that it finally dawned on me what the problem was. I then
deleted the branch and created a new one with a differnt name and
everything worked as expected.

-- 
drbongo

Dig that crazy beat on the drums: <http://vinux.org.uk>  The best is
getting better!
