From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git submodules and commit
Date: Wed, 16 Jul 2008 15:31:46 +0100
Message-ID: <320075ff0807160731g2537780fja1d6f5664163e876@mail.gmail.com>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
	 <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
	 <487DD1C7.3070701@viscovery.net>
	 <320075ff0807160402s7429291ela288b42d99c1ec53@mail.gmail.com>
	 <487DDCFC.9020007@viscovery.net>
	 <320075ff0807160548qae5d702jafe3df63363c512c@mail.gmail.com>
	 <487DF9BB.10107@viscovery.net>
	 <320075ff0807160703v3f16ff5bue722b760ad66488e@mail.gmail.com>
	 <20080716141738.GN32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 16 16:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ83k-0007wp-DB
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 16:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbYGPObt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 10:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbYGPObs
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 10:31:48 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:35540 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbYGPObs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 10:31:48 -0400
Received: by mu-out-0910.google.com with SMTP id w8so107688mue.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9IYtEJNAa3e5+VnZQGtxOPkhR59oIPD9456tgQMTj/M=;
        b=hzP8L8Y0du7N1Kdju7+udS+YhlLX5cncuCkv5fbBBYD/ZvsnY0WDlVYtCTMTfUHj6h
         BA+9UJfOCkaFd3Q3Q36/wForC5ebJ0mBeBkgPLgRvzgo09U1Xl6Pe+fRyzMHbDmDu3LA
         xVWKRn4NPbNfVXm8FPXnvAisfEc+tvPnxlyuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FDcV2luwYhywafY2vD0PXZHMyj/CcnUeUzOfdC/HWnEqbTiPn/ByVnMm26hVgHufkY
         VJ3b2AdD2oviUg5Prh/qYFU9b33xem/xbKZ75ZSgANtB7BqhS7drr7Xkt8SOm1P82z5x
         gZNYspOzBAHNeqOIxvf5hGF4l+wBCPsyB97m0=
Received: by 10.103.114.14 with SMTP id r14mr924805mum.120.1216218706305;
        Wed, 16 Jul 2008 07:31:46 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Wed, 16 Jul 2008 07:31:46 -0700 (PDT)
In-Reply-To: <20080716141738.GN32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88682>

> On Wed, Jul 16, 2008 at 03:03:41PM +0100, Nigel Magnay wrote:
>> - All the technical capability is there, it's just the porcelain
>> that's causing the friction.
>> then
>>  would this not seem to be an area that could be improved? Even if it
>> were an optional mode of working?
>
> So, were there already any patches posted to add such a functionality
> that were rejected? If not, apparently noone cared _enough_, yet. ;-)
> You may be the first!
>
> I don't know if there are any _present_ "free developers" willing to
> pick up this task now.  For many (most?) Git developers, submodules
> simply aren't a priority.  For me, they actually currently are, but I
> probably won't want to use them in your way either (even though I can
> agree that your sentiments are valid), so I will personally invest my
> time in doing other things than figuring out the precise semantics
> these operations should have etc.
>

That's cool. I was guessing it might be the case (or alternatively
that someone might say 'yeah, but it's 25% of the way there'); my
original query was also one of an offer of help ;-) My guess though is
that the core-devs have much more connected neural pathways at
thinking about the problems around the edge cases to be able to give
warnings of  'there be dragons'!


Nigel
