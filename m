From: david.hagood@gmail.com
Subject: Tie a CVS-aware app into GIT?
Date: Wed, 12 Aug 2009 13:01:45 -0500 (CDT)
Message-ID: <b988339dcd1bf764f0da46db763552d8.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 20:07:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbIEW-0006N0-8k
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 20:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbZHLSGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 14:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbZHLSGx
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 14:06:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:38081 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbZHLSGx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 14:06:53 -0400
Received: by rv-out-0506.google.com with SMTP id f6so65941rvb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:message-id
         :date:subject:from:to:user-agent:mime-version:content-type
         :content-transfer-encoding:x-priority:importance;
        bh=G91/zBPsDOehfFuIZDIzoyFOh9Gmfat2WjDGvZv+5ic=;
        b=Sa9WuoWemAQ4BjND1CKwqtp6jG9Ttrhds1WFNY8eKLkhg17TuS7OO6VgTYcrgvcx25
         kzFZ7wCEogCqUvQE7m8yq1RZLjTei6h9LZtnGZHNHK2srdYHRjo7LhznGifU9P2LGdVl
         lCRpSkokzZTJH9cAlvLtnOOfs78gnchAwr6d0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:subject:from:to:user-agent:mime-version
         :content-type:content-transfer-encoding:x-priority:importance;
        b=NvW6oYv0UUcaUoL4aBgNzNEPJvgA7ALH4riC+UaLCRss0WbLKHaTBAQM6136B/a/bq
         y6VACSWyD4qUM6/lVR6AHVKd6vCbjHarqI1QTD0FbxLyVAgAraOGzbzPoko+hFgN11+Z
         SST99NJs1SUBCqOz4TH8B+ThOEVB+D5JbPJBI=
Received: by 10.140.144.14 with SMTP id r14mr159779rvd.60.1250100110101;
        Wed, 12 Aug 2009 11:01:50 -0700 (PDT)
Received: from Deathwish.hagood.sktc.net (7206-2.clr.64.71.121.34.clradsl.sktc.net [64.71.121.34])
        by mx.google.com with ESMTPS id f42sm8182770rvb.35.2009.08.12.11.01.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 11:01:48 -0700 (PDT)
Received: from localhost (Deathwish [127.0.0.1])
	by Deathwish.hagood.sktc.net (Postfix) with ESMTP id 48C48C7B81E6
	for <git@vger.kernel.org>; Wed, 12 Aug 2009 13:01:45 -0500 (CDT)
Received: from deathwish ([127.0.0.1])
        (SquirrelMail authenticated user wowbaggr)
        by localhost with HTTP;
        Wed, 12 Aug 2009 13:01:45 -0500 (CDT)
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125722>

I have an application (closed source, unfortunately) that can use CVS to
manage its files (specifically, Enterprise Architect by Sparx).

I'd rather use GIT to manage the files, but EA doesn't "speak" git - just
CVS and Subversion (and Microsoft's SCC protocol, but...)

Are there any programs which
1) accept the same command line parameters as CVS or Subversion
and
2) access a GIT repository.

git-svn is almost exactly NOT what I need, as it accepts "git" type
command line parameters and access a SVN repo, rather than accepting SVN
command line parameters and accessing a GIT repo.

Now, obviously, such a tool wouldn't have access to all the things that
GIT can do, and that is NOT what I am expecting - what I want is just to
enable EA to do the things it needs to do, namely adding/removing/moving
files from a repo. Branching, commits, and so on can be done manually.

I've thought about git-cvsserver as a solution, but I don't know if it can
be run on a local machine to access a local repository.

I'd appreciate any help on this.
