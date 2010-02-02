From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Completion of error handling
Date: Tue, 2 Feb 2010 15:25:05 -0500
Message-ID: <32541b131002021225k19ef94b2me8ef40cd502b85d@mail.gmail.com>
References: <4B68249F.6070004@web.de> <alpine.LFD.2.00.1002021324290.1681@xanadu.home> 
	<4B6873AC.4030303@web.de> <alpine.LFD.2.00.1002021424550.1681@xanadu.home> 
	<4B688042.8090400@web.de> <32541b131002021149g6ffe703erd9e25621e4305a52@mail.gmail.com> 
	<4B6886CE.9040602@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:25:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcPJY-0007In-BI
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 21:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382Ab0BBUZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 15:25:28 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:50881 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab0BBUZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 15:25:27 -0500
Received: by yxe27 with SMTP id 27so457959yxe.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 12:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=cSNVDc3ltF2QE+chGAHgEk0IlJVMHVIjejk1MRagsic=;
        b=W1qrPFNuxlFCFJk2bGk8XWjuCScjuLav9Do6/GT2+2aEf6AZRCG4Uh7wUrdwOnhcaM
         TUWgD7iB7pY8R7QNZHo3Z3ZrnxXGIHJ74bmSCSaGyjOcdMwl90a1u4F1nTAy2S2dKfYa
         0+N5cUJLJohuho3fHVnfiBSXg/EcG6GybyLvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=It3/R3ivqMWYGAacsGTyGB4o31xzfro7rll7Gc9CNLE3S6L7rXs+ux6b56jur84BEh
         QcZnDr45RSHMmr2T+7rA9y/zy/4Z4oXu8Mqi0Xnjep+dPWNDBh5cZCvpHm1T1SgWdGiF
         L9XHmzTBIKhTS4fkLjWkKpgMPbP/4WoM1wEUI=
Received: by 10.150.120.7 with SMTP id s7mr9116949ybc.345.1265142325172; Tue, 
	02 Feb 2010 12:25:25 -0800 (PST)
In-Reply-To: <4B6886CE.9040602@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138750>

On Tue, Feb 2, 2010 at 3:10 PM, Markus Elfring <Markus.Elfring@web.de> wrote:
>> This isn't an opinion; because it's open source, you can actually look
>> at the source code and find out that many system calls don't do memory
>> allocation at all.
>
> I agree to your view because you distinguish between the available
> software implementations here.
> Are you also interested to complete error detection and corresponding
> exception handling?

I think if you can demonstrate actual situations where lack of error
handling could cause:
a) user confusion; or
b) data loss/corruption

...then it will be easy to get people to accept your patches to fix
the error handling.  If you can't reproduce or at least describe such
a case in detail, however, people probably won't be too excited about
it.  git developers seem to concentrate more on concrete problems than
theoretical ones.

Avery
