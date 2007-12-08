From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Sat, 8 Dec 2007 00:01:13 -0500
Message-ID: <9e4733910712072101k4583c0afsea368253fe1cf706@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
	 <9e4733910712071804ja0a49e1m1eb209cb942bc36f@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072124160.555@xanadu.home>
	 <9e4733910712071929h17a7d88dv37686ec7cd858c63@mail.gmail.com>
	 <20071208033722.GA27776@old.davidb.org>
	 <9e4733910712072022na3369caob48d4b26a56224ea@mail.gmail.com>
	 <alpine.LFD.0.99999.0712072328420.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Brown" <git@davidb.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 06:01:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ron-0006P1-Ol
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 06:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbXLHFBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 00:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbXLHFBQ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 00:01:16 -0500
Received: from ro-out-1112.google.com ([72.14.202.179]:8781 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbXLHFBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 00:01:15 -0500
Received: by ro-out-1112.google.com with SMTP id p4so7439674roc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 21:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7DV4D5UW1PXHQD0APspyPFf6+IuhcA6wsIBKu/K6G5k=;
        b=PuGQh8a9OYkPHCNTsnA0gVzgKJ7b/RAfco7pHpCzn+KMvnHjIZIdhgrsx9YcmR8NFSP/IOJrD3gnGQccY1pY147IV57hGvYrzvAP4qIWCFnmIzku1KHFPZaKI2pT6APsV8tJgQUA3uOeegGQS7TKaNUPYYzb1E4qla9U31vwwvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uncOQoxHNn2l4hLjRfFi4sHA/9j3rGyk4dWb3ZxwKO2Z0o+bLuOfth0l7fX5aBexxExNDCIoCkwPWavS7jvUYVMl58tPo57T2RsfpB6wsxPZN+wI/B3XNQ3j0HC0T/osapgbyAudmfeZNUEEglfxqm1NVsO/KFXzWby86DOz07Y=
Received: by 10.114.126.1 with SMTP id y1mr2874604wac.1197090074155;
        Fri, 07 Dec 2007 21:01:14 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Fri, 7 Dec 2007 21:01:13 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712072328420.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67512>

On 12/7/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 7 Dec 2007, Jon Smirl wrote:
>
> > Does the gcc repo contain some giant objects? Why wasn't the memory
> > freed after their chain was processed?
>
> It should be.
>
> > Most of the last 10% is being done on a single CPU. There must be a
> > chain of giant objects that is unbalancing everything.
>
> I'm about to send a patch to fix the thread balancing for real this
> time.

Something is really broken in the last 5% of that repo. I have been
processing at 97% for 30 minutes without moving to 98%.

-- 
Jon Smirl
jonsmirl@gmail.com
