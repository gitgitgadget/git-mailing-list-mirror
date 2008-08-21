From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 13:07:14 -0400
Message-ID: <32541b130808211007xf295e40l567ecf785a8fca22@mail.gmail.com>
References: <48ACB29C.7000606@zytor.com> <48ACB5F4.3000905@sneakemail.com>
	 <48AD99DF.5090802@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?\"Peter_Valdemar_M=F8rch_(Lists)\"?=" 
	<4ux6as402@sneakemail.com>, flucifredi@acm.org,
	"Git ML" <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWDe5-0001a4-SW
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 19:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbYHURHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 13:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYHURHR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 13:07:17 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:56296 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbYHURHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 13:07:16 -0400
Received: by gxk9 with SMTP id 9so349260gxk.13
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jnwCVcDL2Z38Z91gicBJAva6roWve0f5w2hA2eGex3I=;
        b=woOcO6Idkd3u/5afW+D5UA2GarKobP8dUWo6E2c1hYN5uiZgh7QFjxdgjUNA8R/OL4
         rzX8G4TxAGVjdHEV/7dElxPrCsRMIXQAzGPEUuTBB/dXwRvIqM5R3CVoLqGBP5To9A9T
         yEYWMI1PXCRxHXN5TBku6pytNvb0APRfOsz4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=scpCJeVf1PmVl9Jup33/VxkpThvmKf4duPjz6Y/EwqsN30Y45i9nTEZb4owVL6BACo
         yhwhmko96BjlPR4yzNd6fuBmnW7BIbU9nMi+X04qcvy/anxTOOUyPKU/YlgcMM8ETK69
         SLUCKbv0wGQ5Fg7emvXbueGsWANQfShjUot/w=
Received: by 10.150.181.11 with SMTP id d11mr80358ybf.217.1219338434199;
        Thu, 21 Aug 2008 10:07:14 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Thu, 21 Aug 2008 10:07:14 -0700 (PDT)
In-Reply-To: <48AD99DF.5090802@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93177>

On Thu, Aug 21, 2008 at 12:37 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> man git clone
>
> [...]
>
> I doubt you find *anyone* who relies on the current behaviour, so I am
> suggesting changing man.  That's why the man author was on the recipient
> list, but you removed it.
>

[and I put him back...]

Unfortunately what we don't have is a proposal that would work better.
 Also, changing the behaviour of 'man' wouldn't work on any platform
other than Linux (presumably), which means the git documentation
wouldn't be able to rely on that behaviour.

Still, in a perfect world, what *should* man do in such a case?
Automatically open /usr/man/man1/git/clone.1?

Thanks,

Avery
