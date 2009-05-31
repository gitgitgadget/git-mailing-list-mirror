From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Resetting working files
Date: Sun, 31 May 2009 18:25:15 +0200
Message-ID: <20090531162515.GB8129@m62s10.vlinux.de>
References: <DA26600008CE404B831978F6EBB31C6B@HPLAPTOP> <4A229B9A.6060807@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aaron Gray <aaronngray.lists@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dirk =?iso-8859-1?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun May 31 18:19:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAnkb-0002jY-C7
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758972AbZEaQS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 May 2009 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758605AbZEaQS5
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:18:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:59447 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757605AbZEaQS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:18:56 -0400
Received: (qmail invoked by alias); 31 May 2009 16:18:56 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp061) with SMTP; 31 May 2009 18:18:56 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX191XzoWj2J1dyPfe2SntH90vUdz4YBB+7eXubDavm
	lIyR5jn9vF/U9U
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 79C6A180BB; Sun, 31 May 2009 18:25:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A229B9A.6060807@dirk.my1.cc>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120416>

On Sun, May 31, 2009 at 05:00:42PM +0200, Dirk S=FCsserott wrote:
> Am 31.05.2009 15:09 schrieb Aaron Gray:
>> Hi,
>>
>> How do I reset the working files back to HEAD ?
>>
>> Many thanks,
>>
>> Aaron
>>

[...]

> To revert only a single file, use
>
> $ git checkout -- path/to/file
>

This will only reset the file content to the version in the index.
E.g.=20

	echo modified >> a.txt
	git add a.txt
	git checkout -- a.txt           (1)

	git checkout HEAD -- a.txt	(2)


(1) This will do nothing to your file 'a.txt' in your workdir because
    the index and the workdir are identical

(2) This will reset your file to the state before you run that bogus
    echo modified >> a.txt   comand

Greetings,
Peter
