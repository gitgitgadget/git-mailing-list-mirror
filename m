From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Git doesn't save capitalization change in file names.
Date: Tue, 12 Jan 2016 14:46:13 +1100
Message-ID: <CAH5451=-RkyYs3UJHUvvYHSrNODzW4dmAQDHU_Jo-Wf4Oa7Dew@mail.gmail.com>
References: <CAMkNX-K=GQ6LkZv2PS5Pfs+v2bN1ozi9P5ZN4Z60Ba-3JtuRkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Daniil S <ds98s3a@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 04:46:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIpv7-0002bt-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 04:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760449AbcALDqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 22:46:54 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:35738 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbcALDqx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 22:46:53 -0500
Received: by mail-io0-f179.google.com with SMTP id 77so339721546ioc.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 19:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0Zzjl0giNCOGNUq+TmyE1f0nI7pWZmhfltH5hmbzILI=;
        b=pQ0gh24wq3dUjy6CmocAL5Hq1KA90/geCKAj3UBG5E+NSnH5mu1ew2bvE7+6AmMz2E
         mvx5DNrtQtHZBdbgBy64UWl4wipc6x3jM25CEUxCK9l0LDSxJ2Bt6ihYCi3t6SNKZFdD
         +4PDDH3finmxQqARt1jIe7TlwGXP8LxRTrA4TLhYTxTb7eAaMZyPzMt6ntVzk+WjYaZ/
         1oXFiAxfswAL3easPGThAbLvBUtcqrJx6QTPBcxlhEnNcuruucRIUUoey9EBsBW2MO+y
         J6wvZ7t2Jrn0JRHTuMS7twBEAaHKN+NXozU2aT4WrNuJ7NQBrvHRLGs5VfrJTuHXSxuc
         Yc7Q==
X-Received: by 10.107.135.198 with SMTP id r67mr79758581ioi.103.1452570412500;
 Mon, 11 Jan 2016 19:46:52 -0800 (PST)
Received: by 10.36.72.195 with HTTP; Mon, 11 Jan 2016 19:46:13 -0800 (PST)
In-Reply-To: <CAMkNX-K=GQ6LkZv2PS5Pfs+v2bN1ozi9P5ZN4Z60Ba-3JtuRkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283763>

On 12 January 2016 at 13:06, Daniil S <ds98s3a@gmail.com> wrote:
>
> So I've now encountered this with both GitHub and BitBucket, Windows and
> Linux versions, so I'm fairly sure it's git's fault.
>
> Example: if file named "Pathfinding.java" was renamed to "PathFinding.java"
> and that change is then committed, filename won't change in repository.
>

This actually comes down to the file system you use, as git itself
does keep track of the capitalisation of file names; if the file
system is case insensitive (Mac OSX being the typical example) then
you can run into weird issues when files change case.

For example, the following two search results:

https://stackoverflow.com/questions/10523849/changing-capitalization-of-filenames-in-git

https://ocroquette.wordpress.com/2014/07/08/git-capitalization-of-file-names-and-name-conflicts/

Regards,

Andrew Ardill
