From: FusionX86 <fusionx86@gmail.com>
Subject: git-p4 Question
Date: Mon, 20 Apr 2015 10:41:02 -0600
Message-ID: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 18:41:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkEku-0006TO-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 18:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbbDTQlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 12:41:04 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34089 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbbDTQlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 12:41:03 -0400
Received: by iget9 with SMTP id t9so69499754ige.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6yiupfDTD9x/Rx/dkwME7zg1Xs5TbEuHv6UZErsNQKQ=;
        b=kiSSCD+rwA1l2nLn6N4B237mOw/AfVGUGVQTV2Ef+B8yPYBaWSZph7XEGasSbAk9gB
         rkI4p6ZYKGh1B7mxvJVtlAF1pz81u6mUc0Tis6FA9+QVUQWj+J7rMtRxhxUA2XHr0n1m
         gYZkL10zCun10gkPu3UgcwjFbyRjXqYqn0v11tq5Rjc95RS9p6g7Mql1MkLAMet4IYmw
         8lVw5kvD5Goniqfp05dHetdWBXPKGqxuNinScWwZP85o0NOG7p+FS9k1t6COXQUMdmnh
         0jJGOVh04YhpUzVcvucVadH2IbwFlVtA2y0x9P21fVZz/TC0h8wHC/suzUO9QC1GHDf0
         766Q==
X-Received: by 10.107.47.26 with SMTP id j26mr22353569ioo.36.1429548062478;
 Mon, 20 Apr 2015 09:41:02 -0700 (PDT)
Received: by 10.107.4.2 with HTTP; Mon, 20 Apr 2015 09:41:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267476>

Hello,

Hopefully this is an appropriate place to ask questions about git-p4.

I started at a company that wants to migrate from Perforce to Git. I'm
new to Perforce and have been trying to learn just enough about it to
get through this migration. Anyway, I've been playing with git-p4 and
have one question/problem to discuss.

After setting up the p4 cli client I can 'p4 sync' some
//depot/main/app1 which pulls down the files I would expect from the
Perforce server. If I use 'git p4 clone //depot/main/app1', I get:

"Doing initial import of //depot/main/app1/ from revision #head into
refs/remotes/p4/master"

But I don't get any files from that depot/folder pulled down. I can
git p4 clone other depot/folders though and get some files. I suspect
that I'm just not understanding how the git-p4 module works.

Basically, I'm hoping to setup a live sync of Perforce to Git of
certain depots in preparation for the migration. Also, if anyone has
pointers or guides for this type of migration, any help is
appreciated.
