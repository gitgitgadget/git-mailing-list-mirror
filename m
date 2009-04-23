From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Thu, 23 Apr 2009 16:00:06 +0200
Message-ID: <fabb9a1e0904230700l4c2123w663a2cfba65befcd@mail.gmail.com>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com> 
	<20090422082652.GA32698@gmail.com> <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com> 
	<7vr5zk346d.fsf@gitster.siamese.dyndns.org> <81b0412b0904221340o6b2f1474oed2ad12e4f68cff3@mail.gmail.com> 
	<7v4owgyp8x.fsf@gitster.siamese.dyndns.org> <81b0412b0904230033n35f1117fmea4432a2f2140d25@mail.gmail.com> 
	<7vtz4fwzaz.fsf@gitster.siamese.dyndns.org> <81b0412b0904230252k3e8197d3y8798d5b797a49c39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 16:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwzV7-0001NL-MF
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 16:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbZDWOAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 10:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758534AbZDWOAY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 10:00:24 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:64619 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757886AbZDWOAX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 10:00:23 -0400
Received: by fxm2 with SMTP id 2so556766fxm.37
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=95czmGPpYm29tnwPsxhEqPjYEdR+JRbwTlGEeqb9Pcg=;
        b=Om4TcUV+AdqaarOVYkUAFoTQ6T+fcF8i82lT+O5jrAlXwLD3+CLDDqXNABwLzjQqpf
         RW0Hc8VTxKg+FUdZOwt0Q4zTVpzfq75BBqk7aWu2cRPOyiEi/gU11W7IXtlN7oxlpTdK
         UF5H/2qmVAcWHb4+9Nu2IaZV0rZECqc3+ah8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MY2PKH/0cPsyuvQb6mFJ40Mu0+lKVDoWwia8mmfVzvZIy+fCLbWbkb2pdGc1e/eAqr
         OlMloRD5JwwiqztE6egfGQ98HKU1ehdOBwQBKOHn3h/pZcxpmCkwGEWG4DLXPSTxRCcT
         3H0HQMBW3gFIxoab6KcB8TVlitu+aueQhJCgc=
Received: by 10.103.117.9 with SMTP id u9mr605721mum.55.1240495221056; Thu, 23 
	Apr 2009 07:00:21 -0700 (PDT)
In-Reply-To: <81b0412b0904230252k3e8197d3y8798d5b797a49c39@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117339>

Heya,

On Thu, Apr 23, 2009 at 11:52, Alex Riesen <raa.lkml@gmail.com> wrote:
> None. But it still would be nice if you look at them when you're addressed
> directly. Please understand, maybe I'm abusing the list a little, but it looks
> like the best place to _archive_ the workarounds for this obscure platform.

In that case you should note in your patch (preferrably in the
subject) that they are not meant for inclusion and merely for the that
purpose so that those who are not interested in them need not waste
their time reviewing the patch with the assumption that it _is_ meant
for inclusion.

-- 
Cheers,

Sverre Rabbelier
