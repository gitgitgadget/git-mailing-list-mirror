From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git cherry-pick --continue?
Date: Wed, 10 Feb 2010 23:23:29 +0100
Message-ID: <fabb9a1e1002101423y79460afdn2bc31b117195ef42@mail.gmail.com>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com> 
	<20100210210419.GA7728@coredump.intra.peff.net> <20100210212408.GB7728@coredump.intra.peff.net> 
	<7v63644uoq.fsf@alter.siamese.dyndns.org> <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfKyQ-00026n-CL
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756635Ab0BJWXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 17:23:50 -0500
Received: from mail-px0-f184.google.com ([209.85.216.184]:40671 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0BJWXt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 17:23:49 -0500
Received: by pxi14 with SMTP id 14so295510pxi.20
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 14:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vokWuxTRg8Q/U0d9r9EyCGN9Ml04k69w2PUFyngpCyg=;
        b=tmtKkmJcMTTY5iNN70pHoyg0JTdiMbM/tvbBIrB1KvKQJVB4sYXHr9std3XGvnZvlV
         kXQtU3sxcSSywiY248tYmcr5yxw0T/osF/dfiUuOmkb4XkFWDfCSvaj2DaKBvUvyweyN
         ZVTDYd+dehdfGHz5mNKEXvgczl7d04arzTheM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Y8U99pWpGbz5gzJYuCiBynJN7UZuqCBP3KN0g1c2+/dU3hQmVmpI2VkXeIfEeSTaQT
         oZ6cMUqr/MgIxn8n+KacxNbnTfPd4oEc5D/f32oHsYSp706pG+Vi/jWfNcGVmdIVxWg6
         Pagj7kl7o0I129D6BSXBIATKavo4yNDbRjNGA=
Received: by 10.142.75.3 with SMTP id x3mr536379wfa.340.1265840629075; Wed, 10 
	Feb 2010 14:23:49 -0800 (PST)
In-Reply-To: <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139561>

Heya,

On Wed, Feb 10, 2010 at 23:21, Junio C Hamano <gitster@pobox.com> wrote=
:
> Having said all I did in the previous message, I think "am --continue=
"
> would be a good addition.

How about 'cherry-pick --resolved' though ;).

> And "rebase --resolved" would not make any sense if the reason the co=
ntrol
> is given back to you was because you ran "rebase -i" and marked a com=
mit
> to be "edit"ed. =A0Of course, we could add "--resolved" and "--edited=
" (or
> perhaps "--amended") to "rebase", and have it make sure that the corr=
ect
> one is given. =A0For example, when it stopped for "edit", it would re=
ject
> "rebase --resolved". =A0But I do not think it is worth the hassle.

I don't see any benefit to that, in fact, I'd recommend against it.

--=20
Cheers,

Sverre Rabbelier
