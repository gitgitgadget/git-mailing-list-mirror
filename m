From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: git-svn and logging.. new to git
Date: Wed, 5 Mar 2008 23:01:34 +1100
Message-ID: <ee77f5c20803050401o7f33522dj6dd0f0f1c0a78f96@mail.gmail.com>
References: <fqloop$ll$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 13:02:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWsKW-0001JY-5w
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 13:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933995AbYCEMBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 07:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932820AbYCEMBi
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 07:01:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:5022 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933984AbYCEMBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 07:01:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so870861rvb.1
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 04:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PMrkZSb4I9UL7+KOseWkPlTTcbHnKRBq0+FcTjDRkos=;
        b=bBWVWHW/pyNiIamM+xPxfVUdlqbkgEQu9b3jrZj/6PQ4ecrnNqRit0GczEmVeKm2Le8C/j2utW3y/eVGrAGcQw6BQ9q+lSLftPNbPyz3bRBv3n93sgYul+nuMeBBIV2ihf3A1bAIydl7DhM4OH0+42pY6vJpCrBQfxtUxSXksmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e0HclTuQ/3iT149vUPkFl87XusGWVFbv/jFVnpU9SeIi16jvgRW871nDzvQjjT0W2W6UfZRtIwx9kINvh+ZXpu7XHAu2ag+Qjb0f5RjnJoqjeQAGdy/6mKnr0ywSGz9fRY3h80gFlRfpODPkW4bMOVDpvKgvFesOnCweNnQxEcw=
Received: by 10.141.114.21 with SMTP id r21mr1159507rvm.154.1204718494893;
        Wed, 05 Mar 2008 04:01:34 -0800 (PST)
Received: by 10.140.135.17 with HTTP; Wed, 5 Mar 2008 04:01:34 -0800 (PST)
In-Reply-To: <fqloop$ll$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76212>

On Wed, Mar 5, 2008 at 8:22 PM, Kenneth P. Turvey
<kt-usenet@squeakydolphin.com> wrote:
> I'm in the process of moving to git from subversion and I've run into
>  something I just don't understand.  I've moved one project from subversion
>  using git-svnimport and that went successfully.  Unfortunately the latest
>  git doesn't include svnimport so I'm trying to do the same thing with
>  git-svn.  It seems to have worked without any problem, but when I do "git
>  log"  I don't see all the entries I see when I do "svn log" on the same
>  project in subversion.  So, now I have to ask myself, "have I lost changes
>  in the import?"
>
>  The command I used to import the source code is:
>
>   git-svn clone file:///home/kt/oldsvn/Personal/Projects/Journal \
>   --trunk=trunk --branches=branches --tags=tags

git-svn creates a whole bunch of remote branches -- does "git branch
-a" show them up?

Also, you can probably leave out the --trunk, etc., and just use --stdlayout.


Dave.
