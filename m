From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: gitweb atom feeds broken (on repo.or.cz only?)
Date: Wed, 14 Oct 2009 16:35:17 +0200
Message-ID: <4AD5E1A5.7020909@hartwork.org>
References: <4ABFA258.8020301@hartwork.org> <be6fef0d0909280023x46522d91oc786feef23cb226a@mail.gmail.com> <4AC0CBBE.7020603@hartwork.org> <4AD46F38.30100@hartwork.org> <20091014141744.GO6695@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:42:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My53J-0001mI-Cq
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 16:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414AbZJNOgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 10:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933404AbZJNOgV
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 10:36:21 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:57054 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933402AbZJNOgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 10:36:20 -0400
Received: from [85.179.6.126] (helo=[192.168.0.3])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1My4v8-000471-8c; Wed, 14 Oct 2009 16:33:43 +0200
User-Agent: Thunderbird 2.0.0.22 (X11/20090820)
In-Reply-To: <20091014141744.GO6695@machine.or.cz>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130296>

Petr Baudis wrote:
> On Tue, Oct 13, 2009 at 02:14:48PM +0200, Sebastian Pipping wrote:
>> Petr, any news on this one?
>>
>> I just check and it still seems broken.
> 
> Fixed, it's a HTML::Email::Obfuscate bug.

Though the feed works in Firefox now I wouldn't call it fixed, yet,

As I elaborated earlier in this thread the Atom you generate is not
valid.  I cannot put it better than feedvalidator:

http://feedvalidator.org/check.cgi?url=http%3A%2F%2Frepo.or.cz%2Fw%2Fdottout.git%3Fa%3Datom

Please fix that, too.



Sebastian
