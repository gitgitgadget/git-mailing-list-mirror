From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 23:27:48 +0200
Message-ID: <20090609212748.GD13781@atjola.homenet>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 23:28:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME8rP-0003wF-0o
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 23:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393AbZFIV1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 17:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756136AbZFIV1s
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 17:27:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:53120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755953AbZFIV1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 17:27:48 -0400
Received: (qmail invoked by alias); 09 Jun 2009 21:27:49 -0000
Received: from i59F57D4A.versanet.de (EHLO atjola.local) [89.245.125.74]
  by mail.gmx.net (mp061) with SMTP; 09 Jun 2009 23:27:49 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+xJJ1jeFmxbE7zuRMMCE89YqQBTXevEnQwQlrHv/
	bL/ws2PdQqqeHq
Content-Disposition: inline
In-Reply-To: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121226>

On 2009.06.09 11:59:08 -0700, Scott Chacon wrote:
> * adds 'git resolved' for 'git add', which I hear all the time as
> being confusing

Is "resolve" a plain alias, like "stage", or smart in deciding which
files it accepts? My gut feeling is that a plain alias might cause
trouble again when users get lazy and start to do "git resolve ." and
wonder why that adds new files.

Iff such a "resolve" command is added, it should IMHO only serve the
purpose of changing the status of index entries marked as "unstaged",
and do nothing else that "add" can do. When someone asks why "git add"
is used for telling git that a conflict was resolved, I can say that
"git add" means "add this to the things to be committed" and that that
implies that conflicts have been resolved (I like to describe "git add"
as "tell git that 'this is good to commit'"). So I can give some logica=
l
explanation. But if someone would ask me why "git resolve" can add new
files, which never had a merge conflict, to the index, I'd be pretty
stumped.

Bj=F6rn
