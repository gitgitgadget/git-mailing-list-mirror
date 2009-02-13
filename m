From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 14 Feb 2009 00:57:02 +0100
Message-ID: <2c6b72b30902131557w1bfe9e43l34b28a22d202e881@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
	 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
	 <20090213023120.GA7322@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jonas Fonseca <jonas.fonseca@gmail.com>,
	Tilo Schwarz <tilo@tilo-schwarz.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 00:58:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY7vW-0002A5-R4
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 00:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbZBMX5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 18:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbZBMX5H
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 18:57:07 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:64271 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbZBMX5F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 18:57:05 -0500
Received: by bwz5 with SMTP id 5so2078744bwz.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 15:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=s12Blx8aAplYasPULFgzWJUtoe5iYXdBW0POQTuU5Ek=;
        b=c+eC1MrLE3eBYY6s6Egy0efSMXvD/p0Wza/U5inadx/2znT5DBh8qYqstrmV90tp8P
         NHYkKRd/M4cQXYIM+DfDCsdBo0C78jftggy5KbBTXOTM5P5wty85zHcCK/H4l5Xk+bNj
         t2Hci7WwiTPOX8BHYeVUSmicNB7q+x+3/y+OI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=hfYsAaPEDoNCVKWyZ17jR72/xFFvTNk35ma+zWKLWHLpEP2iNThB0wvRDj3/iVCN4Z
         cTtVfW8+pegQ6gig02qIIfCJRBT0wqQtaxsch5we7p8mRdTNkZi3G+qRPxSblCfvksWI
         UqXv+jDNeDsRyMq3Q+K6VkfNIePsA79xS6jH4=
Received: by 10.181.31.16 with SMTP id i16mr900732bkj.129.1234569422595; Fri, 
	13 Feb 2009 15:57:02 -0800 (PST)
In-Reply-To: <20090213023120.GA7322@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109788>

On Fri, Feb 13, 2009 at 03:31, bill lam <cbill.lam@gmail.com> wrote:
> I can see that scroll-left/right only do it for one column, that is
> not very convenient, Will it be possible to scroll for 10 columns or
> half screen?

Certainly, the one column thing was good for testing but agreeable not
very usable so I have made the behavior of horizontal scrolling
configurable. You can either set the 'horizontal-scroll' variable to
the number of columns or the percentage of the view width you want to
scroll. Defaults to scrolling 50% of the view width.

-- 
Jonas Fonseca
