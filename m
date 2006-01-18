From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Wed, 18 Jan 2006 20:37:17 +0100
Message-ID: <20060118193717.GI32585@nowhere.earth>
References: <1137144291.20073.104.camel@dv> <b0943d9e0601160018x206faf9ck@mail.gmail.com> <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth> <1137539762.12454.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Wed Jan 18 20:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzJ49-0004W8-Ov
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 20:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWARTdz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 14:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWARTdz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 14:33:55 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:34529 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030275AbWARTdy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 14:33:54 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 50BE14408E;
	Wed, 18 Jan 2006 20:33:53 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EzJ7N-00076x-HW; Wed, 18 Jan 2006 20:37:17 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1137539762.12454.11.camel@dv>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14863>

On Tue, Jan 17, 2006 at 06:16:02PM -0500, Pavel Roskin wrote:
> > It would even be useful sometimes to dispatch changes to a single file
> > into several patches.  When they are distinct enough to be in
> > different diff hunks, it is pretty easy to split an existing patch,
> > but it could also be useful to only refresh a patch with specific diff
> > hunks.  A possibility would be to add a filterdiff-like "-#<n>" flag,
> > in addition to the above-suggested "refresh <file>" (and possibly only
> > allow to specify a single file together with this flag).
> 
> I think if would be better to improve "stg fold" to work on arbitrary
> patches.  This way, you prepare the patch in the editor (which would not
> be harder than finding hunk numbers) and fold it into the patch of your
> choice.  stg should check that the stack remains valid, possibly doing
> trivial adjustments to the higher patches.  The current tree should not
> be impacted.

This sounds like a good idea as well (and I would use it on a near
daily basis as well ;).  Obviously such a request can also fail,
eg. when requesting to fold a change into a patch, where a subsequent
patch modifies the same lines.

But it would not be a replacement to selecting changes with a
granularity finer than file-level, which is what I wanted to suggest.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
