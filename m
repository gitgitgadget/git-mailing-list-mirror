From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git-commit.txt: Reword the description of git commit.
Date: Sat, 18 Apr 2009 19:11:23 +0900
Message-ID: <20090418191123.6117@nanako3.lavabit.com>
References: <1239901174-30072-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Apr 18 12:13:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv7YK-0001NW-HJ
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 12:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbZDRKMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 06:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZDRKME
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 06:12:04 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33642 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbZDRKMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 06:12:03 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 68F9411B7D4;
	Sat, 18 Apr 2009 05:12:01 -0500 (CDT)
Received: from 2162.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id WMVN330M4J9D; Sat, 18 Apr 2009 05:12:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=GaUwKbbKcneaGD0WKr95DheX3G4UprK0Ll1GwxseMYU77rvbbjv0eWx0YnLzqgsKcf7qpxqzYZ4aSdA1i3ZR+Md0bia2Ji0DQMWbC6HnJULyKM9rERjxKBNIZx2B0tL1ZO2dcQzbDBV0ctxOg/4oIgQ1ywTOBgJPIhgBbDKgnp0=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1239901174-30072-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116820>

Quoting Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> "Record changes" insists on recording the _delta_ between the parent
> commit and the new revision, which can be mis-leading, since Git is
> really snapshot-oriented. The new wording may be less misleading.
> ...
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index b5d81be..c7f728f 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -3,7 +3,7 @@ git-commit(1)
>  
>  NAME
>  ----
> -git-commit - Record changes to the repository
> +git-commit - Record a new revision in the repository

I don't think this is a good change.

When new people who don't know git yet are looking at output from git-help command in order to find what command they want to try, the original text requires them to know what "repository" means, but the new description forces them to know also what a revision is.

I also think the original text is technically more correct. git-commit
command does two things at the same time. It

1) creates a new commit object (a.k.a revision)
2) updates the HEAD pointer to the new commit object

Your new wording expresses only the first part. Because it updates the HEAD, the end user perceives the difference between the commit previously pointed by HEAD and the new commit as recorded.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
