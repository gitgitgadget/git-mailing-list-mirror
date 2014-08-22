From: Bernard Clark <bernieclark4@gmail.com>
Subject: strange histories from filter-branch
Date: Fri, 22 Aug 2014 08:41:19 -0400
Message-ID: <CACpvNxTTN7G09L0WPvs4eq9v9U9duoy-bz0b1Smj4A=hwwYhtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 14:41:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKo9l-0001V6-Gf
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 14:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbaHVMlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 08:41:21 -0400
Received: from mail-wi0-f193.google.com ([209.85.212.193]:51826 "EHLO
	mail-wi0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbaHVMlU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 08:41:20 -0400
Received: by mail-wi0-f193.google.com with SMTP id f8so3751926wiw.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=s9SiT9z5YZRGWJAhr2cEo8nR9dTePb9pxOpwZpWhVlo=;
        b=QJJBVqvW1vjJ0tduJk/ncQghtoY44gsZL3n+mI6pPM42LmhuNBJ7uapLX3q1A5o5Jy
         ZngAx00QnJ6o5DLJ8IVTaGOaX1af0MgD1/DlX5OtljXslL0eDJuo/Qi2zkJoIDzPpYCc
         NJysto+kEmXl9NzPvNCelSbTbyXA7/bOiOw2RGyVlQfVPqZSflAX1QnahT1SFhcw0nHi
         e/34LX1wtg/jQyyWgHCbnWgtoD3wQq5JBhsgccMkLXrbvdYzvPFhjOl6mnpe29tXILq7
         ERuQdgBWUk8uUeHnXz/opQAQfbNuR1KHfkjarcGsLA5+/IPTm7lJp6ghZN2yw/anCJ7y
         TdGQ==
X-Received: by 10.194.185.113 with SMTP id fb17mr2007586wjc.117.1408711279125;
 Fri, 22 Aug 2014 05:41:19 -0700 (PDT)
Received: by 10.194.70.98 with HTTP; Fri, 22 Aug 2014 05:41:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255666>

I tried sending this mail to the "git for humans" mailing list but got
no response, so I'll try here.

I've been running the git filter-branch described on this page:

http://stackoverflow.com/questions/14759345/how-to-split-a-git-repository-and-follow-directory-renames.

But the resulting history includes at least two extraneous commits,
i.e., commits that appear to affect no files in the subdirectory of
interest. (The corresponding commits in the original history do affect
files, but those files are in another subdirectory.)

I also noticed several "duplicate parent" errors during the git
filter-branch. The page
http://stackoverflow.com/questions/15161809/git-duplicate-parent-causes-half-the-history-to-to-disappear
says that those errors can produce an incomplete new history, so I'm
now wondering if, in addition to including extraneous commits, my new
history might also be missing some. Both that page and
http://stackoverflow.com/questions/7489713/git-duplicate-parent/7501703#7501703
say that the "duplicate parent" errors should disappear if "git
filter-branch" is first run with no filter. But that didn't work for
me.

Any ideas?
