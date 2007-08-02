From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 16:20:44 +0200
Message-ID: <86sl72j9vn.fsf@lola.quinscape.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <20070802140011.GN29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 16:21:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGbYO-00025d-En
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 16:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbXHBOU5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754371AbXHBOU5
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 10:20:57 -0400
Received: from main.gmane.org ([80.91.229.2]:58194 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbXHBOU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 10:20:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGbXp-0004qW-Hf
	for git@vger.kernel.org; Thu, 02 Aug 2007 16:20:53 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 16:20:53 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 16:20:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:DsP/Nbirfd+uyPN2AZic/8f+CV0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54552>

Robert Schiele <rschiele@gmail.com> writes:

> On Thu, Aug 02, 2007 at 12:44:22PM +0200, David Kastrup wrote:
>> ! 		logfile="${1#-?}"
>
> You can't do something like that on /bin/sh on many systems (for
> instance Solaris).

Sigh.  It's in Posix.

I've seen a lot of "modern" constructs in the Shell scripts of git
(not least of all the eval hackery that is currently used instead of
this), so do you actually have positive knowledge that the existing
git stuff runs fine on such systems, and this wouldn't?

I don't have access to Solaris systems, so I have to take your word on
it, but I find it somewhat surprising that they would not follow Posix
here.

-- 
David Kastrup
