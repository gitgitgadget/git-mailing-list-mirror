From: Ryan Jacobs <ryan.mjacobs@gmail.com>
Subject: Re: Fwd: Add git ignore as builtin
Date: Mon, 17 Nov 2014 00:12:25 +0000 (UTC)
Message-ID: <loom.20141117T010932-213@post.gmane.org>
References: <CA+mQAOXPZSv2B8tVfC=4eJ7X_2j8Di4BkuE=z43=U2+VNpdQQg@mail.gmail.com> <CA+mQAOU_UnPuSk0f9d1sUnxBj8M4zEX7bwa4Dw_z_PJV3Lp4LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 01:12:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xq9w2-0007N4-G5
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 01:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbaKQAMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 19:12:40 -0500
Received: from plane.gmane.org ([80.91.229.3]:45673 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbaKQAMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 19:12:39 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Xq9vp-0007Kh-Ot
	for git@vger.kernel.org; Mon, 17 Nov 2014 01:12:38 +0100
Received: from 107-132-54-136.lightspeed.frokca.sbcglobal.net ([107.132.54.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 01:12:37 +0100
Received: from ryan.mjacobs by 107-132-54-136.lightspeed.frokca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 01:12:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 107.132.54.136 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.94 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alberto Fanjul Alonso <albertofanjul <at> gmail.com> writes:


> git ignore <whatever> adds <whatever> to .git/info/exclude

This should be "git exclude" not "git ignore".
Difference between the two: http://stackoverflow.com/questions/10066749/git-
excludes-vs-ignores

I'd second the notion of a "git ignore", however it would have to modify the 
`.gitignore` not `.git/info/exclude`.
