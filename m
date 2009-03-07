From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: allowing aliases to override builtins to support default options
Date: Fri, 6 Mar 2009 21:57:08 -0500
Message-ID: <76718490903061857y5446098by3633559697508c2e@mail.gmail.com>
References: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>
	 <alpine.DEB.1.00.0903070336200.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 07 03:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfmkJ-0002rE-4f
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 03:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbZCGC5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 21:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbZCGC5L
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 21:57:11 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:52935 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbZCGC5L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 21:57:11 -0500
Received: by rv-out-0506.google.com with SMTP id g37so778184rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 18:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PwqKkj1xiyZHECvG46gJrtNdxGOtpjayJ9aAKnLHTw0=;
        b=OTgSwoxfjFOIP8S1KoIJMAxS2kxTJWERILF+UITXWEvWaYRWPdHzrreW4PY6KD525j
         G5wT3xxmF/7sYajLhky2a9uHvhF+wpHaTFGnbhtKFtnUBQlo9IGavT42RbdRqQQU85UA
         ubHyKuhalnBTJkpe0QNULvcfE168kpvkju6vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LFKFKJnWBPsTGn3S58g9+nNQWRHFvdG9FUaBqod8ZqUka8gh22txTrwrOiOS6jkVUY
         kAcJbcm5Xh4p4BvW6+vAwV9iMratOvBBi8lrWWF/7Vf9QJuCBchasCdMwXXll4yCm3a0
         BQnIdcFI/AeWVZbvwDQX3qFac4LnFstAudb/Q=
Received: by 10.141.137.8 with SMTP id p8mr1632600rvn.27.1236394628994; Fri, 
	06 Mar 2009 18:57:08 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0903070336200.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112510>

On Fri, Mar 6, 2009 at 9:37 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> What you dream about breaks a lot of scripts.

I said I understood the implications.

> So while it might be nice for you, you would make life of others much=
,
> much, much harder. =C2=A0Not nice at all.

This is not something I am dreaming about, and I'm only interested to
the extent that it improves git w/o hindering existing users. I'm
certainly not aiming to be not nice to anyone!

=46or example, what if:

1. The aliases applied only to porcelain commands, not to plumbing.
2. The aliases worked only if stdout was a terminal, using the same
method that git uses for detecting when it is okay to start a pager.
3. git took --alias-builtins and --no-alias-builtins just like it
takes --paginate and --no-pager to override (2).

j.
