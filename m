From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 6 Apr 2009 14:41:26 +0200
Message-ID: <33f4f4d70904060541s6dfb7e8ctf50f5e8a872ae1c@mail.gmail.com>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
	 <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Users List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 14:43:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqoAH-0006gy-LZ
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 14:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbZDFMla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 08:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbZDFMla
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 08:41:30 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:36195 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbZDFMl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 08:41:29 -0400
Received: by fxm2 with SMTP id 2so1864048fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+tdrt8QIXsYH2FSD8bVptri59X7xxjwRtEEo/wdKalE=;
        b=bnUHPL6XRAT2L6zI6/9H0SGWRFddJDL8++eq9upVYKU+6c3e4S28WOPas/OLnMd7R/
         Lz6EP+q3BS48HwUijc6L88VYl+CEYwxxs5qRWVV0R1AivXt2DyKD2N1OKSIZPkIUVsUY
         ArZN31b0dF02REG+d3kLsetlSOmlSkw1XG24I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rW+L/iqlXltHZ3yS1fCHPspOUUFXPcCG4K5JNqQNZeBy4TXOQRN8In13s0yUYld22+
         v2SHhwOeIw+lqkL+pXzFlTKt2aaA4zfpcGbgrnYhattWDA/vMJtFXqA7FIvApTE08Hry
         UgEBruRZKfDPPTZs1/SJCKjeDNCvxJ2NrXkhk=
Received: by 10.223.112.202 with SMTP id x10mr3702270fap.68.1239021686737; 
	Mon, 06 Apr 2009 05:41:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115813>

Hello

Thank you, but I don't understand the answer. If I mistakenly publish
a tree that contains secrets and someone manages to fetch against it
before I correct the mistake; how does the limitation to only fetch
named references help me???

By the way: I don't use push. I'd be perfectly happy if just fetch
supported SHA key references.

BR / Klas


On Mon, Apr 6, 2009 at 2:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 6 Apr 2009, Klas Lindberg wrote:
>
>> Is there a way to fetch based on SHA id's instead of named references?
>
> No, out of security concerns;  imagine you included some proprietary
> source code by mistake, and undo the damage by forcing a push with a
> branch that does not have the incriminating code.  Usually you do not
> control the garbage-collection on the server, yet you still do not want
> other people to fetch "by SHA-1".
>
> BTW this is really a strong reason not to use HTTP push in such
> environments.
>
> Ciao,
> Dscho
>
