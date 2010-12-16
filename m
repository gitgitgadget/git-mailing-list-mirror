From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 07/14] t7800-difftool.sh: Fix a test failure on Cygwin
Date: Thu, 16 Dec 2010 20:04:56 +0000
Message-ID: <4D0A70E8.9030803@ramsay1.demon.co.uk>
References: <4D07B724.8000901@ramsay1.demon.co.uk> <7v39q0upw7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, davvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:41:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMVo-0000Ml-6S
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944Ab0LPWlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:41:14 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:65171 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608Ab0LPWlL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 17:41:11 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PTMVa-00042p-nl; Thu, 16 Dec 2010 22:41:10 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v39q0upw7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163829>

Junio C Hamano wrote:
> This is not just "test failure" but can cause a failure in the real life
> for people who want "the last flag wins" to work, no?

Yes, indeed. I was concentrating on fixing test-suite failures (and that
can mean you have to modify the test, the application or both) so...

> I'll retitle the patch and queue it separately from other test fixes.

Thanks!

ATB,
Ramsay Jones
