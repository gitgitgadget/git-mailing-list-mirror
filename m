From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/3] sequencer: add "reset_almost_hard()" and related 
	functions
Date: Tue, 4 Aug 2009 15:03:11 +0200
Message-ID: <c07716ae0908040603t12daa900l18178770a17780b1@mail.gmail.com>
References: <20090803024023.3794.90748.chriscool@tuxfamily.org>
	 <alpine.DEB.1.00.0908041443310.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 04 15:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYJfn-0004mm-JF
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 15:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbZHDNDM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 09:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755480AbZHDNDM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 09:03:12 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:36699 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478AbZHDNDL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 09:03:11 -0400
Received: by fxm17 with SMTP id 17so3255932fxm.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 06:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VkvtPLCec//BQSzMvFR6nrH7NWfKAztLG4ujCadIDQg=;
        b=XALlgOLxs5EmJTRmnMNSZ1mXbnIaMuXWPBMoJ8sI23bDmMcf50VTxPBQEdnVO+ncRg
         W5sIa3hHc1nthsD+Ppd+3mSfpekqyVa4C2JHXbRmtjQ/P28bvPpLx94e0HxGt2zLTZuE
         N75C7/GLw59TvqtxUIaI/lssIa1t4e/gSGW9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BwLeKRhPwvH3maPAaaJTMXdE+gFtx0OUZClZLyZUYhzJweIy7RyETHTYR3lcC4O3O3
         Y7bNKMUv3kggI4lBmei+tzX+eOvHA966oBWKJyo6y8sTwCzYlTTpT+v51xZ417qqS8Wm
         aMaRIZOrAXkGcZbMCciyz6DpmdZJGzvD4+Nys=
Received: by 10.103.167.14 with SMTP id u14mr2668169muo.94.1249390991288; Tue, 
	04 Aug 2009 06:03:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908041443310.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124785>

Hi,

On Tue, Aug 4, 2009 at 2:45 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 3 Aug 2009, Christian Couder wrote:
>
>> diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper=
=2Ec
>> index 1dda525..82a830d 100644
>> --- a/builtin-sequencer--helper.c
>> +++ b/builtin-sequencer--helper.c
>> @@ -2,16 +2,95 @@
>
> I do not have that file in my tree. =A0Yet your 1/3 already expects i=
t to be
> there.

This file is in pu. One of my previous patch added it.

> Well, I guess I will work on finishing my rebase-i-p branch next week=
, and
> then see what is there in Stephan's repository, and ask him why he we=
nt so
> silent (after all, his code should have been polished =A0enough to be
> included 11 months ago).

Stephan started to work again on his repository a few days ago. He
integrated some of the changes I posted to this list and some
information about what is left to do to complete his work. That will
make it easier for me or anyone who wants to work on this. Thanks
Stephan!

Best regards,
Christian.
