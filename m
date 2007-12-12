From: Mike Hommey <mh@glandium.org>
Subject: Re: [(not so) random thoughts] using git as its own caching tool
Date: Wed, 12 Dec 2007 16:48:48 +0100
Organization: glandium.org
Message-ID: <20071212154848.GA19294@glandium.org>
References: <20071212003813.GG29110@artemis.madism.org> <475FFFB7.4010102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2TrK-0003t9-Ha
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332AbXLLPtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 10:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755921AbXLLPtS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:49:18 -0500
Received: from vuizook.err.no ([85.19.215.103]:37400 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755421AbXLLPtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:49:17 -0500
Received: from aputeaux-153-1-17-136.w82-124.abo.wanadoo.fr ([82.124.59.136] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1J2TqJ-0007RR-Qk; Wed, 12 Dec 2007 16:49:58 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1J2TpI-00051X-J1; Wed, 12 Dec 2007 16:48:48 +0100
Content-Disposition: inline
In-Reply-To: <475FFFB7.4010102@op5.se>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68056>

On Wed, Dec 12, 2007 at 04:35:19PM +0100, Andreas Ericsson <ae@op5.se> wrote:
> A bit of both ;-)
> 
> I like the idea to use the git object store, because that certainly
> has an API that can't be done away with by user config. The reflog
> and its expiration mechanism is subject to human control though, and
> everyone doesn't even have them enabled. I don't for some repos where
> I know I'll create a thousand-and-one loose objects by rebasing,
> --amend'ing and otherwise fiddling with history rewrites.
> 
> Having a tool that works on some repos but not on others because it
> relies on me living with an auto-gc after pretty much every operation
> would be very tiresome indeed.

There is already a tool that relies on reflogs: stash.

Mike
