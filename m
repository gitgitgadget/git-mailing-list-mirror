From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: git-fetch question/bug
Date: Fri, 14 Mar 2008 00:08:01 -0500
Message-ID: <5d46db230803132208r3f3f9e34q80bb9c03d65ab67c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 06:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja29t-00047D-V8
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 06:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYCNFIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 01:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbYCNFIG
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 01:08:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:64248 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYCNFIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 01:08:05 -0400
Received: by wx-out-0506.google.com with SMTP id h31so4111183wxd.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 22:08:01 -0700 (PDT)
Received: by 10.150.191.10 with SMTP id o10mr6009031ybf.84.1205471281415;
        Thu, 13 Mar 2008 22:08:01 -0700 (PDT)
Received: by 10.150.199.5 with HTTP; Thu, 13 Mar 2008 22:08:01 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 14dd966e227c3975
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77178>

Hey,

I was wrapping git-fetch when I discovered that it does not return
error when the
fetch fails due to it not being a ff...

~/Desktop/Projects/test  (test2)
govind@gnosis: 574> git fetch . remotes/origin/gitnext:test2
From .
 ! [rejected]        origin/gitnext -> test2  (non fast forward)
~/Desktop/Projects/test  (test2)
govind@gnosis: 575> echo $?
0
~/Desktop/Projects/test  (test2)
govind@gnosis: 576> git version
git version 1.5.4.3.587.g0bdd73


So, is this the expected behavior?  I expect it should return non-0
when it does not
perform the requested fetch.

If this is supposed to be this way, then sorry for the noise.

Thanks,
Govind.
