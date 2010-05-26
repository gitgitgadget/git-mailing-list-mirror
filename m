From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: Migrate from svn to git
Date: Wed, 26 May 2010 10:26:04 -0600
Message-ID: <AANLkTinTYWQflbvlWVjDKD3gtOyQxDrSZ7QKhy4eI77_@mail.gmail.com>
References: <4BFD3AAF.4080403@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Wed May 26 18:26:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHJR9-0000md-JT
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 18:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab0EZQ00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 12:26:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40321 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab0EZQ0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 12:26:25 -0400
Received: by gwaa12 with SMTP id a12so1004490gwa.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=qszQqA7n8wVGZowAyWQF261GvTTBbrIu5M39s7s1o/Q=;
        b=pm4SBa2AkKXqMVhxsH9WMtLhAQa9jwL+M7p6SOxoNRulAYb5ytuz6hcMjxaauOY150
         1DEWXg5cPbL7LRVzE71AJhxTFgA9vwerSnuFm0pJuzLbKOWFohUHFZHdDz77VCOFuABf
         2QM3MDbzWMry98YXE0cbEMwNfF+h18dTdmmJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=daj8tcGmYbpuD0FhU3dJpe1kFJf5VieliDcNgMTZmKNxmLn6kD9941E52ApFhJaBui
         ul0e/BXaf+5r4u5QjzXiAxnkfNJ65uch8rKnv3IrjYElIgd0ekotvwo7wCBzKhZa3HKg
         2i11V0eZBrZ2JqAn8msxZ7DzL/z/JY6amhzF0=
Received: by 10.90.6.8 with SMTP id 8mr4019014agf.68.1274891184167; Wed, 26 
	May 2010 09:26:24 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Wed, 26 May 2010 09:26:04 -0700 (PDT)
In-Reply-To: <4BFD3AAF.4080403@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147811>

> Corrently the svn repo is divided into trunk branches and tags.
> In each of this directory like trunk i have directories like hardware,
> software, docu and more.
>
> For each of this subdirectories I have usergroups defined which has no
> access, read access or rw access.
>
> If I understood the manual correctly I can stick on that structure and
> easily work here with the unix-permission to grant access to the folders?
> I think I have to test then acl with freebsd to have more then one group for
> each directory.

As far as I know, git doesn't track permissions (except for the execute bit).

>
>
> The second question is, I someone commits some files with svn an email is
> sent to a svn-commit mailinglist so changes can easily be discussed.
> The current mail is sent in html format with a colored diff, so it is easier
> to read.
>
> Is something similar possible with git or do you suggest a complete
> approach?

I've seen it done, e.g. xfce4-commits mailing list.
http://foo-projects.org/pipermail/xfce4-commits/
