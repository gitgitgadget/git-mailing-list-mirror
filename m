From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add some tests of refreshing removed files
Date: Mon, 4 Aug 2008 16:43:54 +0200
Message-ID: <20080804144354.GE12232@diana.vm.bytemark.co.uk>
References: <9e4733910807311902nd3a02bep68c8a26a7e6303cd@mail.gmail.com> <20080804134050.19457.96613.stgit@yoghurt> <9e4733910808040707u2ef8992eha629ebca9c41730b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0xX-0004wr-Uo
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbYHDOVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 10:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbYHDOVr
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:21:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1202 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbYHDOVq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:21:46 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQ1Hu-0003jZ-00; Mon, 04 Aug 2008 15:43:54 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910808040707u2ef8992eha629ebca9c41730b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91361>

On 2008-08-04 10:07:45 -0400, Jon Smirl wrote:

> I just updated to current git and stg and retested. Tracking a
> remove is working now for me.

Well, that's good.

> Tools were about three months old before updating.

Might have been fixed by 8fe07fa4cef (Handle refresh of changed files
with non-ASCII names) or 466bfe50 (Fix "refresh" failure with moved
files (bug 11661)).

> Not sure what changed. But I definitely couldn't get stgit to do it
> and had to use git commands to generate the patch. I would remove
> the file, refresh and the patch was empty. stg status would show the
> file in D state. As soon as I touched something else and refreshed
> the rm would appear in the patch.

Well, that's exactly what my new test tests for. So at least i got it
right.

> Maybe there is more to the triggering sequence than a simple rm.
> I'll keep a watch out and see if I can figure out how I got into the
> state.

Thanks.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
