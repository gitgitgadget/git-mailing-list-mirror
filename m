From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [ANNOUCNE] repo - The Multiple Git Repository Tool
Date: Wed, 22 Oct 2008 15:55:22 -0400
Message-ID: <ee2a733e0810221255u23aabef2i66d878bcbfa11816@mail.gmail.com>
References: <20081022154245.GT14786@spearce.org>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 21:56:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsjpC-0008FR-CS
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 21:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859AbYJVTzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 15:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758854AbYJVTzc
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 15:55:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:33317 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbYJVTza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 15:55:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so454586fgg.17
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xosQ9WGSAVc+ng+mje3Tcqvy7DB2ECTDgG+51RL+VUw=;
        b=PPggIre7jPKfAmj7tNYuknxk7oMVDSUGxnBN+1LUcbiszv/eq5ED05yiS4DlBR2a+w
         mklOjj7Bnce5/xLJRTrOz7Cpsk+3R9y7rxUZilfkzvAGofYVYhnXwWorCS4RVK++hfKR
         2EOVWJ0k0BUIexiJOJHOrR2dTERIcfsKJpgyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Nq/ZGphYLY94PMNoq43mANhyJzPbmNMnDMEAKg3/HCXbq2DKCGk1JmpSsKl1SK/Lpy
         NRL8Crsz/hVEx7w5iW0GrhujEyeAmhaKMU+idGtMHuSFRVyh0Ox6r1AiAQ2LTVwUbKAP
         54JOXFTqsVUDkLZlo/FwJc4UJCdMSuOwCSpho=
Received: by 10.187.238.1 with SMTP id p1mr1515844far.67.1224705322574;
        Wed, 22 Oct 2008 12:55:22 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Wed, 22 Oct 2008 12:55:22 -0700 (PDT)
In-Reply-To: <20081022154245.GT14786@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98895>

On 10/22/08, Shawn O. Pearce <spearce@spearce.org> wrote:
> My "bundle related secret project" was released yesterday by Google
>  as part of the Android open source release event.  (I've mentioned
>  it before on-list in the context of a modified "git status" output.)
>
>  Google developed two tools, repo and Gerrit, and open sourced them
>  under the Apache License:
>
>   http://android.git.kernel.org/?p=tools/repo.git
>   http://android.git.kernel.org/?p=tools/gerrit.git
>
>   git://android.git.kernel.org/tools/repo.git
>   git://android.git.kernel.org/tools/gerrit.git
>
>  repo is a Python application to bind together Git repositories,
>  something like "git submodule", except it can track a project's
>  branch rather than a specific Git commit.  repo is also able to
>  natively import a tarball or zip file and use it to initialize a
>  repository from an upstream source, then apply git based changes
>  on top of that tarball.  In other words, repo is (more or less)
>  built to manage an OS distribution, in Git.
>  [..snip..]

Are there any plans to make repo an official git command (e.g.
git-repo) or merge its functionality with git-submodule?

--Leo--
