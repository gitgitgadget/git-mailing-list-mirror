From: david.hagood@gmail.com
Subject: git-cvsserver man page needs examples...
Date: Wed, 9 Sep 2009 11:00:59 -0500 (CDT)
Message-ID: <30413d11949449171e25338690c98885.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 18:01:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlPbc-0006Gt-H3
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 18:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbZIIQBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 12:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbZIIQBA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 12:01:00 -0400
Received: from mail-yw0-f175.google.com ([209.85.211.175]:53884 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbZIIQA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 12:00:59 -0400
Received: by ywh5 with SMTP id 5so6014125ywh.4
        for <git@vger.kernel.org>; Wed, 09 Sep 2009 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:message-id
         :date:subject:from:to:user-agent:mime-version:content-type
         :content-transfer-encoding:x-priority:importance;
        bh=eLory7TFFGIEroqYg9823G0pob5NHfNMzJddRJAmR5g=;
        b=s8a13U/0jQsusYyqVaBLRPi8zIlhYmxa/W5KTg8nMDHvyt+57Dnb+nEm5xhP8IDmk8
         Ul6Ih8++fBpT9HK9C/JIRTMY9+VSzuxpu8Xn39mblM65u4CB8DiDyCsc/LmZEIenQASr
         DtDDkwPmfl2OpAAlVL3QHeNN9SDk9WNY0bU/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:subject:from:to:user-agent:mime-version
         :content-type:content-transfer-encoding:x-priority:importance;
        b=MaX+x+BXWF1LSXwGYajtF1YOHCTopyVrLHsmKhs00o0b60tNzT5VKjuz2YrUwZDzf3
         OYU0nxF3YB40GC3imQO+cVJ55zAnA1CTteEIpLS+ceYTBg5jJTh9bfm5+gkrjitd9zzJ
         TJKfJAOuXoK7uiubjWvzrTFS+Hrext0CKmCFE=
Received: by 10.90.129.15 with SMTP id b15mr234779agd.64.1252512062750;
        Wed, 09 Sep 2009 09:01:02 -0700 (PDT)
Received: from Deathwish.hagood.sktc.net (7206-2.clr.64.71.121.34.clradsl.sktc.net [64.71.121.34])
        by mx.google.com with ESMTPS id 17sm75159agd.26.2009.09.09.09.01.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Sep 2009 09:01:02 -0700 (PDT)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 3F36EC7B81E6
	for <git@vger.kernel.org>; Wed,  9 Sep 2009 11:00:59 -0500 (CDT)
Received: from deathwish ([127.0.0.1])
        (SquirrelMail authenticated user wowbaggr)
        by localhost with HTTP;
        Wed, 9 Sep 2009 11:00:59 -0500 (CDT)
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128071>

I'm trying to work out how I can use git-cvsserver on a local repository
to allow a stupid program that only understands CVS to work.

I've looked over the man page, but it really isn't clear as to what the
command lines and settings would look like. There seems to be a lot of
assumptions in the man page that aren't spelled out, such as the
assumption that you are making a repo available to many other hosts.

There is the tantalizing hint that "you can rename git-cvsserver to cvs"
which would lead me to believe that I might just be able to point the
stupid program at git-cvsserver and be done with it, but that doesn't
really seem clear.

It also isn't clear what effect operations on the repo, such as "git
checkout", would have on the view that the CVS client sees - if any at
all.

Then there is the statement "You also need to ensure that each repository
is "bare" (without a git index file) for cvs commit to work." Does that
mean that I have to have a repository that operates differently for CVS
commit to work than a standard repository for local use?

Might I suggest that the man page either contain or point to some examples
of using git-cvsserver for different use cases, such as:

local repo and server, for stupid programs that speak CVS but not GIT.
local repo and server exporting to other workstations.

I haven't found any good examples on-line of how to achieve these goals -
just reiterations of the man pages.
