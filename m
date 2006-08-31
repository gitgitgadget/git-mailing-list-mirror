From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/3] git-daemon: plug new upload-tar command
Date: Thu, 31 Aug 2006 19:45:29 +0200
Message-ID: <44F72039.3040206@lsrfire.ath.cx>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 19:45:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIqbj-0006R0-A0
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 19:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWHaRpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 31 Aug 2006 13:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWHaRpg
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 13:45:36 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59813
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932379AbWHaRpf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 13:45:35 -0400
Received: from [10.0.1.3] (p508E4C1A.dip.t-dialin.net [80.142.76.26])
	by neapel230.server4you.de (Postfix) with ESMTP id A4244505A;
	Thu, 31 Aug 2006 19:45:33 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26271>

Hi,

=46ranck Bui-Huu schrieb:
> Here's a simple patchset that basically teach git-daemon about the=20
> upload-tar command added by Junio's commit:

Junio has similar code in the 'next' branch.  And he correctly pointed
out that with the arrival of git-zip-tree the time has come to think
about a format independent tree-to-archive converter command to avoid
re-implementing essentially the same thing under the names of
git-upload-zip, git-upload-rar etc.

I'm trying for a few days now to find time for implementing a
git-archive command, but I'm failing.  And I won't be able to do so
before the weekend (at least).

I propose to make the command line syntax more similar to the one of
git-ls-tree (e.g. --prefix instead of optional second non-option
parameter for base dir, support for path specs).  In a previous mail I
also proposed to merge the upload command into git-archive, but now tha=
t
I thought a bit about it it doesn't make sense to me anymore.

So if you beat me to it, that would be great.  Or if you have a better
idea, that would be also great. :-)

I have to go now..

Ren=E9
