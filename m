From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 15:28:18 -0400
Message-ID: <9e4733910708121228v2fa8d356ld93efa7d1d5effd6@mail.gmail.com>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	 <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJ6u-0003Wi-3L
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 21:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935695AbXHLT2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 15:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935565AbXHLT2U
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 15:28:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:49742 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934411AbXHLT2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 15:28:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1601047wah
        for <git@vger.kernel.org>; Sun, 12 Aug 2007 12:28:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gb7JDRTvmPOSa2lVOinISI+VZY0bq2XrMXbrf4KnQPC3dKQAo+QoCQLj6jwzsCYBPHQYjMDfGoqsXT9/RX2pf1XTkX5vbddWK6wGG022uQLUHPsi3G/eHvOeovTYjFRjdoEuNOUikerXLZTigMs0DguIen847hapDtpDdGHwGbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=goEE4T9P+09hx8ROuUz5QK8cBHY6B5zTCYrGPn2sCA7CpB2GuuO9QwUBQ8Cit+vT7xN3nJ/RBxF5uQ7BIaGIg1SyT5h74GLOUjA2I2Q2sAh4JXhSHHzYKVWGAn8yJgT6qyH77ax0xzpcuHsIoCL7w3cua2/fychhMn5ZUp5L9OM=
Received: by 10.114.67.2 with SMTP id p2mr2550774waa.1186946898900;
        Sun, 12 Aug 2007 12:28:18 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Sun, 12 Aug 2007 12:28:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708121140190.30176@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55706>

On 8/12/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> IOW, showing the whole history for a big project is simply pretty
> expensive. If you have a hundred thousand commits, just keeping track of
> the tree structure *is* going to take megabytes and megabytes of data.
> Limiting the size of the problem is usually a really good solution,
> especially since most people tend to care about what happened in the last
> few days, not what happened five months ago.

Could the topological graph for a packfile be computed at pack time
and stored in the packfile so that gitk doesn't have to keep
recomputing it? Does it work to merge multiple precomputed graphs
retrieved from the pack files?

-- 
Jon Smirl
jonsmirl@gmail.com
