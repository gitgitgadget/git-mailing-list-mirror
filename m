From: Evgeniy Ivanov <lolkaantimat@gmail.com>
Subject: gitweb doesn't work with bare repositories
Date: Sun, 30 Nov 2008 02:37:30 +0300
Message-ID: <4931D23A.10402@gmail.com>
Reply-To: lolkaantimat@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: lolkaantimat@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 00:39:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6ZPm-00057J-4i
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 00:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbYK2Xih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 18:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbYK2Xig
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 18:38:36 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:7951 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYK2Xig (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 18:38:36 -0500
Received: by ey-out-2122.google.com with SMTP id 6so822447eyi.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 15:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:x-enigmail-version
         :content-type:content-transfer-encoding;
        bh=o+sKw3VTfK1eCwuRyzsETpIMzh5g6c/KpFoKGDhj4C8=;
        b=UnIIBmt7KU68wexH5AiEFxRSHiUg5QehoxdDVfN3SapYjc6sp8lwKZ+mak6aB/E9Ds
         z76kdvCla+Hbm2Dss+mEumGtiFFJaMabsi5HItPHCoJjGu3e6LhE+sw8q7TyWdOJS12r
         mgPmFUELEeAAcf6Nf2l43N/tAOVXnHWJpA0GA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=DWGZmVOJqKBGIZcEv6OtB+KJ8BKtcVkq/vWjbRQ9/Xta0dq/pgUo/YUSNVe1jkz39H
         5STPaO+kOMp9Q1SRGeaBrqzXA/wKGoMrs3kYxxkWaeXwfTXw0jCDekIOe+3gvCpqI7Kk
         0Zl1v0gMx79332zJkw7qtry5MCOW384hTrmSc=
Received: by 10.210.144.3 with SMTP id r3mr10711163ebd.115.1228001914161;
        Sat, 29 Nov 2008 15:38:34 -0800 (PST)
Received: from ?10.180.88.13? ([89.113.219.166])
        by mx.google.com with ESMTPS id 5sm2411685nfv.15.2008.11.29.15.38.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 15:38:33 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080922)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101934>

Hi,
I have installed gitweb and can't make it work with bare repos.
I have such config:
$my_uri = "http://mysite.org:8000";
$projectroot = "/srv/www/gamekeeper/htdocs/projects";

In projects I have created bare repo:
mkdir some
cd some.git
git --bare init
cd /some_git_repo
git push /srv/www/gamekeeper/htdocs/projects master

Everything fine, but when I click the link on some.git I don't have a
page (just "Error 404").

But if I clone /some_git_repo with some in the projects, I have a link
"some/.git" and it works fine.

Permissions are ok, virtual host is ok since I get main page and have
access to cloned repo.

What can be wrong?


-- 
Cheers, Evgeniy.
Key fingerprint: F316 B5A1 F6D2 054F CD18 B74A 9540 0ABB 1FE5 67A3
