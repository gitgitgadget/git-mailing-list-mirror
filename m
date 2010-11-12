From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 22:35:00 -0600
Message-ID: <20101112043500.GC10765@burratino>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
 <20101111173253.GC16972@burratino>
 <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
 <20101111184829.GG16972@burratino>
 <20101111190508.GA3038@sigill.intra.peff.net>
 <20101112021602.GA10765@burratino>
 <20101112042455.GA20555@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 12 05:35:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGlMJ-0001eD-8T
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 05:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0KLEf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 23:35:26 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50720 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0KLEf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 23:35:26 -0500
Received: by gyh4 with SMTP id 4so1667955gyh.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 20:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3AzWzqzyKr5iflAtmcT0sXpQvB85NFvMf0SjD1YQAF0=;
        b=Vya1+s6DvvsRTbylPTnDTPrrnoqRF4kNrIP8vZG3J+fUv0Xrz+wxjKhtXbV1GH9CwT
         bEstvVRU6NxYMugZ669svDXbIAHRqSD7uMpp3bcaNGTe8b7Bd194p9/AKtFU6cYoRlEZ
         Vcw1xoncbdzo4SCeIlm5ay4ltX1U15knB2HsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dRjIPxj2KSOcX70RbO/4Po96I4cQ03EIYzP10wHKtKxA+6n56R9X7P88ygv+hMCB4Y
         IyVMKEl4RwH9A+QGg11GBrmYeqLXqkI3vw8+prWOh/BWKqUVPTaFZTEyRV8SO1Kin7ZD
         mQCbO0hsX2a9nbihj5/3LSojH2Ya4J2dwlOkU=
Received: by 10.100.143.4 with SMTP id q4mr1203044and.21.1289536525255;
        Thu, 11 Nov 2010 20:35:25 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id w15sm3174147anw.33.2010.11.11.20.35.23
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 20:35:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101112042455.GA20555@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161322>

Jeff King wrote:

> Subject: [PATCH] document sigchain api
> 
> It's pretty straightforward, but a stripped-down example
> never hurts. And we should make clear that it is explicitly
> OK to use SIG_DFL and SIG_IGN.

Nice, thanks.
