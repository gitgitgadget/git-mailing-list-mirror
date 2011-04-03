From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Don't use font-lock-compile-keywords
Date: Sun, 03 Apr 2011 19:44:55 +0200
Message-ID: <87ei5j2prc.fsf@wine.dyndns.org>
References: <m3oc501rja.fsf@e4300lm.epcc.ed.ac.uk>
	<20110403001902.GA25671@elie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lawrence Mitchell <wence@gmx.li>, git@vger.kernel.org,
	David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Kevin Ryde <user42@zip.com.au>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 19:45:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6RMO-0000rG-PI
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 19:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab1DCRpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 13:45:05 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:43951 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab1DCRpE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 13:45:04 -0400
X-Greylist: delayed 1054 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Apr 2011 13:45:04 EDT
Received: from xdsl-188-155-135-49.adslplus.ch ([188.155.135.49] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <julliard@winehq.org>)
	id 1Q6RM9-0005iO-Gf; Sun, 03 Apr 2011 12:44:58 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id A2A911E729E; Sun,  3 Apr 2011 19:44:55 +0200 (CEST)
In-Reply-To: <20110403001902.GA25671@elie> (Jonathan Nieder's message of "Sat,
	2 Apr 2011 19:19:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Spam-Score: -4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170763>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> So here it is
>> again.  The originally proposed patch from Debian is to use
>> font-lock-add-keywords rather than font-lock-compile-keywords.
>> However, it doesn't exist in XEmacs, if one is looking to
>> maintain compatibility, I believe this patch is the right thing
>> to do.
>>
>>  contrib/emacs/git.el |   13 ++++++++++---
>>  1 files changed, 10 insertions(+), 3 deletions(-)
>
> Leaving patch unsnipped for reviewers' sake.

Looks good to me.

-- 
Alexandre Julliard
julliard@winehq.org
