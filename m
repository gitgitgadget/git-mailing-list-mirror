From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Completion of error handling
Date: Tue, 2 Feb 2010 16:27:29 -0500
Message-ID: <32541b131002021327u29e666b8ia5c6aab25fb55688@mail.gmail.com>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home> 
	<4B6873AC.4030303@web.de> <alpine.LFD.2.00.1002021424550.1681@xanadu.home> 
	<4B688042.8090400@web.de> <32541b131002021149g6ffe703erd9e25621e4305a52@mail.gmail.com> 
	<4B6886CE.9040602@web.de> <32541b131002021225k19ef94b2me8ef40cd502b85d@mail.gmail.com> 
	<4B68989D.80906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 02 22:27:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQHt-00089J-Jn
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740Ab0BBV1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 16:27:50 -0500
Received: from mail-gx0-f228.google.com ([209.85.217.228]:57133 "EHLO
	mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756712Ab0BBV1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 16:27:50 -0500
Received: by gxk28 with SMTP id 28so544357gxk.9
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 13:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=IECkZYCDzfmM86zFdT2s4569eQiBSNEbgd5JdhTySpw=;
        b=V8UPVwSaM9kdyPRj/dJiNHMTCDO/Md9DUbdsrX6u7qehjCn2cKUBt8YCcWcNlpud8X
         lax8rdyWdlcrnQkTzCYpFzHYbSRh1pRUctX637u5DlYRHhBT2WKgejQY+LRKQgmgsQQt
         Szkk/rjGdtwRyjIzo2vFwh0vDY2QlK1E5LzS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=NBk15MakvkTLbrYB2lTUv5BDc7etJgDSOXpGC3CspRDQeLnmPBhb15uF4fp5/KiJv3
         CX/6vIMwr5N7wiHiHlwashnTBS08GrY1Nwc+92/0f2tArxs6oUmYqqRR/oNVrbhdd+pY
         dD0VGMfz3LM52CJDpsnHugY/F0bbCK3qVZcsM=
Received: by 10.150.4.26 with SMTP id 26mr9658052ybd.0.1265146069084; Tue, 02 
	Feb 2010 13:27:49 -0800 (PST)
In-Reply-To: <4B68989D.80906@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138760>

On Tue, Feb 2, 2010 at 4:26 PM, Markus Elfring <Markus.Elfring@web.de> wrote:
>> ...then it will be easy to get people to accept your patches to fix
>> the error handling.
>
> You do not need to make assumptions about error situations. Please check
> all error codes.
> Otherwise, it might not be noticed if anything unexpected went wrong.

If you never notice, then that's a good thing, right? :)

Avery
