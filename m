From: "Alf Mikula" <amikula@gmail.com>
Subject: Migrating a git repository to subversion
Date: Thu, 15 May 2008 16:08:52 -0700
Message-ID: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:10:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwmaE-0007bH-Ri
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 01:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYEOXIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 19:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbYEOXIz
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 19:08:55 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:38569 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbYEOXIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 19:08:54 -0400
Received: by fk-out-0910.google.com with SMTP id 18so538651fkq.5
        for <git@vger.kernel.org>; Thu, 15 May 2008 16:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=/se4ZPD27EzaFeBCBuluWgBLR5Gm1nb1GBkG+GFqH4E=;
        b=lWEyVmE/TBDS3FPYlGpehIAwaQMiKfyM3NhKOgklCWTM5FptYl84H0aM10B8E5f3TRggEZZg4JcipF84LRXVDHWNXYLGpJIjrp3dXDCtiqcQ5FCy5q8/aCut/ihoa6T3C7BlknZu1xTQQKj3kMXbCEuGatp9QPxXVi2CB6k4Eak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DE8rovLbPhBxIOarjd8frERnfRj4GgC7lgiqdqFB+6qdYV9Aj4Bhc6+rbmGsNjdE2bU+dqEwNe93P7lsdwQhD3wRfGablfHmGoCPMfmmHfD8Q2c8XVcxbSRzWsIJlnvnTlxClwWvePvlO3FZFHXA6tQWGrchXbxjiGcQqbpF9dY=
Received: by 10.125.137.10 with SMTP id p10mr1873038mkn.6.1210892933182;
        Thu, 15 May 2008 16:08:53 -0700 (PDT)
Received: by 10.86.81.19 with HTTP; Thu, 15 May 2008 16:08:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82240>

I'm a relatively new (2 weeks) user of Git, and so far I really love
it, and I want to educate my co-workers about it.

Having said that, I want to demonstrate git's git<--->svn
capabilities, and currently everybody here has and understands
Subversion.  So, I want to initialize a Subversion repository with my
git history from my local git repository.  Here's what I tried:

1. Create a new, empty subversion project with trunk/tags/branches subdirs.
2. git svn clone http://myhost.com/path/to/project --stdlayout
3. git pull ../git_project
4. git svn dcommit


This put all my files into Subversion, but under a single commit.  Is
there a step I'm missing that would allow git to commit all my
individual git commits to the Subversion repository?  I've done a
bunch of searches, but all the docs seem to focus on cloning an
existing svn repository, as opposed to exporting git repositories to
Subversion.

Thanks in advance,

-Alf
