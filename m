From: Daniel Black <daniel.subs@internode.on.net>
Subject: Re: cvsimport error when modulename is '.'
Date: Tue, 16 Feb 2010 22:21:58 +1100
Message-ID: <201002162221.58483.daniel.subs@internode.on.net>
References: <201002132251.42070.daniel.subs@internode.on.net> <20100214070757.GA22000@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 12:23:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhLWk-0007IQ-I7
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 12:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab0BPLXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 06:23:33 -0500
Received: from bld-mail19.adl2.internode.on.net ([150.101.137.104]:55590 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754363Ab0BPLXc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 06:23:32 -0500
Received: from passivegrunt.localnet (unverified [121.45.210.27]) 
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id 13816798-1927428 
	for multiple; Tue, 16 Feb 2010 21:53:30 +1030 (CDT)
User-Agent: KMail/1.13.0 (Linux/2.6.31-gentoo-r4; KDE/4.4.0; x86_64; ; )
In-Reply-To: <20100214070757.GA22000@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140098>

On Sunday 14 February 2010 18:07:58 Jeff King wrote:
> On Sat, Feb 13, 2010 at 10:51:42PM +1100, Daniel Black wrote:

> These messages are not coming from git-cvsimport, but rather from cvsps,

thanks for narrowing it down. I'll see if I can track down the maintainer 
there.

> which cvsimport uses to generate whole patchsets from the CVS data. Just
> running "cvsps ." results in similar errors, and I don't see an obvious
> way to do what you want. So probably it would require a patch to cvsps
> to fix.

thanks for confirming this.
 
> If this is a one-shot import, you can try a few different things.

was hoping not too but i might be able to get the project team on board with a 
one-shot.
 
> As a hack, if you can move files in the CVS repository

on sf its easy as you've got read rsync access on the source

> (and if you
> can't, try using cvssuck or similar to pull them locally, and then do
> the import from there), then move everything to a submodule "foo", and
> import that module.

might to this .

> Alternatively, you might check out some of the alternative importers
> like parsecvs or cvs2git. I don't know if they would handle this
> situation better.

ok

> And as a super-hacky alternative, you could import each module
> separately and then stich them all together using git-filter-branch.

Yep was thinking of this. Thanks for the expert advice on the stiching 
together because i had no idea how.

Much appreciate your time for putting together these options.

Thanks Jeff.
