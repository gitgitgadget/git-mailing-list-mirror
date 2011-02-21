From: Steven Scott <steven@codemettle.com>
Subject: Re: [BUG] git-svn fails to rename files with %20 in filename
Date: Mon, 21 Feb 2011 10:26:46 -0500
Message-ID: <AANLkTi=kemr2dPGeE6Z+RDUgrrB8wHE1nM4Zte0EvYMO@mail.gmail.com>
References: <1298283144.2772.7.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 16:27:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrXfT-0003CW-SG
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 16:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739Ab1BUP1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 10:27:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48477 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab1BUP1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 10:27:07 -0500
Received: by iyb26 with SMTP id 26so829914iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 07:27:06 -0800 (PST)
Received: by 10.231.34.201 with SMTP id m9mr1270229ibd.81.1298302026238; Mon,
 21 Feb 2011 07:27:06 -0800 (PST)
Received: by 10.231.11.133 with HTTP; Mon, 21 Feb 2011 07:26:46 -0800 (PST)
X-Originating-IP: [173.160.92.129]
In-Reply-To: <1298283144.2772.7.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167487>

On Mon, Feb 21, 2011 at 5:12 AM, Will Palmer <wmpalmer@gmail.com> wrote:
> Someone accidentally checked some files containing "%20" in their names
> into our svn repository, which is accessed with either svn or git-svn
> depending on the developer.
> When I attempted to correct this by renaming the file, I received (on
> dcommit):
> Filesystem has no item: File not found: revision 1, path
> '/theBeginningOfTheOriginalFileName theRestOfTheOriginalFilename'
> at /home/wpalmer/libexec/git-core/git-svn line 576

This is the same issue I've been seeing (except that the %20 is in a
parent directory on the SVN server). It makes using git-svn fraught
with danger, since I never know when I'm going to be unable to checkin
days' worth of git commits.

-- 
Steven Scott
