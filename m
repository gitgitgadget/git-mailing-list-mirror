From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: git-remote-svn: Future development timeline
Date: Tue, 17 Aug 2010 22:46:14 +0530
Message-ID: <20100817171611.GF6947@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 19:18:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlPnv-0007VF-23
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 19:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645Ab0HQRSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 13:18:21 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48103 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab0HQRSU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 13:18:20 -0400
Received: by pxi10 with SMTP id 10so2473227pxi.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 10:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=ha/kSoNaE6O2GAQOTgwKjcW7FyEc5vyRet3oHVynIHc=;
        b=c4lLQYMcUKUPDT3KEbRTwBNA3cG/R7FkoPnP3zq8WT1TuYDxwS6TgmtQj26JqhiWBI
         HNSCPoq9NzecUtRBW3DCAN2RJ68k3M6W3gcrZi2UxjVGCtpn7enTbnM9Bf4trEzM3JPD
         x4TouX7UEEq/Q7mSLl3H/no97PCutXtzOB9bY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=O82xKq/CKMYXx0loXpGOzLpQlHTmYGz6R1XGJYe6R1B3CQP/HOtm4bclYhIbfj18cc
         kBN7Pn/3k6Om5pRWNX2mhbrP+0IH5Kg+RU2enQTvD5AVItdqWj3CIffGeHctecFrHbsW
         DnyoHxZyv+Fz19rBR1oUbtwtyNKAa0MGg+buE=
Received: by 10.114.39.20 with SMTP id m20mr8168071wam.205.1282065486688;
        Tue, 17 Aug 2010 10:18:06 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id j2sm6309212iba.0.2010.08.17.10.18.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 10:18:05 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153766>

Hi,


The ETA for completion of git-remote-svn is three months. Here's a
relatively short-term plan.

I'm currently writing the dumpfilev3 support into svn-dump-fast-export
with two of Jonathan's patches applied [1]:
'Teach fast-import to import subtrees named by tree id' and
'Teach fast-import to print the id of each imported commit'

The first is already in `pu` and I've just ressurected the discussion
pertaining to the second. Since I already have a stopgap svndiff0
parser, I can work on re-implementing a better parser while
simultaneously working on dumpfilev3 support. I expect to have made
some significant progress by this weekend. Depending on the
fast-import patch, I expect that this'll take upwards of a month to
complete.

I'm also simultaneously working on cleaning up `svnrdump` and
abstracting out many of its components as a reusable library. The work
is pretty light, and there's no hurry to finish this off.

The branch/ tag mapper needs more thought and sketching out. I'll
think about this harder, mock up a few models, and put up some serious
notes next week for discussion.

I'll defer the conversion from the fast-export stream to dumpfilev3
for now.

As usual, everyone is welcome to join in.

[1] The work's in a bit of a mess, but I'll soon rebase it on
`pu-base` on http://github.com/artagnon/git


-- Ram
