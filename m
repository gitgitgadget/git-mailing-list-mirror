From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 19:12:44 +0200
Message-ID: <fabb9a1e0908311012q4cea2d51i2c2f0cbceac0cab@mail.gmail.com>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net> 
	<vpqskf8z0rj.fsf@bauges.imag.fr> <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com> 
	<20090831164146.GA23245@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 19:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiARQ-0003zT-6b
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 19:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbZHaRNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbZHaRNE
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 13:13:04 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:55093 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZHaRND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 13:13:03 -0400
Received: by ewy2 with SMTP id 2so531039ewy.17
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=B0J2ohFZu7XvXFclrq0vlUYJWRgpjy8nqtQSodReHB0=;
        b=s7LGgHtRvkWBJZDo9fNtGy1PIxwvz1L11gWlKbRnKxniiOn+VAx3wuK3A+3LGr8bAp
         YVMteQsBo/H1bSbpyGA5Ac9gnR5lyEFZGvvt41ntjTjBHpiYmDISwcK/6vbr3U0UDt7B
         g0cbp+xAsc/WpmXrPcLX7Sl7rxqSWncqkOWWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oyOa3tBs0M20BUzvwT3mI8akuOQHZFBZcLKvrDZCGoWsuTLJptkIx+m+w73MV4phno
         xnpFO6NFE2HTYw++UlDb3iNMq/zu/Ufyt8gKN78rn3PCFbxcFvjIEk17roNA3mnkAN0k
         7x2ThaJkHCbD0IRS5d541RpcaVGKWazgNiLg4=
Received: by 10.216.85.82 with SMTP id t60mr1063463wee.14.1251738784103; Mon, 
	31 Aug 2009 10:13:04 -0700 (PDT)
In-Reply-To: <20090831164146.GA23245@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127488>

Heya,

On Mon, Aug 31, 2009 at 18:41, Jeff King<peff@peff.net> wrote:
> IIRC, the message you are seeing comes when the _server_ is an older
> version of git. It is harmless, though.

Mhhhh, is it some weird interaction between 'empty repository' patch
and old server versions, or did this happen too before my patch was
applied?

-- 
Cheers,

Sverre Rabbelier
