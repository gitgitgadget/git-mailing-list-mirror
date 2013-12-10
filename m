From: avinash r <nashpapa@gmail.com>
Subject: Re: Compiling git svn from source
Date: Wed, 11 Dec 2013 01:54:26 +0530
Message-ID: <CAHCistfcBt0oOz=whsrifSB3M6cN8Bk=UHOq-G_+EYOHhrXjkw@mail.gmail.com>
References: <CAHCisteVsy4_GX_1PNZfO44w1WmW28vAY0PBfwo9CL_Ze8fw2A@mail.gmail.com>
 <20131210190129.GD2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 21:24:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqTrR-0001JF-7j
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 21:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446Ab3LJUYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 15:24:49 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:48790 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3LJUYs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 15:24:48 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so8424720pbc.39
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 12:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mZxGBe6Os0SqD0i84fLu5YOLL5Ljkg4s751wqBtd8/o=;
        b=d66Q4nMks9ryo9Y+iCoDClVEtoYL9lFNA7px8c/dEL1u/UHitwMpG1FWUFpXheqPKR
         TLIEg4utSFm/Z1XSI/1/vLIw/Dras/kSuEHHBd7PXoza1Ui9FHdwANaGxUmgOASam71h
         h30dxxsDlIvGVJ7krVauFVBL6cgNM60CZHkkEy0snbqG6qWuVuyFeWc18acDmjaqr+8X
         VDR0juKlYxxIYPq0i/vdWANRqxZy9RLG0Vus/8CHV4vkYl8Qof8LDDPmk0MNeQR6kyjM
         nbFFoWXoLIGuH9BudxWkuU11rkOvtajYWyneCfEAKg/PQ2xu4D2506djuD3r+dvxuAxl
         L1cQ==
X-Received: by 10.66.102.4 with SMTP id fk4mr4883710pab.59.1386707086719; Tue,
 10 Dec 2013 12:24:46 -0800 (PST)
Received: by 10.70.95.104 with HTTP; Tue, 10 Dec 2013 12:24:26 -0800 (PST)
In-Reply-To: <20131210190129.GD2311@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239156>

Hi Jonathan,

I managed to get `git svn` installed using old school commands
executed before the commands I mentioned.

$ make configure
$ ./configure

I wrote before:
> $ make all
>
> $ sudo make install

thanks for asking about the config.

Jonathan Nieder wrote:
> What is the content of "config.mak"?  Is there a file named
> "config.mak.autogen"?  What is the output of "git help -a | grep svn"?
>
> Curious,
> Jonathan

but running the command,

$ git svn init --username=<username> http://mydomain.com/myrepo causes
the command to fail with the following error:

Can't locate SVN/Core.pm in @INC (@INC contains:
/usr/local/share/perl/5.14.2 /etc/perl /usr/local/lib/perl/5.14.2
/usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.14
/usr/share/perl/5.14 /usr/local/lib/site_perl .) at
/usr/local/share/perl/5.14.2/Git/SVN/Utils.pm line 6.
BEGIN failed--compilation aborted at
/usr/local/share/perl/5.14.2/Git/SVN/Utils.pm line 6.
Compilation failed in require at
/usr/local/share/perl/5.14.2/Git/SVN.pm line 33.
BEGIN failed--compilation aborted at
/usr/local/share/perl/5.14.2/Git/SVN.pm line 33.
Compilation failed in require at /usr/local/libexec/git-core/git-svn line 25.
BEGIN failed--compilation aborted at
/usr/local/libexec/git-core/git-svn line 25.

I'm using the version 1.8.5.1.

--
Avinash R
