From: Gary Yang <garyyang6@yahoo.com>
Subject: git-p4 submit, Can't clobber writable file
Date: Tue, 2 Dec 2008 14:30:51 -0800 (PST)
Message-ID: <40586.80065.qm@web37902.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 23:32:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7dms-0000yx-56
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 23:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbYLBWaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 17:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbYLBWaw
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 17:30:52 -0500
Received: from web37902.mail.mud.yahoo.com ([209.191.91.164]:30190 "HELO
	web37902.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751759AbYLBWav (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2008 17:30:51 -0500
Received: (qmail 81085 invoked by uid 60001); 2 Dec 2008 22:30:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=geQT1+bNHJkKd0hD/hrKodNo6L7lp6NoEdFqCALNocYKx33ez0A6cgiq5YWrWiFe2ESJhZrMFTgmh8l2mB528i+6J8MzuHDs4sgwJSxHwLj/fNkSavvoa689ERXnoMwFIsXeQW5U7TLX/xej9jCtv0jFHbBJwAV51PKNRP5U0kM=;
X-YMail-OSG: fGpgImEVM1kMMzNB8hBULrq3cWpJPceT5Md89y9s0f.8W3v3Tyqtg5TTCHrNqyf_S3WOkD8WAf.7gvY_H9NSksjhKdEQ959lUr_15rx6Mdkw_hNQQHfzI1b1MDp3VjT0qs54tGDm9xFWMmFSJcZgckjfKHPk_blgbhEJHcozsdo0k45NJFsJaurlp5Om
Received: from [76.195.33.70] by web37902.mail.mud.yahoo.com via HTTP; Tue, 02 Dec 2008 14:30:51 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102183>


I followed the instructions at http://modular.math.washington.edu/home/mhansen/git-1.5.5.1/contrib/fast-import/git-p4.txt

But, I am not able to git-p4 submit. Any idea?

git-p4 clone //build/scripts build_scripts
cd build_scripts
vi foo.h
git commit foo.h
git-p4 rebase
git-p4 submit

  from sets import Set;
Perforce checkout for depot path //build/scripts/ located at /home/gyang/workspace/build_scripts/
Syncronizing p4 checkout...
//build/scripts/foo.h#1 - added as /home/gyang/workspace/build_scripts/foo.h
Can't clobber writable file /home/gyang/workspace/build_scripts/foo.h
//build/scripts/foo.c#1 - added as /home/gyang/workspace/build_scripts/foo.c
Can't clobber writable file /user/home/gyang/workspace/build_scripts/foo.c
......
command failed: p4 sync ...

Thanks.





      
