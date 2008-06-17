From: Johan Herland <johan@herland.net>
Subject: Re: current repository hash
Date: Tue, 17 Jun 2008 09:07:39 +0200
Message-ID: <200806170907.39665.johan@herland.net>
References: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com>
 <20080616184520.GA11992@sigill.intra.peff.net>
 <556d90580806162348q6c6b90daoe48c3fa330f488ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Alf Clement <alf.clement@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 09:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8VJK-0001ER-9N
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 09:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbYFQHID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 03:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbYFQHID
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 03:08:03 -0400
Received: from smtp.getmail.no ([84.208.20.33]:43029 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbYFQHIB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 03:08:01 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2L0020VIH22Z00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 17 Jun 2008 09:07:50 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2L00EKFIGSPDC0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 17 Jun 2008 09:07:40 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2L003OGIGRRTE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 17 Jun 2008 09:07:40 +0200 (CEST)
In-reply-to: <556d90580806162348q6c6b90daoe48c3fa330f488ec@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85269>

On Tuesday 17 June 2008, Alf Clement wrote:
> Hi all,
>
> when I run
>    $ git describe --tags HEAD
> on my branch "fire1", I get:
>     v1.5-13-g27f64b3
>
> I wonder why it's -13. The last action I did was to merge the master
> branch, which has the v1.5 tag. So it should be much less than 13?
> A snapshot from gitk is attached.
>
> CU,
> Alf

AFAICS from your graph there are exactly 13 commits that are part of fire1, 
but not part of v.1.5 (from the bottom of the graph):
- "fire 1       modified: main.c"
- The 8 commits on a parallel branch leading towards origin/fire1
- The origin/fire1 merge
- The 4th last commit: "Merge branch 'master' into fire1"
- The 3rd last commit: "modified: main.c"
- The very last commit: fire1


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
