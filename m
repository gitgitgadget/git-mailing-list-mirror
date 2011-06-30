From: Phil Hord <hordp@cisco.com>
Subject: Re: [GSoC 11 submodule] Status update
Date: Thu, 30 Jun 2011 13:54:19 -0400
Message-ID: <4E0CB84B.3060600@cisco.com>
References: <20110627193444.GA26778@paksenarrion.iveqy.com> <4E09205E.2080904@cisco.com> <20110628184358.GA3700@book.hvoigt.net> <4E0B98CA.2050207@cisco.com> <7vpqlws3jb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 19:54:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcLRa-0000rQ-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 19:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab1F3RyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 13:54:21 -0400
Received: from sj-iport-1.cisco.com ([171.71.176.70]:20692 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1F3RyU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 13:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1172; q=dns/txt;
  s=iport; t=1309456460; x=1310666060;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=raN+lvGmHbID5GWeBpo/0rej2OiVO+k4o+2C888YxVM=;
  b=GrsJ94UMVUtlsOKht7vi4aihZE478ECfvVlZjU6NzbYjdz3eZA8Ea9wW
   LvfUFJePPgO7gFfGiIK5Y3YNM3qe8T2hwXf5Xvtmk41UWEpdel9YY+kHm
   CtB8YOgBSD4EEDMQ25X7LezkRhD64X/IVO/yNJBpN5oKwNRci44O/BmNu
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EACG3DE6tJV2Z/2dsb2JhbABSp1t3iHihRJ19hjEEki+EdotU
X-IronPort-AV: E=Sophos;i="4.65,453,1304294400"; 
   d="scan'208";a="472933487"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by sj-iport-1.cisco.com with ESMTP; 30 Jun 2011 17:54:20 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p5UHsJwI016310;
	Thu, 30 Jun 2011 17:54:19 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vpqlws3jb.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110630135419230
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176495>

On 06/29/2011 05:58 PM, Junio C Hamano wrote:
> Phil Hord <hordp@cisco.com> writes:
>> It frightens me because it seems like a fundamental break from the
>> current submodule functionality.  Today a submodule exists as a git
>> repository with no knowledge that it is a submodule or who its
>> super-repository is.
> The use of .git that is a text file that records where the real directory
> is not limited to submodules.  Placing that "real directory" somewhere in
> the .git directory of the superproject is merely a convention.
>
> In other words, it does not change anything fundamental.

Thanks for pointing that out.  I was unaware of that feature until I saw
it discussed in another thread this week.  Even then, it was not clear
to me that this is the same feature being employed here.

> When switching to another branch, a directory that does not exist in the
> switched-to branch needs to be removed, but we would refrain from "rm -fr"
> that directory if it has any leftover cruft in it (untracked and unignored
> files). A submodule directory should behave in the same way.

Thanks.  I am suitably enclued and no longer afraid.

Phil
