From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Diff-tree does not work for initial commit
Date: Tue, 16 Sep 2008 08:19:37 +0200
Message-ID: <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
	 <48CECA42.1050209@drmicha.warpmail.net>
	 <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com>
	 <20080915223442.GD20677@sigill.intra.peff.net>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Anatol Pomozov" <anatol.pomozov@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 08:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfTvy-0000zX-6g
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 08:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYIPGTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 02:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYIPGTk
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 02:19:40 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:17722 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbYIPGTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 02:19:39 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1116907eyi.37
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aARKWybGPLzkrfZVrMRLpmoAfX6gZSPDVgQVS+Sf0lM=;
        b=uDrucG6S6aSBuwr5X11V5dz4TTEVYcFqlwz84Ob1tHYwDIteJApO/kxyjhiTt63c3F
         c1DDt1jWjhm0r7vSHE4C8tHlFIcEHsgr1fJ3eP+nlgT8qCdXkhXNDKjNJVSxtRNIyNv0
         f+U13U2KMQ8iSqMJF1CDTVUPH1GSTmmzVm7Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=L6D7HnkreKLvNT1XerlZdWQFWQ87+6BF1MRMI9pWdzqYOl6WwDXm0lUwIOA1w48+QO
         9aQmxuk57dCeEW3qhnT21ReatAnxPw0XM2K6xJe6jlZ3nKzVFu8fYY87K6StsbepqaNp
         8IjK/+R6eBL72Agzu+bu7Nn5r1k9VxuCmYvFg=
Received: by 10.187.232.14 with SMTP id j14mr64826far.85.1221545977752;
        Mon, 15 Sep 2008 23:19:37 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Mon, 15 Sep 2008 23:19:37 -0700 (PDT)
In-Reply-To: <20080915223442.GD20677@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95976>

On Tue, Sep 16, 2008 at 00:34, Jeff King <peff@peff.net> wrote:
> I posted this a week or so ago, but I am sure it is incomplete. If there
> is interest I can clean it up and do a proper submission.

<patch snipped>

I like it, although I think that if we add broader support for it, we
should probably be consequent and add it everywhere where appropriate?
(That is ofcourse, assuming that does not take too long to implement
etc.)

-- 
Cheers,

Sverre Rabbelier
