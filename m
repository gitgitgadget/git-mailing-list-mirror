From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 16:07:13 +0530
Message-ID: <CAMK1S_i7WjrZ=L_LVoTQriW8kKMPd+ABrgowpFCY3ks43E6K7A@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 12:38:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvQss-0000bE-6B
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 12:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab2G2KhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 06:37:17 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39250 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751374Ab2G2KhP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 06:37:15 -0400
Received: by lahd3 with SMTP id d3so2951712lah.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=c948MxbNib6KY/b9nDJAKU5CafwUArjG9BqONUO+bdM=;
        b=w/4EyqdpLU73l26EQ6ycx3r/NeeZCI5DEIkkRHVv871VLixrB6pIEBvY46tjg9jYze
         Cv6xERU+GDRY+WDYdqj3gTZCN4SgKuwt30zt21SMkbYixy4H+eR4JpXudVmwTJpsq+lW
         Wu3NJkX2wCoFsfB6zmzs9Z5M3h0uDoqWgKWLNYifqhBX7yZ0I8/eT9wkm8S7ZKPnjtyP
         qjW7QLmm41al/V6FIzNypSAgFtjnkACs9NS1RDOQShAy65DjLJzfnanGJLnbo0RNm1Lz
         9ohNWXzzVdD2SNhetPRS67grvEe39f4/wCDSYFFfg4OT3Ks6kyIhUcix/jNpg7L03avP
         v8ig==
Received: by 10.112.103.135 with SMTP id fw7mr3809806lbb.25.1343558233927;
 Sun, 29 Jul 2012 03:37:13 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Sun, 29 Jul 2012 03:37:13 -0700 (PDT)
In-Reply-To: <20120728214116.GA3591@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202475>

On Sun, Jul 29, 2012 at 3:11 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> Hi,
> sometimes git communicates with something that's not git on the other
> side (gitolite and github for example).
>
> Sometimes the server wants to communicate directly to the git user.
>
> git isn't really designed for this. gitolite solves this by do user
> interaction on STDERR instead. The bad thing about this is that it can
> only be one-direction communication, for example error messages.
>
> If git would allow for the user to interact direct with the server, a
> lot of cool and and userfriendly features could be developed.
>
> For example:
> gitolite has something called wild repos[1]. The management is
> cumbersome and if you misspell when you clone a repo you might instead
> create a new repo.

For the record, although it cannot do the yes/no part, if you want to
disable auto-creation on a fetch/clone (read operation) it's trivial
to add a "PRE_CREATE" trigger to do that.
