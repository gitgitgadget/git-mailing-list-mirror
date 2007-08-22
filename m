From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 16:49:43 +0200
Organization: glandium.org
Message-ID: <20070822144943.GA25527@glandium.org>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 16:51:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INrY0-0000LX-Mz
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 16:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759723AbXHVOvB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 10:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758949AbXHVOvA
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 10:51:00 -0400
Received: from vawad.err.no ([85.19.200.177]:36320 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758920AbXHVOvA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 10:51:00 -0400
Received: from aputeaux-153-1-90-235.w86-217.abo.wanadoo.fr ([86.217.52.235] helo=vaio.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1INrXk-0004n5-Gc; Wed, 22 Aug 2007 16:50:55 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1INrWh-0006eD-IJ; Wed, 22 Aug 2007 16:49:43 +0200
Content-Disposition: inline
In-Reply-To: <864pirej6w.fsf@lola.quinscape.zz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56385>

On Wed, Aug 22, 2007 at 04:29:43PM +0200, David Kastrup <dak@gnu.org> wrote:
> The problem I see is that C sucks really really bad as a scripting
> language, and tying together plumbing functionality into porcelain is
> one of the most powerful, flexible and hack-friendly features of git.
> Deprecating scripts is making git more opaque.
(...)

Having tools being implemented in C rather than shell won't remove the
tools for you to be able to write scripts and do your plumbing. It might
remove some examples for you to write your plumbing, though.

So here you are, all you really need is examples of how to do some plumbing.

Mike
