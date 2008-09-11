From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Use compatibility regex library also on AIX
Date: Thu, 11 Sep 2008 09:31:25 +0100
Message-ID: <e2b179460809110131h781f0c91i9d478e20b55dec24@mail.gmail.com>
References: <20080907184537.GA4148@regex.yaph.org>
	 <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com>
	 <20080910100301.GA27748@regex.yaph.org>
	 <e2b179460809100453r3df4ec8dh3d9bfbbd468c5676@mail.gmail.com>
	 <e2b179460809110059i2eca8b07x6d263f06cc8e5d32@mail.gmail.com>
	 <48C8D374.9050007@viscovery.net>
	 <20080911082554.GB27748@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Arjen Laarhoven" <arjen@yaph.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 10:32:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdhbO-0003YU-VU
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 10:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbYIKIb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 04:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbYIKIb1
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 04:31:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:52301 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbYIKIb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 04:31:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so251513rvb.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ybJei42FMYm3/gSYKsqec+N5E80X7ZxPxOf8zCROyfo=;
        b=rSzRURs4LTkfPPBKIuAo680UOj55Zewx1Zm9x51VZsAI4Kd0dOg/mhWkb14oZsHnXi
         jKSGMJX+yM4hdu76WIKJDAv244RVX/d1x0eb9eHBTuhvgDaXj6Nv0/9wxa9eFvbb3lXu
         ePmnSe6R24xMHZwOriZDxG2Qo8bSVJOLyudlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bNVkeeZK0afi10KKAY8sOP0K+iri5ZI9hCvIIbZzhsToEj1TYWLnobDs06F42Ant20
         agMAAf6XfcnKJOPpq0gnm1lOBFLEztoPm42pyHmAcG8wMmD+6JUGo/pMBm5NSfXMnJ+Y
         fj66jF72lMop0Naf1qYj+iCzaGrz9eUd9rc7Q=
Received: by 10.140.128.11 with SMTP id a11mr1537391rvd.232.1221121885402;
        Thu, 11 Sep 2008 01:31:25 -0700 (PDT)
Received: by 10.140.143.2 with HTTP; Thu, 11 Sep 2008 01:31:25 -0700 (PDT)
In-Reply-To: <20080911082554.GB27748@regex.yaph.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95596>

2008/9/11 Arjen Laarhoven <arjen@yaph.org>:
> On Thu, Sep 11, 2008 at 10:14:44AM +0200, Johannes Sixt wrote:
>> This augments 3632cfc24 (Use compatibility regex library on Darwin,
>> 2008-09-07), which already carries a "Tested-by" statement for AIX,
>> but that test was actually done with this patch included.
>
> I hadn't realized it had already gone in to 'pu'.  I've put the AIX part
> into my local patch, and also had it tested on HP-UX.  Today I'll
> probably can test it on Solaris too, and add that as well.

I think the reason it's in pu is that it's in maint, master and next too...

All my test runs went bang this morning. 8-)

2008/9/11 Junio C Hamano <gitster@pobox.com>:
> Sorry, my fault --- I should have noticed the missing "ifeq AIX"
> anywhere in the hunk headers.

No, I shouldn't have added the Tested-by without making it clear I was
testing the tip of the thread, not the original patch. My bad.

Mike
