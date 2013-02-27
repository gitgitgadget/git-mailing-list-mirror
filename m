From: Johan Herland <johan@herland.net>
Subject: Re: Git Notes - Search Functionality
Date: Wed, 27 Feb 2013 16:44:59 +0100
Message-ID: <CALKQrgdStAva7j8dFM3_Yn9YgPkXyNVqdfk72eicc6QUGCaaDw@mail.gmail.com>
References: <CAFZnXLJCiq4G+_ZStWmjAGePWCD6mhske7Y4=oe2h==F0BYVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: krishna chaitanya kurnala <kkc4al@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 17:23:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAjn8-00088g-K1
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 17:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821Ab3B0QXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 11:23:12 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:65449 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab3B0QXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 11:23:11 -0500
X-Greylist: delayed 2286 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2013 11:23:10 EST
Received: from mail-oa0-f48.google.com ([209.85.219.48])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UAjBn-000EaC-6i
	for git@vger.kernel.org; Wed, 27 Feb 2013 16:45:03 +0100
Received: by mail-oa0-f48.google.com with SMTP id j1so1423405oag.21
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 07:44:59 -0800 (PST)
X-Received: by 10.182.164.8 with SMTP id ym8mr2538298obb.68.1361979899488;
 Wed, 27 Feb 2013 07:44:59 -0800 (PST)
Received: by 10.182.231.68 with HTTP; Wed, 27 Feb 2013 07:44:59 -0800 (PST)
In-Reply-To: <CAFZnXLJCiq4G+_ZStWmjAGePWCD6mhske7Y4=oe2h==F0BYVLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217218>

On Wed, Feb 27, 2013 at 4:34 PM, krishna chaitanya kurnala
<kkc4al@gmail.com> wrote:
> Hello All
>
>    I working on Git Notes. I want to know if there is an easy way to
> obtain a list of all "namespaces"(For eg., git notes --ref=namespace
> ... ) with notes objects in a specific git repository.

The notes namespaces are stored as regular refs under refs/notes/*.
Here's one way to list the available namespaces:

  git for-each-ref refs/notes/


Hope this helps,

...Johan

> We can easily
> create, edit, merge git notes with commands if we know the namespaces
> and/or the sha. But, for example, Has anyone tried to search for a
> string in a git notes objects for that project etc?
>   The closest i can think of is using some options with git logs, for
> example, git log --show-notes=*  --format="%H %N" etc.
>
> Appreciate your time.
>
> thanks
> Krishna Chaitanya
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Johan Herland, <johan@herland.net>
www.herland.net
