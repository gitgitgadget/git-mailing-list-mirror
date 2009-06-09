From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: EasyGit Integration
Date: Tue, 9 Jun 2009 22:12:00 +0200
Message-ID: <20090609201200.GA13781@atjola.homenet>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 22:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME7g9-0007b8-Q2
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 22:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbZFIUMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 16:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbZFIUME
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 16:12:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:53487 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752029AbZFIUMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 16:12:03 -0400
Received: (qmail invoked by alias); 09 Jun 2009 20:12:02 -0000
Received: from i59F57D4A.versanet.de (EHLO atjola.local) [89.245.125.74]
  by mail.gmx.net (mp063) with SMTP; 09 Jun 2009 22:12:02 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19is2QPmZZiM7xM1Ipmui45juD2YotDsfuB/prsTT
	teJSHjUbYwU+Uw
Content-Disposition: inline
In-Reply-To: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121217>

On 2009.06.09 11:59:08 -0700, Scott Chacon wrote:
> * breaks the various things that 'checkout' does into separate
> commands - moves 'revert' to doing what 'checkout -- path' does

Looking through the "eg revert" docs [1], I can't seem to find how you =
can
do "checkout -- path" with it at all. "eg revert foo" seems to be "git
checkout HEAD -- foo". The "eg revert" looks really confusing to me.
"eg revert --unstaged --in HEAD~8". Hu? Revert unstaged changes in
HEAD~8? Am I missing something?

Bj=F6rn

[1] http://www.gnome.org/~newren/eg/documentation/revert.html
