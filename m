From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] rebase -i: use "git sequencer--helper --reset-hard"
Date: Sun, 2 Aug 2009 23:30:57 -0700
Message-ID: <fabb9a1e0908022330l6d0ab44fwc1b6454ba67c9af1@mail.gmail.com>
References: <20090803024023.3794.6487.chriscool@tuxfamily.org> 
	<fabb9a1e0908022158g2578071ewd44bc8d730fb2b8b@mail.gmail.com> 
	<200908030829.21424.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 08:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXr4w-0001e7-GX
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 08:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbZHCGbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 02:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbZHCGbR
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 02:31:17 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:50461 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbZHCGbR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 02:31:17 -0400
Received: by ewy10 with SMTP id 10so2791664ewy.37
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 23:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3Xms6NwuLw00o/oS8R6MwFMYHINmUstgFSZ6bcaWbCA=;
        b=pkb8FvbdB9Cg2OKR+0znb7RZbvO1/SST9B/XklrVREN7F1/SKeId0EVM3habaRVPUi
         l3p01JVuThsH4nfl7/Q0NRpfLGOi3CW+tlAIHH0Dit/QEZqJKVut7eDz7chlUP6DVoWD
         Mkh0nX/hNHDdlJmZqmTFxZA/Jmu2GSNECQLa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lr5RMubj4VZ9ZVQ2p7hRgOGuPhjAxIVdFDWfTKGp27HE7gsADJjO40yjk1VQXNfw1D
         3yYIOU5EU1UBH4Y2lCPabVOP7Yl6FWszaEJmea30qRldJPGWNhkfphw4uQqdDRPP6VlK
         HRsk1lVl+ksYVSslaXnUwbDb4bkHdfXikBSkA=
Received: by 10.216.71.82 with SMTP id q60mr1151481wed.169.1249281077142; Sun, 
	02 Aug 2009 23:31:17 -0700 (PDT)
In-Reply-To: <200908030829.21424.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heya,

On Sun, Aug 2, 2009 at 23:29, Christian Couder<chriscool@tuxfamily.org> wrote:
> This is part of my work to port git-rebase--interactive.sh to C using code
> from the sequencer project. So the advantage is that it introduces and uses
> the reset_almost_hard() function that will be used in the end when
> everything is done by C code.

Hmmm, that almost makes sense, but I don't see the new C code
replacing any existing shell code, so what am I missing here?

-- 
Cheers,

Sverre Rabbelier
