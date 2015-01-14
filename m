From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad
 file descriptor
Date: Wed, 14 Jan 2015 01:50:50 +0000
Message-ID: <20150114015050.GA9134@dcvr.yhbt.net>
References: <CANBgh6jyvbquuAwpWuuG4mJ3uZgajchcsJnttn4tN+LNE6EK+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Minty <mintywalker@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 02:51:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBD6o-0007wW-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 02:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbbANBuy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2015 20:50:54 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51435 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbbANBux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 20:50:53 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1864D1F4E1;
	Wed, 14 Jan 2015 01:50:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CANBgh6jyvbquuAwpWuuG4mJ3uZgajchcsJnttn4tN+LNE6EK+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262368>

Minty <mintywalker@gmail.com> wrote:
> =C2=A7 git --version
> git version 2.2.1

What about "git svn --version" ?
(it'll display the SVN binding version, too)

> Any advice / pointers would be welcome -- I'd be happy to run any
> tests & I'm reasonably comfortable coding in Perl so happy to poke
> around where I can.

Great to know.  Unfortunately, I no longer have access to the repo wher=
e
I encountered the problem and haven't been able to reproduce it again,
either.

The first step is to find a (preferably) fast way to reproduce the issu=
e
consistently.  If you can isolate which revisions and change patterns i=
n
your private repo cause it, it should be possible to create a public
repo without confidential data in it which reproduces the problem.
