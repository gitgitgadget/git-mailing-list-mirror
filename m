From: Grant Erickson <gerickson@nuovations.com>
Subject: GIT and Cloning Remote Repositories into "Local Remote" Repositories
Date: Mon, 20 Sep 2010 18:22:09 -0700
Organization: Nuovation System Designs, LLC
Message-ID: <C8BD56D1.1E331%gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 03:29:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxrfN-00019x-2P
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 03:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab0IUB24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 21:28:56 -0400
Received: from relay01.pair.com ([209.68.5.15]:1374 "HELO relay01.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751391Ab0IUB2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 21:28:55 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2010 21:28:55 EDT
Received: (qmail 95415 invoked by uid 0); 21 Sep 2010 01:22:15 -0000
Received: from 173.13.164.78 (HELO ?10.2.10.52?) (173.13.164.78)
  by relay01.pair.com with SMTP; 21 Sep 2010 01:22:15 -0000
X-pair-Authenticated: 173.13.164.78
User-Agent: Microsoft-Entourage/12.26.0.100708
Thread-Topic: GIT and Cloning Remote Repositories into "Local Remote"
 Repositories
Thread-Index: ActZK2j78iZ9X1yO5ku0NYy9rL27iQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156683>

I'm still in the stage of using GIT where I "know enough to be dangerous".
That said, I am trying to set something up and get it "right" to avoid pain
later. However, after reading GIT online help and various FAQs, it is still
unclear what the right thing or steps to perform are.

Here's the scenario:

1) I have a private repository set-up at GitHub that I can commit, push and
pull to my heart's content. This is all working well.

2) I now need to import some third-party software, two packages in
particular (U-Boot and Linux), at specific tags into subdirectories within
my repository in (1).

3) Changes in these subdirectories in (2) should ONLY go to GitHub but NEVER
to the origin of the clone UNLESS the user (usually me) really knows what
he/she is doing.

I know how to use 'git clone' to clone a remote repository and make local
commits there; however, what I think I want is a 'clone into':

    % cd <path to the local copy of my GitHub repo>
    % git clone <URL to package A @ tag S> <package A subdirectory>
    % git commit -m "Imported package A @ tag S" <package A subdirectory>
    % git clone <URL to package B @ tag T> <package B subdirectory>
    % git commit -m "Imported package B @ tag T" <package B subdirectory>
    % git push

Some time later, when Package A or Package B is updated to a new release
tag, I'd like to be able to choose (but not automatically) to merge those
changes in with my own changes and then update my GitHub repository.

Perhaps 'submodules' are what I am looking for?

Anyone have a good recipe or good hygiene/best practice recommendations for
this?

Best,

Grant Erickson
