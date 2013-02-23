From: "J.V." <jvsrvcs@gmail.com>
Subject: git checkout problem
Date: Fri, 22 Feb 2013 17:30:29 -0700
Message-ID: <51280DA5.800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 01:31:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9310-00056S-6J
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 01:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758781Ab3BWAad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 19:30:33 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:60843 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab3BWAaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 19:30:30 -0500
Received: by mail-da0-f48.google.com with SMTP id w4so597153dam.35
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 16:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=mMeMhNKQ4yxVDRGXLubRxiAsIZp8raRHsCA5T0PL2jY=;
        b=Q9ClbqUhgL2m/Sm4DjW6JcIsgq9qgGtdm59djZCmyDLEmnmVIiXyj2X5Er4Ks/0n5v
         yHaaHkaxqfuNP6IB1keuolIAp7W4yLapVi2nwBPziZCCOzKhm15SLtHCyujF84SIgQCC
         CNQMJ/QfylIz51yRywad8HSrDr4LGD3pBmIFERSeH0tX7sAqcHkifdOmHC3ZIQ1luhAQ
         Kr7/ghrpgCt5uy7eDse0pgHKCIogJp6HmUsuIBesTOg4HYJC3V96Nj0Kudli44JrmWZy
         yQKmdKiYkCVtZVQ5pfmDRLfoiUjC6u5gu/cWK9UIA3BM5qayYXiAoYvU/EuwwyArS3fE
         HT0w==
X-Received: by 10.68.226.228 with SMTP id rv4mr5989119pbc.118.1361579430451;
        Fri, 22 Feb 2013 16:30:30 -0800 (PST)
Received: from [10.16.242.114] ([192.206.100.4])
        by mx.google.com with ESMTPS id bi8sm4596614pab.15.2013.02.22.16.30.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Feb 2013 16:30:29 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216885>

I was on my master branch, I checked out a branch (origin/somebranch), 
did nothing, made no updates
but did a few git pulls over about a week; made a small change to one 
file & comitted & pushed.

Now am trying to go back to my master branch and get:

error: The following untracked working tree files would be overwritten 
by checkout:
         lib/derbyclient.jar
Please move or remove them before you can switch branches.
Aborting


I did not put that file there, how do I get back to my master branch?  I 
do not want to muck up
the branch that I am now one.  Obviously someone put derbyclient.jar 
there, not sure, but it is
supposed to be there so do not want to remove.

any ideas?
