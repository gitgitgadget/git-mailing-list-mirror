From: Jan-Marek Glogowski <glogow@fbihome.de>
Subject: Re: [PATCH] Prefix shell test output messages with test id
Date: Thu, 06 Sep 2012 22:29:38 +0200
Message-ID: <504907B2.7060704@fbihome.de>
References: <1346931921-5901-1-git-send-email-glogow@fbihome.de> <20120906123400.GA25467@tommy-fedora.scientificnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 22:29:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9ii3-0008Kc-St
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 22:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759810Ab2IFU3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 16:29:48 -0400
Received: from ironman.h-da.de ([141.100.10.250]:31944 "EHLO ironman.h-da.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759739Ab2IFU3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 16:29:47 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av4EAMoGSVCNZChB/2dsb2JhbAA7CrtMgQeCIAEBBXgBEAsOCgkWDwkDAgECAUUGDQYCAQGIELtbixEQhjUDmzmKPYJl
Received: from mail.fbihome.de ([141.100.40.65])
  by ironman.h-da.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Sep 2012 22:29:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by mail.fbihome.de (Postfix) with ESMTP id 71633932FC;
	Thu,  6 Sep 2012 22:29:48 +0200 (CEST)
Received: from mail.fbihome.de ([127.0.0.1])
	by localhost (stud1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03817-13; Thu, 6 Sep 2012 22:29:48 +0200 (CEST)
Received: from [172.16.2.194] (unknown [194.113.41.246])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.fbihome.de (Postfix) with ESMTP id 427CD932FA;
	Thu,  6 Sep 2012 22:29:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <20120906123400.GA25467@tommy-fedora.scientificnet.net>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204919>

Am 06.09.2012 14:34, schrieb Thomas Gummerer:
> On 09/06, Jan-Marek Glogowski wrote:
>> This adds the test ID (tXXXX) prefix to the test result message of
>> all shell tests.  This is especially useful when doing a parallel
>> check run, where it's currently quite hard to identify the actual
>> failing test case.
>>
>> Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
> 
> This breaks the TAP output format of the tests, which is needed to run
> them with prove.  To identify the failing tests more easily when running
> the tests in parallel, you may want to add GIT_TEST_TARGET = prove to
> your config.mak.
> 
> If this change is really needed, I think you should add the test-id after
> the message.

While grep'ing for prove I found t/README...

>From my point of view the patch can be dropped. I can set GIT_PROVE_OPTS
to run prove with multiple CPUS. Is there a known (easy) way to
propagate MAKEFLAGS -j to prove?

And I would like to propose a symlink from Documentation/testing =>
../t/README.

Thanks for the quick review.
