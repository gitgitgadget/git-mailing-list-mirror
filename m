From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 13:44:22 +0200
Message-ID: <81b0412b0905130444t3eee4c92r9e2d3d995bfccfe4@mail.gmail.com>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com>
	 <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com>
	 <alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de>
	 <200905130724.44634.robin.rosenberg@dewire.com>
	 <4A0A91CE.3080905@gmail.com> <4A0A9AA2.1000004@op5.se>
	 <4A0A9F23.8050804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 13:44:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4CtJ-0001j5-PN
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 13:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895AbZEMLo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 07:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755136AbZEMLoY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 07:44:24 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:43346 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbZEMLoW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 07:44:22 -0400
Received: by bwz22 with SMTP id 22so586871bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 04:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=B4+bN+vBfhh724+PACny6rUs/SeL4+Vw/hfrqJ+V/7k=;
        b=Xy0G6sPAuLCkExU2glSWM+kH6kOGyr0IxOHLZKNu8iHXSQUece+9/b4wj04Ic6pXn2
         rNcaXy6DYJT6kWK9ZXJdPegF/4TE5QiofWrn0opDYn+CGTy4OxsrabXv181vtO3jVlpL
         ndnDeEFgPWsOK44PmiyvtsNQRPKyYw1yThyvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bSn22WNyNWVhT7a9HxvCfQMK9CKyUfBFO4Wh5o8LG+EVFFrOvms2zDqZV8gtGpNHfi
         GABw2li9BIPeKu5FjCOnkXPMHb+2fUYGdhEgVNA0LQPSJG7oWLyLUVHMute1Ag71KR5c
         9/Kr/vO2A+IqKY7T05vUvalcR8rMVQ0zoRRY0=
Received: by 10.204.53.1 with SMTP id k1mr826421bkg.125.1242215062539; Wed, 13 
	May 2009 04:44:22 -0700 (PDT)
In-Reply-To: <4A0A9F23.8050804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119037>

2009/5/13 Esko Luontola <esko.luontola@gmail.com>:
> Andreas Ericsson wrote on 13.5.2009 13:02:
>>
>> If you're *really* serious about it though, here's how to go about
>> it:
>
> Thanks for the pointers. I'll have a look at what the repository format is
> and how to create a migration path.
>

While at it, think about how are you going to merge trees where filenames
have changed their encoding (because of local configurations, you know).
And take a look at memory use in your new encoding-per-filename format
