From: David Aguilar <davvid@gmail.com>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Tue, 24 Sep 2013 19:51:14 -0700
Message-ID: <CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jona Christopher Sahnwaldt <jc@sahnwaldt.de>
X-From: git-owner@vger.kernel.org Wed Sep 25 04:51:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOfCN-00014W-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 04:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab3IYCvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 22:51:15 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43907 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab3IYCvP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 22:51:15 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so5809992pab.36
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 19:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GDPlp6U2Z2lkiFvaKH06Al0nWYAQ6SWV21of5q+N4Qc=;
        b=RH6kzDFH2A7PX4qw6hLu+75t44PDYWcXIZ8jX2+LYH/hKVC/F/jWi03rt2KtGV/dC4
         7eHb8HYLxZ6csUKr4BrId+rMp0DFqmOhr2XmStfcvytSf0d6zHD/G2AsOkrC/EpwSIWt
         teF17GxCPLAYXE6VHuFSjzLG3g3ppB3GS6IIVC6hVPFPvYLKPCpJgFPOwVBjiDkEAnNx
         HblCpo3IZ+q4sL354APX5kl0AJmY+QN59m4iSjYp+tmr+QlwlB8OX3vfvXxb7Aj+Rk09
         3uUtm+wJTzZzg2pBPon0kCyPZ4azzbUO4OumchCg8cMoO9kNsB27swkyGhLxMyve8DaB
         WOGA==
X-Received: by 10.66.142.132 with SMTP id rw4mr32020967pab.6.1380077474697;
 Tue, 24 Sep 2013 19:51:14 -0700 (PDT)
Received: by 10.70.102.45 with HTTP; Tue, 24 Sep 2013 19:51:14 -0700 (PDT)
In-Reply-To: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235329>

On Tue, Sep 24, 2013 at 2:07 PM, Jona Christopher Sahnwaldt
<jc@sahnwaldt.de> wrote:
> Hi,
>
> maybe this has already been reported, but I didn't find it in the mail archive.
>
> If I understand correctly, after I clone a repo, I should be able to
> switch to branch foo just by running
>
> git checkout foo
>
> This doesn't seem to work if a folder called "foo" exists in the root
> of the repo.

git checkout foo --

The double-dash at the end disambiguates between refs and paths.

You can use that trick on any command that accepts refspec (branches,
tags, etc) and pathspec (path patterns).
-- 
David
