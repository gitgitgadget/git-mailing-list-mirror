From: Michael Meeks <michael.meeks@novell.com>
Subject: Re: libreoffice merge(tool?) issue #3 ... (bogus)
Date: Thu, 24 Feb 2011 16:39:20 +0000
Organization: Novell, Inc.
Message-ID: <1298565560.32648.258.camel@lenovo-w500>
References: <1298388877.32648.171.camel@lenovo-w500>
	 <993F66D7-7659-4AA5-9931-1EB66CAA01DB@silverinsanity.com>
Reply-To: michael.meeks@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, kendy@novell.com,
	Norbert Thiebaud <nthiebaud@gmail.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 18:44:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsfEr-0007kD-L1
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 18:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595Ab1BXRoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 12:44:25 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:39660 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750930Ab1BXRoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 12:44:24 -0500
Received: from [192.168.42.152] (customer61770.102.kt.cust.t-mobile.co.uk [178.102.241.73])
	by nat.nue.novell.com with ESMTP; Thu, 24 Feb 2011 18:44:20 +0100
In-Reply-To: <993F66D7-7659-4AA5-9931-1EB66CAA01DB@silverinsanity.com>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167841>

Hi Brian,

	First - it seems that the issue here was entirely bogus, not least
because we had a bug with re-writing these makefiles as we checked them
in; so hopefully only 2 issues pending ;-)

	Anyhow - I tried your kind advice:

On Tue, 2011-02-22 at 10:55 -0500, Brian Gernhardt wrote:
> FYI: `git clone foo bar` will use hard-links to copy the object
> files and is both very fast and space efficient.  (See the
> description of `--local` in git-clone(1), which is used by
> default for local repositories since git 1.5.3.)  It's also
> guaranteed to work while the correctness of `cp -lR` depends
> on implementation details of git.

	Sounds like just what I need. Unfortunately, it didn't clone some of
the pieces I needed; eg. other configured remotes, I ended up with just
'origin' - which was unexpected (and less wonderful than cp -lR ;-).

	Is that a feature ?

	Thanks,

		Michael.

-- 
 michael.meeks@novell.com  <><, Pseudo Engineer, itinerant idiot
