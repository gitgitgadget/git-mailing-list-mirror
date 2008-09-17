From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 20:14:02 +0100
Message-ID: <57518fd10809171214u3b5b3b96yc432c1c410faf8b4@mail.gmail.com>
References: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com>
	 <1221658141-75698-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <48D11C3C.5070707@op5.se>
	 <57518fd10809170831x6d84aeb0m9b0b2c4095a1de70@mail.gmail.com>
	 <20080917155505.GH4829@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 17 21:15:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg2Ug-00069m-CJ
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 21:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbYIQTOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 15:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbYIQTOH
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 15:14:07 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:52479 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbYIQTOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 15:14:04 -0400
Received: by an-out-0708.google.com with SMTP id d40so325391and.103
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Z8c/lY1FZC2FTKIstrsGmuFe9rph4CGWHbM7Y3qXpGY=;
        b=a3dSWP3TD8VyzQ+m62c4ZvBez03xZOTd7DTqjStEBecWi1HdkT+CO5iFGTq1E2WV9u
         VkqzfH2In9drzpyfB+3bcJF+aeAXbJuw9i+8ZlW7nXGu5YlkhXtttrhXuSLkOxc9db5H
         hP1QEGGGDQ2vIBEw+u6CmctXw0SkWoOCPD87s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ECrP6PRcROEgPiN5V5ADk2FORzkbOYyIhQmpcIDcGuAO3F7NLuBfiLbvZ6awwM36f1
         nGNrrSPNOFUnhS1iMHtMZOJNVhnG+GF5vru5uxehR1kig5NKrwR8sbB1nvxdY9BFOfh+
         cYAJTdjzmZKVMcR1lXps1LPZOgpk4kvuFB3Mk=
Received: by 10.142.147.20 with SMTP id u20mr1022266wfd.47.1221678842722;
        Wed, 17 Sep 2008 12:14:02 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Wed, 17 Sep 2008 12:14:02 -0700 (PDT)
In-Reply-To: <20080917155505.GH4829@genesis.frugalware.org>
Content-Disposition: inline
X-Google-Sender-Auth: 389401ceea92f73d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96134>

On Wed, Sep 17, 2008 at 4:55 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Wed, Sep 17, 2008 at 04:31:17PM +0100, Jonathan del Strother <maillist@steelskies.com> wrote:
>> I was changing it to match the style in the existing java pattern (and
>> my objc pattern).  You think the java one should be changed to match
>> the pascal one, then?
>
> The point is that it's unrelated, so you should not change that part in
> the same patch. Send a separate patch if you want to do something
> unrelated to Objective-C.

Johannes already convinced me to do it as a separate patch.  Andreas
seems to think that even if that change were in a separate patch, it
is pure nonsense.  I think it's pretty subjective - I was just making
things consistent.
