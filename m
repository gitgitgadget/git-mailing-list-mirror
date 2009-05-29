From: Paul Tarjan <ptarjan@gmail.com>
Subject: Git Confusion
Date: Fri, 29 May 2009 00:43:35 -0700
Message-ID: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: yury239@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 09:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9wki-0003tH-Gb
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 09:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbZE2Hng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 03:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbZE2Hnf
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 03:43:35 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:35542 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbZE2Hnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 03:43:35 -0400
Received: by gxk10 with SMTP id 10so10124795gxk.13
        for <git@vger.kernel.org>; Fri, 29 May 2009 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=UPZGXDQj7IPrj78yZp44wWoD4+ySSlGB8858p0Rtl6M=;
        b=phsd0oNBpPs6YAkhOI46D0D5EGzEj+ArvNhZo1FxqllsbGthaoKgXuvn4o07pS07ic
         gFUG5KlyluiIMy1cDRxB2KMQ3RX+lV2oUhJPQ/b1RoZJHBwDnkZ0SUtRN/nApbDk5uXJ
         EhQiDf7waT/DtavNwDoX8A/KTc6j2Wsu/4T48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=uBPFmNFttkdIH35iOZ0jW6rEEgbFBlmV1B25khDSJKtfqu/HCFQoynbMu1fPJaZ4Mv
         qsw8siboVUln6QarPMaV8vOdYstEWLPvTTgrJtGbunu6UceuChcvjt2Hi1ZUJBUTMs1b
         GioBzrgs+9+0KohiKVm55pPEDKRb0pidxiUZM=
Received: by 10.151.134.2 with SMTP id l2mr4515831ybn.217.1243583015997; Fri, 
	29 May 2009 00:43:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120254>

Hi all,

I'm new to git and probably doing something very dumb, but I can't
seem to resolve this.

I have a remote repository and a local one. I ssh to the remote
machine, goto the repository directory (not a bare repository), edit a
file and commit it. All if fine.

I leave the remote host and go into the local git directory. Doing
"git pull origin master" says "Already up-to-date." but there is a
file I changed remotely, and I want to pull it locally!

The local repo was made with "git clone http://example.com/.git". I
have no branching (both are on master).

My way around this, is on the remote server, I do a "git push other
master", and then on the local one I do "git checkout HEAD file1" for
each file. Painful and I'm sure it is wrong.

Any ideas? How do you debug this?

Thanks
Paul
