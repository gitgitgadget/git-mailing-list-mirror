From: "Mark Ryden" <markryde@gmail.com>
Subject: Re: white spaces in a patch
Date: Wed, 17 Dec 2008 14:10:54 +0200
Message-ID: <dac45060812170410h20e710b0ted10d46b9b96ac9d@mail.gmail.com>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com>
	 <7vej07p84i.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0812171307460.28560@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:12:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvGM-0004X2-TT
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbYLQMLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbYLQMLH
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:11:07 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:31968 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbYLQMLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:11:06 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1532308yxm.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fKVYXUE560aFQ/R8yXXhunkZQqEfYy9lQ9gpePirlMI=;
        b=EUClFfou4+wHCpggMwZmRw470tk/LzHvehhWUrsBRQoRFksEAKWKp95pI4lDmZ3UVs
         B0xP2CkePINaaFABypHNawByF3Ez4YLwZLFfEP0+g876JxTCBG1aQq0uQEkRg0PXBrYO
         N0ypfumPdtIGJEN+N8vHM7jc3xbEEuoxRY6zE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SPStMhlTdeUdr40sMyg9ISC0f847lPkCg89mYKILWZaTzNhQsE07lrbmmPYMka6BQ/
         GrFMOpsggfAhHddBbW8ZGZyuUhYJMTMgRmLNk71UBC7Cr/AlDZ7HY4o/H9JVl/B9uJ5U
         XRtgNqM0i3LEaXUXOAgTaK0Ce/yw82O3aHWbw=
Received: by 10.90.83.2 with SMTP id g2mr294617agb.79.1229515855026;
        Wed, 17 Dec 2008 04:10:55 -0800 (PST)
Received: by 10.90.26.11 with HTTP; Wed, 17 Dec 2008 04:10:54 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0812171307460.28560@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103337>

Hello,
Thanks!

"git diff --check" indeed tells about trailing whitespace
Mark

On Wed, Dec 17, 2008 at 2:08 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 16 Dec 2008, Junio C Hamano wrote:
>
>> "Mark Ryden" <markryde@gmail.com> writes:
>>
>> > 2) Is there a way to get some messages about that there are white
>> >    spaces when creating a git patch?
>>
>> Doesn't "git diff" highlight whitespace errors?  That way, you can catch
>> errors before you make a commit that has them.
>
> Not to mention "git diff --check", which should catch them, too.
>
> Ciao,
> Dscho
>
>
