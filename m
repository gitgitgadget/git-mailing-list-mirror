From: Tommi Virtanen <tv@eagain.net>
Subject: Re: is gitosis secure?
Date: Tue, 3 Feb 2009 13:31:35 -0800
Message-ID: <20090203213135.GA1970@eagain.net>
References: <200812090956.48613.thomas@koch.ro> <1228813453.28186.73.camel@maia.lan> <873afgsul8.fsf@mid.deneb.enyo.de> <200901180650.06605.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:41:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUT0o-00043B-47
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 22:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbZBCVj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 16:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZBCVj2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 16:39:28 -0500
Received: from eagain.net ([208.78.102.120]:56556 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbZBCVj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 16:39:28 -0500
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Feb 2009 16:39:28 EST
Received: from musti.eagain.net (unknown [69.84.6.92])
	by eagain.net (Postfix) with ESMTPS id AB1D456601;
	Tue,  3 Feb 2009 21:31:37 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id CBB77870013; Tue,  3 Feb 2009 13:31:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200901180650.06605.bss@iguanasuicide.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108253>

On Sun, Jan 18, 2009 at 06:50:06AM -0600, Boyd Stephen Smith Jr. wrote:
> I can't speak directly to gitosis' security.  If users are allowed to, e.g. 
> change the hooks in their repository, there may be an issue there.  I 
> certainly haven't done any sort of audit to the source code AND I do not 
> hold any security certification--or even job experience in a security 
> field, yet.

You can't change hooks via gitosis, exactly for that reason.

In the future, I hope to provide ways to configure "known safe" hook
behavior. Basically something like "export contents after push to a
fixed subdirectory of ~git, named after the repo path" that you can
toggle on/off etc, one of those for every interesting hook I
encounter.

I do not ever want the gitosis admin to be able to do anything but
denial of service or repository content destroying attacks. And those
two capabilities are basically needed to do admin things.


Summary: I fully expect gitosis to be more secure than a manually
maintained git-shell over SSH setup, mostly because it can make
human errors more rare.

I also fully expect SSH(+gitosis)+git-shell to be more secure than
Apache+mod_dav.

-- 
:(){ :|:&};:
