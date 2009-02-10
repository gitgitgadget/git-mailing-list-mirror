From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: RFC re Thunderbird + imap-send
Date: Tue, 10 Feb 2009 13:00:57 -0600
Message-ID: <4991CEE9.8040402@codeweavers.com>
References: <4990A4FF.6020404@codeweavers.com> <49915FB6.8010803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 20:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWxsJ-0003zl-6E
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 20:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbZBJTBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 14:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754433AbZBJTBA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 14:01:00 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:40370 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbZBJTA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 14:00:59 -0500
Received: from localhost
	([127.0.0.1] helo=[216.251.189.140] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LWxqs-000199-PR; Tue, 10 Feb 2009 13:00:58 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <49915FB6.8010803@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109291>

> Looks okay here. I leave the tarring and feathering to Dscho ;)

Thanks.

> 
> Trying this out showed that indeed git-imap-send needs much more love.
> The man page doesn't say much, doesn't describe all options. Most
> options can be specified in config only. You can't pass file arguments,
> only stdin. You can't even pass a recipient!

Hmm.  I think the documentation/man page is correct, at least in the 
tip; Rob Shearman fixed it back in July.

I think your larger concerns about git-imap-send are valid; it does seem 
that having two paths for emailing patches is less than ideal.

But I'm going to cowardly claim that is outside of my scope at this 
point.  (I like starting flame wars and all, but adding --html to 
git-send-email just seems like a poor choice for my health <grin>).

Cheers,

Jeremy
