From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Can we stage all files using "git add" command, except some
 specific files ?
Date: Tue, 27 May 2014 05:19:05 +0700
Message-ID: <CACsJy8DNLyyMoxVK0TN9YFQVHVzOMVi7vccKAYb8mdA_jpmkZQ@mail.gmail.com>
References: <8392138.j8Dle5WGbS@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 00:19:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp3FA-0001kB-29
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 00:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbaEZWTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 18:19:39 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:47127 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaEZWTg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 18:19:36 -0400
Received: by mail-qc0-f178.google.com with SMTP id l6so12941745qcy.9
        for <git@vger.kernel.org>; Mon, 26 May 2014 15:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4mPGfFz01XXyEuO4X8HdSNb2qD7szna+dUROPXFxQkU=;
        b=NiMYVbhhH0yce/zriXS8YPO/B7O9YBGeuHiygKToQuzpAUbYkLvJc6MzamgigYBc6E
         L4C7jYnZvgcsjt71evcBsh7lbddg/alCn6qwKQPlRQ9qoIBf9zQIS2PVJeIBKsSMSxH+
         psCTHreS6OESCUhVZe4sT1rZkwSFMOk3/R5nkAYsGh5dSuZTQD/3qt5KJdGaCxrHoby3
         ZuO7cbw0cfnp74Zxxgc8YDuaPwnX93YtRYy4JrH7tRRF3BO+idG04HLVBjlzLL32LL/o
         FP+x6tdK2dxhUn4/XFUH35TdHQMTV/VlKhpop64YeMUpPz4Lz2cGmkPsI+mpd8MPnguR
         zReA==
X-Received: by 10.224.24.134 with SMTP id v6mr37362615qab.88.1401142775694;
 Mon, 26 May 2014 15:19:35 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 26 May 2014 15:19:05 -0700 (PDT)
In-Reply-To: <8392138.j8Dle5WGbS@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250128>

On Tue, May 27, 2014 at 1:03 AM, Arup Rakshit
<aruprakshit@rocketmail.com> wrote:
> Now, you can see, I have staged all the files first using *git add -A*, then
> _unstaging_ those I don't want to _stage_ right now. Now can this be done, in
> the *staging* time ? I mean any way to tell `git add` command, that add all
> the files from the current directory, except some specific files. What I want
> this is, some times I have at least 30 files, whereas I want to _stage_ say, 20
> files, not the rest 10. During _staging_ can I tell *git add* the same. I used
> *git add -h*, which didn't show me any such hints about my need.


Try "git add -A :/ :!<pattern1> :!<pattern2>" which basically says add
all files in repo _except_ those that match pattern1, or pattern2... I
assume you can classify "the rest 10" because there's no way to
express "Adding all except the rest 10".
-- 
Duy
