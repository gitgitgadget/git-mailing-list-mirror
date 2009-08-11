From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: Re: [EGIT PATCH] Provide a more JavaBeans-style 'getName' accessor for the id Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
Date: Tue, 11 Aug 2009 13:53:38 +0100
Message-ID: <8ACC6C83-75FD-477C-9083-96CA426FC069@gmail.com>
References: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com> <20090810155207.GW1033@spearce.org> <E861EAC5-150C-4CF8-AD0F-EBF15CEAE114@gmail.com> <20090810205907.GY1033@spearce.org>
Mime-Version: 1.0 (iPhone Mail 7A400)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "robin.rosenberg@dewire.com" <robin.rosenberg@dewire.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 09:41:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb8Rz-0001cf-Fc
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 09:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbZHLHki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 03:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753593AbZHLHki
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 03:40:38 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:32349 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbZHLHkh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 03:40:37 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1189412eyd.37
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:cc:x-mailer;
        bh=lLNOVtPAB73UXOq2DjjoqzH1wvi42Dk7VYrE/Z8FlnI=;
        b=kznDLcjnKt65A5IfjfT4NHL1bDCBLZrC3HJHRh6PKsDcB3Ig64x40uGhN3rJlc4Ddg
         zGYt4J8/RFo0sf9EiHSWjz/CHEwYcgUZotAKiN+5BWRYy1U0quFNm5rTfuXcbooPlsgh
         Uks3V5K7kyy0xaEP0tAUSss8jB/fKr/d8dduk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:cc:x-mailer;
        b=OgvdpC5ZlsG59Lu7jeXQd/zGf46kxPDy6tJRS5FF5JGJIUt0/IwuwCKRcAgCmJoqZx
         2xNUg52D2I9qsl64eGnTdaWv+ty9WuqZ05Ltqh4TGi9g50xirxuACLYwWoowYEJrvWfb
         RGB86bHzSC3c+SFI51zpiPwdP3j3oqKJKdOik=
Received: by 10.210.68.17 with SMTP id q17mr2103849eba.6.1250062838138;
        Wed, 12 Aug 2009 00:40:38 -0700 (PDT)
Received: from ?10.0.0.220? (gateway.bandlem.com [217.155.97.59])
        by mx.google.com with ESMTPS id 24sm1985917eyx.23.2009.08.12.00.40.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 00:40:36 -0700 (PDT)
In-Reply-To: <20090810205907.GY1033@spearce.org>
X-Mailer: iPhone Mail (7A400)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125677>

On 10 Aug 2009, at 21:59, "Shawn O." <spearce@spearce.org> wrote:

> Alex Blewitt <alex.blewitt@gmail.com> wrote:
>> That patch was originally mailed on the 11th May. Has it taken  
>> until now
>> to notice the problem, or was the other method added in the last  
>> month or
>> so? If I'm to blame, I apologise but didn't note any compile time  
>> issues
>> at the time.
>
> Arrgh, you are right, I lost this patch in my inbox, and in the
> interm we applied new features to RevTag which added getName there. .
>
>>> ./org/spearce/jgit/revwalk/RevTag.java:206: getName() in
>>> org.spearce.jgit.revwalk.RevTag cannot override getName() in
>>> org.spearce.jgit.lib.AnyObjectId; overridden method is final
>
> I can't apply this patch because getName() on RevTag is already
> defined with a different meaning.  :-(

That sounds dangerous. We now have a .name() and a .getName() with  
different semantics. Can we not change the RevTag method name to  
something else so that we dont have an inconsistency?
>

Alex 
