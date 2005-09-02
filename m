From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Moved files and merges
Date: Fri, 02 Sep 2005 16:59:16 -0700
Message-ID: <4318E754.9000703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 03 02:00:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBLRX-00075p-Ei
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 01:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbVIBX7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 19:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVIBX7Y
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 19:59:24 -0400
Received: from terminus.zytor.com ([209.128.68.124]:58291 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751385AbVIBX7Y
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 19:59:24 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j82NxKiN013725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Sep 2005 16:59:20 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8028>

I currently have two klibc trees,

rsync://rsync.kernel.org/pub/scm/libs/klibc/klibc.git

and

rsync://rsync.kernel.org/pub/scm/libs/klibc/klibc-kbuild.git


One of the differences between the trees is that a bunch of files have 
been rearranged.  Unfortunately, it seems that whenever I try to merge 
one into the other, using cg-update from the former branch to the 
latter, if any of these files have been touched, cg-update fails, and I 
have to:

- touch these files in the "old location" manually;
- manually apply the change to the new location (and, sad to say, I 
haven't even figured out how to take the numbers cg-update spits out and 
feed them to cg-diff);
- commit.

Is there any way I can record in the repository that these files are 
actually moved files, and that the merge should apply the patch elsewhere?

Thanks,

	-hpa
