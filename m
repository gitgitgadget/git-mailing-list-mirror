From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] t3910: give reason for skipping the test
Date: Sat, 14 Jul 2012 20:19:23 +0200
Message-ID: <5001B82B.1060201@web.de>
References: <71c43b6e469c916f6c41026ad6ed25c1094018be.1342287902.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 20:20:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq6wr-0003zh-Ho
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 20:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab2GNST2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 14:19:28 -0400
Received: from mout.web.de ([212.227.17.12]:59098 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab2GNST0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 14:19:26 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0M5fxo-1TnPgz07iK-00yCgh; Sat, 14 Jul 2012 20:19:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <71c43b6e469c916f6c41026ad6ed25c1094018be.1342287902.git.git@drmicha.warpmail.net>
X-Provags-ID: V02:K0:ka/9XcNxBbt3eDIeV1oqfNHFarin8dxWWXWQvg5IyyC
 ogxXfKKJlPUZHsbqAUJZ1VrplCO9lu2r1pB35KsgHp2WjzrXrW
 ZLq5r/LJwj6Gr/Wqv01I+Hh7GiSYekq7JQ4UMF07YtiX+2+mld
 Z2uvejM8/2f5NUtXqqX+iVI/RtxcP2QcDwxt+YICaugAQZHO2r
 92MhBkHoUi0us9exPhytg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201447>

On 14.07.12 19:52, Michael J Gruber wrote:
> t3910 is skipped for most users because it requires a filesystem which
> does automatic conversion between different utf-8 types. Currently, this
> results in a skipped test with "no reason given".
> 
> Use the skip_all mechanism from our test suite so that a reason for
> skipping the test is given to the user.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Alternatively, we could set a prerequisite and mark all tests with that.  Since
> it's either or for the whole test skip_all seems more appropriate.  In that
> case, we can also flatten the else branch, of course. The current patch is
> minimally invasive, though.

Good point, thanks.

If we spin that idea further,
we could move the whole t3910 into t0050.

That would be nice for all non Mac OS X users in a way that we save CPU time. 
We already detect unicode corruption in t0050. 
