From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] revert: rename --reset option to --quit
Date: Mon, 21 Nov 2011 16:43:53 -0600
Message-ID: <20111121224353.GC19682@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111120094824.GC2278@elie.hsd1.il.comcast.net>
 <7vpqglfc1k.fsf@alter.siamese.dyndns.org>
 <m3bos5m7ez.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 23:44:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RScb1-0000fL-CC
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 23:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab1KUWoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 17:44:09 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33905 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab1KUWoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 17:44:08 -0500
Received: by ggnr5 with SMTP id r5so2884673ggn.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 14:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Bs28dG42lg/F7LTgglKvcVMFQ/QnQRsRDpY1KA7u970=;
        b=PN8o1c40R3xYEGUeNzzauspVNa68s8h1ysv7ZSNG0F/1XaF3oyA3I5r9mhUe9lHaeo
         7fNBofX0ORidWtHrB2W/aWcvEnDOUHiwtgaWQ93n44mRzjC9Ztwycy+6xz8Rz4SxUS3e
         TWBHA3T2WzWnqC+RQ0Utz1vyJIeE6kFlnNPnI=
Received: by 10.236.176.162 with SMTP id b22mr22705661yhm.78.1321915448109;
        Mon, 21 Nov 2011 14:44:08 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 8sm1137557anv.16.2011.11.21.14.44.06
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 14:44:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3bos5m7ez.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185768>

Jakub Narebski wrote:

> Actually from what I understand --reset / --quit has to have different
> meaning than --abort.

Right.  I'll send a strawman series that introduces a "cherry-pick
--abort" option soon to clarify this.

[...]
> BTW. I think that '--clear' (or '--clear-state') would be a better name
> for this option.

Could you explain why?  When I run "git cherry-pick --clear", I'd
expect that it removes some files.  Problems:

 (1) It's not clear to the novice _which_ files it will remove.  Maybe
     ".rej" files or something?

 (2) That the sequencer state is stored in files is an implementation
     detail.

>> Other than that I think I agree with the reasoning (and I think I too had
>> encountered the irritation with the "sequencer state").

Thanks for the quick feedback, both of you.
