From: Yann Dirson <ydirson@altern.org>
Subject: Re: [BUG] Problem with "stgit push" causing data loss
Date: Mon, 22 Jan 2007 00:27:45 +0100
Message-ID: <20070121232745.GE4665@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070120150113.GB4665@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701211442q503396ack2bf2d088325fc4a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 00:28:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8m77-0000JZ-Vn
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 00:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXAUX2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 18:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbXAUX2N
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 18:28:13 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:55594 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbXAUX2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 18:28:13 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 63A4454F4;
	Mon, 22 Jan 2007 00:28:11 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 6EF402014; Mon, 22 Jan 2007 00:27:45 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701211442q503396ack2bf2d088325fc4a0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37362>

On Sun, Jan 21, 2007 at 10:42:18PM +0000, Catalin Marinas wrote:
> On 20/01/07, Yann Dirson <ydirson@altern.org> wrote:
> >Well, "data loss" is a bit strong, since the data is still available
> >to find using git-lost-found.
> >
> >I first tried to reproduce with a simple test-case, but could not, so
> >here is my way to reproduce it, on a clone of the stgit official
> >workspace.
> 
> I tried to somehow emulate this without the fold script but didn't
> manage to trigger the bug. I'll try with your script tomorrow but
> first:
> 
> Do you use the latest HEAD in the StGIT repository? I'm asking because
> the line numbers reported in your backtrace are different from mine. I
> also made some changes in this area in the past couple of weeks which
> might have fixed or broken things.

Here is where I am:

stgit$ git-rev-parse origin
0f4eba6a37c1a5454560b097873e5a22bfcde908
