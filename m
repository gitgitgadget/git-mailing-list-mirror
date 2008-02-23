From: "Adam Mercer" <ramercer@gmail.com>
Subject: Setting SVN properties with git-svn, and removing empty directories
Date: Sat, 23 Feb 2008 12:38:03 -0500
Message-ID: <799406d60802230938s559168f8lc9b1f640f2c07fee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 18:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSyKj-00028r-Q4
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 18:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbYBWRiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 12:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbYBWRiJ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 12:38:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:11606 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYBWRiG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 12:38:06 -0500
Received: by nf-out-0910.google.com with SMTP id g13so439464nfb.21
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 09:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=aDzMywCwUTtFDAKkBM+/SeYWThJP0llnivjf+vZABzA=;
        b=SLhJXvNPpRHrUGSknstNlN0xuJ3vNKC7WSKUqt1nSKAGZqZBOQefcjIPtPBze5AUX7Xk0gC62BqB446b6CSz2yZ8+jSQJCbjJ7HCB3uj1LBbBu/jUQy13jVN239ygxWj4q42C1KydMTGP0lbbodEbEBuvFXwIiw9pq0968s0lNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GDUWWPNwurmsJU8vFS6oahRI4yFKHYnwyLGegE5I+lwhfLRxT1Vb924hjI3jA2/Qket+uhOuY0I5ESNtb7n816CjHpJZcOUb5GbtJR8CYGsl/jDqlDRz1DK4p2LUFD5tTR+ek0XhKB8Tfhy9ABLIrfjzvVaxwON7tEHXuU89JY4=
Received: by 10.142.79.15 with SMTP id c15mr501417wfb.105.1203788283029;
        Sat, 23 Feb 2008 09:38:03 -0800 (PST)
Received: by 10.143.174.2 with HTTP; Sat, 23 Feb 2008 09:38:03 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74830>

Hi

I want to start using git to track the upstream svn repository of a
project I work on but am running into a couple of problems that I need
to resolve before I can do this.

1) Is there a way that I can set, or modify, svn properties of files,
for example svn:keywords or svn:eol-style using git-svn?

2) Whenever I delete a directory using git-svn and merge my changes to
the upstream svn repository using "git svn dcommit" the directories in
question are removed from the git repository but only the contents of
these directories are removed from the svn repository, the directories
themselves remain. Is there a way to ensure that these directories are
removed from the svn repository?

Cheers

Adam
