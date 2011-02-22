From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to recovery a corrupted git repo
Date: Tue, 22 Feb 2011 11:16:23 +0800
Message-ID: <AANLkTi=_nn84FcvvkhiKUJgVG4EkyYWoUYLctarh7a9L@mail.gmail.com>
References: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
	<20110221100454.GM22168@axel>
	<vpqpqql1lw6.fsf@bauges.imag.fr>
	<AANLkTim-O+LR_r=N6y7Dcip8xQGcBVP2FiVhu22Zhysf@mail.gmail.com>
	<vpqipwds8uh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 22 04:16:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prijk-0002vv-PI
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 04:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab1BVDQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 22:16:24 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49403 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab1BVDQX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 22:16:23 -0500
Received: by gyh20 with SMTP id 20so160945gyh.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 19:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dq49YBiLKK+dA0oqs19GCNINTbEoDwq6SKPCRMsJJhE=;
        b=WDpVLmtWDq1AaaP2V0huBHjwiGlCkS51T7ccTshIJdUSBHjAfywYFQxoFFN2z3PwrO
         ubCFHKrzdEWnz9UQKgWyuJovy5YUXqnnELQGyRXwYms2IHnUQAXXU8j9ZIBKA2FNmcXr
         p0Sga/qppcvAYaBk0U+G3NwZeD/0Ib4n3ts9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jHfhTe1u8E2z40l4edhsA08mptrtnFG8bgtUNDv43F+HnzgsiNKE4tz3/eU5qt1iL0
         sO4FyQc2PvRfraB4Z7jFRSx/Vx82rf4okAigCsi/2eTKuaEO2cOhaZtnQn74YKkKhQPP
         MhGiTqQ6VvwrbnPik0OvsuBYljrrFyW6hTet0=
Received: by 10.150.198.11 with SMTP id v11mr2667172ybf.388.1298344583129;
 Mon, 21 Feb 2011 19:16:23 -0800 (PST)
Received: by 10.146.168.17 with HTTP; Mon, 21 Feb 2011 19:16:23 -0800 (PST)
In-Reply-To: <vpqipwds8uh.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167525>

On Mon, Feb 21, 2011 at 11:31 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>> Thanks. This should be an applicable method. However, before rsyncing,
>> the pack should be unpacked first.
>
> No need. Just copying the pack files works too, and is way faster:
>

Great, thanks.
