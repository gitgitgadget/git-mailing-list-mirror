From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: rev-list --cherry-pick and context lines
Date: Fri, 2 Sep 2011 20:45:34 +0200
Message-ID: <1k6zins.7n7tsq12p4bczM%lists@haller-berlin.de>
References: <87ty8udd68.fsf@gmail.com>
Cc: git@drmicha.warpmail.net (Michael J Gruber), git@vger.kernel.org
To: laksvij@gmail.com (Vijay Lakshminarayanan)
X-From: git-owner@vger.kernel.org Fri Sep 02 20:45:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzYkI-0003hP-DI
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 20:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597Ab1IBSph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 14:45:37 -0400
Received: from mail.ableton.net ([62.96.12.117]:48797 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314Ab1IBSpg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 14:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=uz+X28LGJ6NTEGw950QsF8zNw6MKuhV00V8NfnabEbQ=;
	b=mgcp1/re5cUHWwZj1nB2jw+H2ZCH0gGmuaEHD8ua4a5mL3mmavqcCYYxNoiBRWRTysYeRp3zPvCg3gys5cAzpRmxm5ImfWnYNCHtWqhEYZMpyGTsSGjeK23x5eNP8SrAVgMceMzeHns3A6iTQkvct/fKHE4BHGBvT2RBIprqzkg=;
Received: from [10.1.15.233]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <lists@haller-berlin.de>)
	id 1QzYkA-0005Ju-Jm; Fri, 02 Sep 2011 20:45:34 +0200
In-Reply-To: <87ty8udd68.fsf@gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.8 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180630>

Vijay Lakshminarayanan <laksvij@gmail.com> wrote:

> lists@haller-berlin.de (Stefan Haller) writes:
> 
> > Is there a reason why the hard-coded default is 3 in the current code?
> 
> 3 is the default context for GNU diff (and possibly other diff
> implementations also).

I think you misunderstood my question; I realize that 3 is a useful
default for "git show" or "git log -p" et al, for the reason you give.

My question was why 3 is the hard-coded value for calculating patch-ids.
For that case, 1 seems to make more sense to me.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
