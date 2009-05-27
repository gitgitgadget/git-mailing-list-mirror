From: Sam Vilain <sam@vilain.net>
Subject: Re: RFE: "git bisect reverse"
Date: Wed, 27 May 2009 15:00:02 +1200
Message-ID: <4A1CACB2.7000702@vilain.net>
References: <4A1C6B70.4050501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed May 27 05:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M99NV-0002TV-1U
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 05:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609AbZE0DAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 23:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755545AbZE0DAU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 23:00:20 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49613 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755364AbZE0DAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 23:00:19 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 5DD4021C47E; Wed, 27 May 2009 15:00:10 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 0E3C421C3A5;
	Wed, 27 May 2009 15:00:05 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <4A1C6B70.4050501@zytor.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120019>

H. Peter Anvin wrote:
> I would like to request the following feature:
>
> "git bisect reverse"
>
> ... does exactly the same thing as "git bisect start", except that it
> flips the meaning of "good" and "bad".  It is mentally fairly taxing to
> do a reverse bisection (looking for an antiregression) when one has to
> flip the meaning of "good" and "bad" (which are very loaded words to our
> psyche), and it's even worse to try to get a user to do it...
>   

Oh, yes.  And another thing: 'git bisect run' / 'git bisect skip'
doesn't do a very good job of skipping around broken commits (ie when
the script returns 126).  It just seems to move to the next one; it
would be much better IMHO to first try the commit 1/3rd of the way into
the range, then if that fails, the commit 2/3rd of the way through it, etc.

Sam.
