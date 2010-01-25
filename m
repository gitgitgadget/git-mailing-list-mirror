From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 18:57:06 +0100
Message-ID: <40aa078e1001250957h292f8b01me8f7dec4ba2b425b@mail.gmail.com>
References: <201001250155.47664.robin.rosenberg@dewire.com>
	 <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 18:57:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZTBd-0001O2-V3
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 18:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab0AYR5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 12:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754185Ab0AYR5K
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 12:57:10 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:36233 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab0AYR5J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 12:57:09 -0500
Received: by fxm20 with SMTP id 20so3825634fxm.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=pDFWxmhPSYeT3A36aMPNgt3GlDnQhi+gwfYGKEEs4Jc=;
        b=OgbafAeQ1xHle8C3rUiR2BdtSOfYexyEi7kHWvzXna/3uV5qzlBFyAndD0BNYK3RyS
         ypMXkdkvDa4FN8t4GMlzj06DNEyGr5KZtoUErjKiJ6Al1Z1PYMPOk6j191AeCXAYBL+S
         DAqp6rXrPcQHFlC5gdIG4qtE/4E4S6bh5ejm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=jDNUiqs0V2T/H6IRXMFKyP64mJJyBrzZnrTqbz+N0zovjkcxSWEwUj++6hI/wospxr
         vfYw77gwQB7ueRcawZNBffsUYKgtt/KmFSWrOH9RQZm3IMDrmADqeLe4/zL6WV6G9O19
         6UoHWrA0ux0QxswL6tz5sjZLPzTKmJCLn1Tbw=
Received: by 10.216.87.66 with SMTP id x44mr874795wee.96.1264442226509; Mon, 
	25 Jan 2010 09:57:06 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137973>

On Mon, Jan 25, 2010 at 6:34 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 25 Jan 2010, Robin Rosenberg wrote:
>
>> >From 37a74ccd395d91e5662665ca49d7f4ec49811de0 Mon Sep 17 00:00:00 2001
>> From: Robin Rosenberg <robin.rosenberg@dewire.com>
>> Date: Mon, 25 Jan 2010 01:41:03 +0100
>> Subject: [PATCH] Handle UNC paths everywhere
>>
>> In Windows paths beginning with // are knows as UNC paths. They are
>> absolute paths, usually referring to a shared resource on a server.
>
> And even a simple "cd" with them does not work.
>

But it does, at least for me - both in bash and cmd.exe. I just need
to log on to the server first, unless it's a public share.

-- 
Erik "kusma" Faye-Lund
