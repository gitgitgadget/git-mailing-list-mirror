From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Using git to store /etc, redux
Date: Sat, 19 May 2007 19:48:15 +0200
Message-ID: <20070519174815.GA5124@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 19:47:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpT1p-0005qk-RS
	for gcvg-git@gmane.org; Sat, 19 May 2007 19:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbXESRrY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 13:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755761AbXESRrY
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 13:47:24 -0400
Received: from smtp14.wxs.nl ([195.121.247.5]:46394 "EHLO smtp14.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbXESRrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 13:47:23 -0400
Received: from austin (ip54532fb6.speed.planet.nl [84.83.47.182])
 by smtp14.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with ESMTP id
 <0JIA003NPUQYQH@smtp14.wxs.nl> for git@vger.kernel.org; Sat,
 19 May 2007 19:47:22 +0200 (CEST)
Received: by austin (Postfix, from userid 1000)	id 6A256290D5F; Sat,
 19 May 2007 19:48:15 +0200 (CEST)
Content-disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47760>

I recently had the idea to store and track /etc using git. When googlin=
g=20
the topic I came across the "Using git to store /etc" thread from the=20
end of last year which provided some interesting details on what would=20
be necessary.

It seems the file metadata (owner, group, mode, xattrs, etc) was the bi=
g=20
stumbling point, so I wrote up a tool over the last few days which=20
allows the metadata to be stored in a separate file which can be stored=
=20
along with the rest of the data in the repo (or separately).

This is also useful for tripwire type checks and for other types of=20
storage which drops some of the metadata (tar comes to mind)...

The tool (metastore) is available from:=20
git://git.hardeman.nu/metastore.git

Not completely cleaned up yet (it lacks a real README and some Makefile=
=20
targets) but I hope it might be useful to others (it sure is to me).

Please CC me on any replies.

--=20
David H=E4rdeman
