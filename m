From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Tue, 17 Jan 2006 18:16:02 -0500
Message-ID: <1137539762.12454.11.camel@dv>
References: <1137144291.20073.104.camel@dv>
	 <b0943d9e0601160018x206faf9ck@mail.gmail.com>
	 <1137517300.20556.26.camel@dv>  <20060117215752.GH32585@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Wed Jan 18 00:16:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ez04O-0003mG-5B
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 00:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWAQXQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 18:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWAQXQb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 18:16:31 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:3532 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964888AbWAQXQa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 18:16:30 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ez016-0004c5-Hr
	for git@vger.kernel.org; Tue, 17 Jan 2006 18:13:33 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1Ez03W-0006Yj-Gr; Tue, 17 Jan 2006 18:16:02 -0500
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060117215752.GH32585@nowhere.earth>
X-Mailer: Evolution 2.5.4 (2.5.4-6) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14806>

On Tue, 2006-01-17 at 22:57 +0100, Yann Dirson wrote:
> I commonly also feel the need to "stg refresh" only part of the
> current changes.  Allowing to limit the files to be impacted by a
> refresh could be a good addition.

Absolutely.

> It would even be useful sometimes to dispatch changes to a single file
> into several patches.  When they are distinct enough to be in
> different diff hunks, it is pretty easy to split an existing patch,
> but it could also be useful to only refresh a patch with specific diff
> hunks.  A possibility would be to add a filterdiff-like "-#<n>" flag,
> in addition to the above-suggested "refresh <file>" (and possibly only
> allow to specify a single file together with this flag).

I think if would be better to improve "stg fold" to work on arbitrary
patches.  This way, you prepare the patch in the editor (which would not
be harder than finding hunk numbers) and fold it into the patch of your
choice.  stg should check that the stack remains valid, possibly doing
trivial adjustments to the higher patches.  The current tree should not
be impacted.

-- 
Regards,
Pavel Roskin
