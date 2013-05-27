From: Andreas Krey <a.krey@gmx.de>
Subject: Re: java zlib woes (was: Reading commit objects)
Date: Mon, 27 May 2013 06:11:46 +0200
Message-ID: <20130527041146.GJ9448@inner.h.apk.li>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com> <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com> <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com> <20130522045131.GA6257@inner.h.apk.li> <CAJo=hJtkbCeJA4ao2CkPODrNX_QaKDo4uBS4qvBVTRQ=x-Os3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chico Sokol <chico.sokol@gmail.com>,
	John Szakmeister <john@szakmeister.net>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 27 06:12:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgonP-0007m1-S7
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 06:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860Ab3E0EMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 00:12:20 -0400
Received: from continuum.iocl.org ([217.140.74.2]:43312 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3E0EMT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 00:12:19 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4R4Bko17889;
	Mon, 27 May 2013 06:11:46 +0200
Content-Disposition: inline
In-Reply-To: <CAJo=hJtkbCeJA4ao2CkPODrNX_QaKDo4uBS4qvBVTRQ=x-Os3A@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225575>

On Tue, 21 May 2013 22:56:21 +0000, Shawn Pearce wrote:
...
> This was with JGit?  A stack trace and JGit version (so we can
> correlate line numbers) would be a much more useful bug report than
> nothing at all.

I now have a full test case (involving a generated repo just shy of 1GB)
that will reproduce that hang. Will look up the existing jgit bug to
report there.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
