From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Update on SoC proposal: git-remote-svn
Date: Tue, 13 Apr 2010 18:01:55 +0200
Message-ID: <l2yfabb9a1e1004130901z19db3392kbbd4d975a5d439f7@mail.gmail.com>
References: <1271136573-sup-5613@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sam Vilain <sam@vilain.net>,
	David Michael Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 18:02:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1iZD-0008SK-ME
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 18:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab0DMQCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 12:02:16 -0400
Received: from mail-qy0-f201.google.com ([209.85.221.201]:43226 "EHLO
	mail-qy0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab0DMQCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 12:02:16 -0400
Received: by qyk39 with SMTP id 39so6380323qyk.24
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=j+G9b1O8/Ja7RSamisQqUXXiK7zAOYQNSaut1nT9ZIE=;
        b=Lg3hwtRI2egi1zIsnID68QnuWFj8K+tLXJF6kOrc3EbcYHcI7VpzSGDNG13QgoNkJA
         2MyLiJc99zTLLkuuPSU2uY4pQN94vWgyeO7mDqpZLoONKkQmtSZ1S+2gkW7qRhIV7q89
         B1HifReh/Y4u9PKOIMVhs762pl3LSdc2ip2PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mqHLd3CuhYlHhc3qt2JRUbDfmkzgg77zZoHoP7HunsVuy1fvNBiw46KpM303DXgGMq
         cazFzdVwFaLAZXdEO+ACbYaldPLUd85KUWIf48pB32aYtyVnmO9xUKTkKbD+Iv/ktrFd
         bugc3yq5XSjpctGCOqhr5wSZubXEpHGmVVEKc=
Received: by 10.224.74.3 with HTTP; Tue, 13 Apr 2010 09:01:55 -0700 (PDT)
In-Reply-To: <1271136573-sup-5613@kytes>
Received: by 10.224.50.79 with SMTP id y15mr2130958qaf.7.1271174535119; Tue, 
	13 Apr 2010 09:02:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144820>

Heya,

On Tue, Apr 13, 2010 at 07:29, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Hm, this is something that I hadn't thought about earlier. Thanks for
> the suggestion- I will not attempt to go into complicated cases,
> atleast in my summer term.

I think we can safely say that "git clone svn://example.com/myrepo"
only has to work for svn repositories that have a 'sane' layout. If
you want a non-standard layout you can do 'git init && git configure
.... && git fetch', where you configure everything the way you want
before fetching. We could perhaps even provide a tool to aid with
configuring things; or perhaps a mode to not do any rewriting (just
import the data into git as-is) and then have a tool that examines the
history and interactively helps you set up an appropriate rewrite
config? Interesting times are ahead :).

-- 
Cheers,

Sverre Rabbelier
