From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write failures
Date: Wed, 6 Feb 2008 20:25:01 +0000
Message-ID: <e1dab3980802061225l21cc35b5u288695924f56f3ca@mail.gmail.com>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
	 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
	 <e1dab3980802061110p2c1dad1ep8a46eeda93839bb9@mail.gmail.com>
	 <alpine.LFD.1.00.0802061420510.2732@xanadu.home>
	 <e1dab3980802061202i39c42432k4dd9f95560a7ea62@mail.gmail.com>
	 <alpine.LFD.1.00.0802061511440.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Steven Tweed" <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:25:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqpy-0000r6-4T
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbYBFUZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755721AbYBFUZH
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:25:07 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:25657 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbYBFUZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:25:05 -0500
Received: by ti-out-0910.google.com with SMTP id 28so327925tif.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 12:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CaWyJ8jAPcHWaADWr9qVkA+diCTqEJ22jQbBoXlhH+E=;
        b=vWFMulL1TY57v7rENLqxPTSZlV/hE3DpTrRxTNdIq5QOpYszvIpWstlJvEe14Ip1lDJUnQv9WdlCwh79/GT2MFWHgqEeW9UJS9Wxkib/YXpbJ1YNhHHF1xpuq+Iu/DhgjJwwUuiXaUVByp3Uy402dX/g+YVzxKoJ+cX/2mhemP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kSdqaAeECaeGvamv7Ar5bT9We9HLqdPUQQG0L0+h7EUt4qmaB4fG3jD5RhJ/FycIMNPelhtrw3pDqmBDodg/If48AsyuZdTNzCcBkuN49dY6+T5+hKjWR8bCncpMOcG1MGuhZ42I5PzhqA9mtyVpw16PTgAJkX1jiA893nhSKwE=
Received: by 10.150.157.11 with SMTP id f11mr4378569ybe.54.1202329501606;
        Wed, 06 Feb 2008 12:25:01 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Wed, 6 Feb 2008 12:25:01 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802061511440.2732@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72843>

On Feb 6, 2008 8:16 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 6 Feb 2008, David Tweed wrote:
> > Ah, I hadn't realised this was an intended usage of --expire. Since as
> > you note there's no way to tell an abandoned tmp pack from one that's
> > in the process of being written, following expire is probably
> > necessary for safety. I'll look at adding support for that.
>
> Did you miss Johannes ' patch?  He posted it yesterday and you were even
> CC'd. It did exactly that on top of yours already.

I had missed it (I've only just started reading email). Thanks for
pointing it out.



-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
