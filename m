From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 20:27:06 +0200
Message-ID: <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com>
References: <4A97193A.8090502@facebook.com>
	 <20090828060538.GA22416@coredump.intra.peff.net>
	 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
	 <20090828150212.GA6013@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
	 <20090828180158.GA6940@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@cam.org>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6AO-0006bP-T4
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 20:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbZH1S1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 14:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbZH1S1H
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 14:27:07 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49146 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbZH1S1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 14:27:05 -0400
Received: by bwz19 with SMTP id 19so1760469bwz.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=D6z4lkIaZ+EMpcdpI2iuFzWQQO38pNNY3crNLuRmD1U=;
        b=umS7naqGDsVJ7P87DvIrHSGMS/qGIq3NzZNBxfSRAgQRK8kiJX+1pA8g6GfmHACKvs
         phrdnmnFtv2UDI1Wyb42oxotwl8KFf40iqHKRrnVLzy2oej+Cz9ZLfT/QizyGO6M9SZC
         bQ99UOKZoTwi6KkX0R2AzhByPyptxBCwpUam8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tVhFvwoxhuW/3hAJXLYx1VVwx8GZsgXq5aw5Dj4TRZEkr7O8x3fQ4lxTvDNl9Rzfj+
         AaA7fhxmPsV6hDEB7n1dYHCcqh14L5STe1BEbGVu62aiSSig7gO6Oztzj58/mdC2Tfby
         WP3Snxsx5iAEOoB/wzc7m94/X8CdlHAwgBScY=
Received: by 10.204.154.150 with SMTP id o22mr1172943bkw.154.1251484026331; 
	Fri, 28 Aug 2009 11:27:06 -0700 (PDT)
In-Reply-To: <20090828180158.GA6940@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127323>

On Fri, Aug 28, 2009 at 20:01, Jeff King<peff@peff.net> wrote:
> On Fri, Aug 28, 2009 at 01:28:34PM -0400, Nicolas Pitre wrote:
>
>> However I was hoping for a current time trickery solution that could
>> live in test-date.c instead of interfering with the main code in such a
>> way.
>>
>> Did a quick test to override the library version:
>
> Thanks, that is a much better solution. And I don't know offhand of any
> portability problems in overriding the library at link time.
>

Microsoft's compiler and libraries? MacOSX?
