From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Sat, 02 Sep 2006 15:10:21 +0200
Message-ID: <44F982BD.1050509@lsrfire.ath.cx>
References: <44F977C0.4060901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 02 15:10:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJVGi-00053U-5N
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 15:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWIBNKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 2 Sep 2006 09:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWIBNKX
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 09:10:23 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54418
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751062AbWIBNKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 09:10:21 -0400
Received: from [10.0.1.3] (p508E733A.dip.t-dialin.net [80.142.115.58])
	by neapel230.server4you.de (Postfix) with ESMTP id 7909A20043;
	Sat,  2 Sep 2006 15:10:20 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <44F977C0.4060901@lsrfire.ath.cx>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26334>

The two patches I sent are what I have been able to come up with so far=
=2E
The next step would be to add archive-neutral upload and download suppo=
rt.

Having thought a bit about it I propose to keep git-archive-tree for
local operations, only.  It can be called by the uploader just like
git-tar-tree is now called by git-upload-tar.  As Franck suggested, the
uploader should allow the list of archive formats it supports to be
restricted in a config file.  The range of allowed compression levels
should also be configurable.

Does it make sense to change the wire protocol to simply send the
command line options one by one?

The interface could be something like this:

   git-download-archive <repo> <git-archive-tree options...>
   git-upload-archive <directory>

Or, if the big number of git command names is a concern:

   git-archive-remote --upload|--download ...

What do you all think?

I won't have time for any of this over the next few days, so Franck, go
wild. ;-)

Ren=E9

--=20
VGER BF report: U 0.499999
