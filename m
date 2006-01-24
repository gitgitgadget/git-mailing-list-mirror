From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Tue, 24 Jan 2006 00:30:23 -0500
Message-ID: <1138080623.15105.51.camel@dv>
References: <1137144291.20073.104.camel@dv>
	 <b0943d9e0601160018x206faf9ck@mail.gmail.com>
	 <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth>
	 <1137539762.12454.11.camel@dv> <20060118193717.GI32585@nowhere.earth>
	 <1137631749.13853.22.camel@dv> <20060119213838.GA27397@nowhere.earth>
	 <1137738224.27911.26.camel@dv>  <20060120182255.GD32177@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue Jan 24 06:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1GlP-0006EH-2a
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 06:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWAXFac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 00:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWAXFac
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 00:30:32 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:63443 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932435AbWAXFab
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 00:30:31 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F1Gl8-00007w-KX
	for git@vger.kernel.org; Tue, 24 Jan 2006 00:30:26 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F1Gl5-0004r5-S3; Tue, 24 Jan 2006 00:30:23 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060120182255.GD32177@fieldses.org>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15095>

On Fri, 2006-01-20 at 13:22 -0500, J. Bruce Fields wrote:
> I tend to use stg refresh -es as a quick (well, not quite as quick as
> I'd like) way to look at the current patch.  Often I leave it up while
> I'm working (editing the patched files).  So if exiting from stg refresh
> -es suddenly started overwriting my working files, I'd be very
> unhappy....

If I understand correctly, "stg refresh" only modifies the repository,
not the files in the local directory.  This shouldn't change.

It's only having two instances of "stg refresh -es" that would be a
problem if conflicting edits are made in both editors.  The answer to
that is "don't do it".

-- 
Regards,
Pavel Roskin
