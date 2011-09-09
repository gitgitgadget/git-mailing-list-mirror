From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: git rebase fails with: Patch does not have a valid e-mail address.
Date: Fri, 9 Sep 2011 00:45:14 -0400
Message-ID: <CAGZ=bqJc-Yqp_hDNsfpqq-DPafrh0sDKbSfgTGgR9GGHEwiuug@mail.gmail.com>
References: <CACyv8dckmRxgb9_FDTW+=1Y9bS27b3XZQCHnhjpfHiJig5p6wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: James Blackburn <jamesblackburn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 06:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1syD-0007J4-Sr
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 06:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab1IIEpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 00:45:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab1IIEpf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 00:45:35 -0400
Received: by wyh22 with SMTP id 22so1240477wyh.19
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 21:45:34 -0700 (PDT)
Received: by 10.216.221.224 with SMTP id r74mr1468843wep.99.1315543534226;
 Thu, 08 Sep 2011 21:45:34 -0700 (PDT)
Received: by 10.216.28.133 with HTTP; Thu, 8 Sep 2011 21:45:14 -0700 (PDT)
In-Reply-To: <CACyv8dckmRxgb9_FDTW+=1Y9bS27b3XZQCHnhjpfHiJig5p6wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181026>

On Thu, Sep 8, 2011 at 07:47, James Blackburn <jamesblackburn@gmail.com=
> wrote:
> I'm trying to rewrite some history and git's telling me:
>
> -bash:jamesb:lc-cam-025:33079> git rebase
> 7f58969b933745d4cb9bb128bbd3fa8d441cdb92
> First, rewinding head to replay your work on top of it...
> Patch does not have a valid e-mail address.
>
> Now it's true there isn't an email address for the author - the autho=
r
> no longer works for the company, and the email address was removed
> during the conversion. =C2=A0Therefore the repo contains "Author <>".

I can't really speak directly on the "rebase" issue, but...

You probably don't want to remove the email address from the repository
during a rewrite.  When I was converting some old CVS repositories for
my company I very intentionally looked up all of our old user emails to
be able to convert them reliably (even though most of the addresses at
that point did not work).  Even for the users where I could not find a
functional address I would just pick something reasonable based on the
username convention at the time.

In cases where you can't accurately attribute the commit (IE: username
of "root" or "cvs" or something), you probably want to rewrite it using=
 an
internal mailing list address.  For example, if the kernel had been in =
a
CVS repository with commits by "root", I would probably rewrite those
to be created by:
  Linux Kernel Developers <lkml@vger.kernel.org>

Cheers,
Kyle Moffett
