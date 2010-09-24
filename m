From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: 'git diff' against files outside a git repo
Date: Fri, 24 Sep 2010 17:30:42 -0500
Message-ID: <-30AUOVW2mMJiL1EZcTFG9LhiQWZDLcLpaLzWQHRY8tnzFEGXuZLuw@cipher.nrlssc.navy.mil>
References: <AANLkTinR7BJpD-FOS_DShg=r0ucF2C9oE6p-YoZU-5En@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:31:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGnE-0003bZ-0u
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758329Ab0IXWaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:30:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60376 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab0IXWay (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:30:54 -0400
Received: by mail.nrlssc.navy.mil id o8OMUhlD026531; Fri, 24 Sep 2010 17:30:43 -0500
In-Reply-To: <AANLkTinR7BJpD-FOS_DShg=r0ucF2C9oE6p-YoZU-5En@mail.gmail.com>
X-OriginalArrivalTime: 24 Sep 2010 22:30:43.0526 (UTC) FILETIME=[20042E60:01CB5C38]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157091>

On 09/24/2010 05:23 PM, Avery Pennarun wrote:
> Hi all,
> 
> I'm interested in using 'git diff' on some files that aren't actually
> inside a git repo at all.  Specifically, the --color-words and
> --word-diff-regex are really cool and I happen to have a use for them
> on files that aren't stored verbatim in git.  As a whole, git's
> implementation of diff seems to be the fastest-moving one out there,
> so I'd rather use it instead of another random diff implementation.
> 
> (For the curious: the particular "files" I want to compare are
> actually split into a hierarchical tree of blobs using bup's rolling
> checksum and *then* stored in git.  Obviously I have to reassemble
> them before I can diff them, which is fine and easy, but I then want
> to run 'git diff' against them, which seems to not be so easy.)
> 
> (For the extremely curious: the particular files I want to diff are
> mega-gigantic csv files from database dumps.  Because of bup's tree
> format, I should be able to zoom in on just the overall part of the
> file that has changed, then diff only that, which will be much faster
> than running a diff algorithm against the whole file.  Essentially
> O(log n) vs. the file size.)
> 
> Is there already a way to get 'git diff' to do this?

Doesn't

   git diff file.one file.two

work?

Or are you asking for something else?

-Brandon
