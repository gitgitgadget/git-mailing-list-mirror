From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Big Mess--How to use Git to resolve
Date: Wed, 21 Dec 2011 18:56:10 -0500
Message-ID: <201112212356.pBLNuApC009997@no.baka.org>
References: <1324125130643-7103964.post@n2.nabble.com> <86iplf2oy5.fsf@red.stonehenge.com> <1324147247781-7104493.post@n2.nabble.com>
        <4EF26F7B.90206@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: hs_glw <greg@hra.net>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 22 00:56:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdW1E-0001Qv-Eu
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 00:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab1LUX4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 18:56:16 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:34666 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459Ab1LUX4O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 18:56:14 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id pBLNuBti015642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 21 Dec 2011 18:56:11 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id pBLNuApC009997;
	Wed, 21 Dec 2011 18:56:10 -0500
In-reply-to: <4EF26F7B.90206@gmail.com>
Comments: In reply to a message from "Neal Kreitzinger <nkreitzinger@gmail.com>" dated "Wed, 21 Dec 2011 17:44:59 -0600."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187593>


In message <4EF26F7B.90206@gmail.com>, Neal Kreitzinger writes:

    We are working on implementing this so some of what I said is 
    theoretical.  Custom branches in combination with submodules seems like 
    it could get pretty unwieldy if not managed properly.

You might want to consider using gitslave (http://gitslave.sf.net)
which is easier to use when you are developing both the superproject
and the subprojects at the same time.  You don't have to use the
"mother-may-I" commit protocol.

The trick with gitslave is that normally you run all git commands on
all repositories at the same time.  So all repositories which are part
of the superproject will be on the same branch.  This sounds like it
is ideal for you.

However, you do lose the strong binding between the superproject
commit and the subproject commit, so you would want to tag all
projects (trivial when using gitslave) when you go through a release
so that you can later go back and check out synchronized repositories
for a particular release.

					-Seth Robertson
