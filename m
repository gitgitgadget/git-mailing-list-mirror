From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Apply commits from one branch to another branch (tree structure is different)
Date: Fri, 14 Mar 2014 23:09:31 +0530
Message-ID: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brandon McCaig <bamccaig@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 18:39:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOW55-0000W5-2J
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 18:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbaCNRjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 13:39:32 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:50752 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbaCNRjb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 13:39:31 -0400
Received: by mail-yh0-f46.google.com with SMTP id b6so2878234yha.19
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=t1wce6Csxv3nwjWXXlKe2SAsh8403Geym74xQM4RfnM=;
        b=iOcgX+duC9w/hZOffVp2OY94S9bPmZLk6FS6otk4gE5Q/JXaTJN4gM16DwXYi8eTYu
         TxO8hvFKiKRtFv2r2+QOI0pUlNs4qgUj/a6nOrKFyYrQZchTbKufhsggExdkNjTacBVF
         bc0xXfW8OddI88y1GBwhIbsfOQ6DEuxHOgybg2ihfdeztMbADfFWguFpxOPk5Qz0qQGj
         PlX7WF6HoDptEEB2cWFOBQOprCdUCjmb4koaynX/5z7AFrjq9eZDG6LJImd6QIi8UdRH
         z78UtRzoSEG2zdAfwq88uCX5ckMrzOdbgSRU8We1i+W6tQxgm3BoycE6YTvtA5zHn6NA
         Ec8w==
X-Received: by 10.236.202.15 with SMTP id c15mr12783787yho.94.1394818771326;
 Fri, 14 Mar 2014 10:39:31 -0700 (PDT)
Received: by 10.170.34.215 with HTTP; Fri, 14 Mar 2014 10:39:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244099>

Hi,

I have two branch in one repo that I need to maintain for 2 different
deliveries.
Say branch1 and branch2 in test.git repo.

test.git
- branch1
     foo_v1/text.txt
     foo_v2/text.txt
- branch2
     foo/text.txt

branch1 is developers branch all source looks version'ed manner and
branch2 is superset for branch1, example foo_v1 and foo_v2 are the directories
in branch1 where developer will update the latest one here foo_v2 and branch2
foo is same as the latest one of branch1 for an instance.

Suppose developer send 10 patches on branch1 where are changes in terms
of <dir>_<version>/ then I need to apply on my local repo branch1, till now
is fine then I need to apply same 10 patches on to my branch2 where source
tree <dir> which is quite question here how can I do.

Request for any help! let me know for any questions.


thanks!
-- 
Jagan.
