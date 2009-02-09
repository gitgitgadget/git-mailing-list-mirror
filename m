From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: Trouble testing out a patch on a branch new scratch git.git 
	repository
Date: Sun, 8 Feb 2009 18:59:34 -0800
Message-ID: <e38bce640902081859o47462a58s59c120209fabb0@mail.gmail.com>
References: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com>
	 <7vy6wgwqjp.fsf@gitster.siamese.dyndns.org>
	 <e38bce640902081613v3e93c1e3g716118c38ce861ab@mail.gmail.com>
	 <200902081918.35665.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 04:01:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWMOM-0006Gd-Ex
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 04:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbZBIC7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 21:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbZBIC7g
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 21:59:36 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:55623 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbZBIC7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 21:59:35 -0500
Received: by yx-out-2324.google.com with SMTP id 8so649508yxm.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 18:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ep5a/wXWPFabSl6e1dk+xPTk/RGao7xGrQcb5HfwMss=;
        b=ltaCqO1BLKMp1Kc55kWNdBDB/wvTDRc0vQp23sggPOi4BZmRDI3NB0oo/nR1QTPrcb
         0Be7tIFBrcc0yNUroUDIsYwSBe2mrivN/WPlY90cQpZuiHlqla6wJOtGcUMO9Git9zEW
         /U4GCry1HVv0bUzaRSBJb0VJQNFgVqcUoi2eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IlcD2m1QQpJ4ZeG7lmeohhHmh0Hi+xR7jMQjhdGRp0BxvSjhrFHNJ43KtbHva88uQh
         6y5vdaD1Bodrn11vbfIpfQOQPJ92inN+XZ615uDsKF7SCtiKlMcUacXAh0J84ocS0V4x
         u6Y3lGocejFki1+f++5tN6mL4ayyZzuUCZzIo=
Received: by 10.90.120.14 with SMTP id s14mr356361agc.20.1234148374124; Sun, 
	08 Feb 2009 18:59:34 -0800 (PST)
In-Reply-To: <200902081918.35665.bss@iguanasuicide.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109040>

On Sun, Feb 8, 2009 at 5:18 PM, Boyd Stephen Smith Jr.
<bss@iguanasuicide.net> wrote:
> > What do you mean by "reorder, squash" mean here? Is that something
> > that is done as a part of the -i option to git rebase?
>
> Reordering and squashing can be done via rebase -i, but it's basically just
> the practice of "prettying" your changes.
> http://magazine.redhat.com/2008/05/02/shipping-quality-code-with-git/ has more
> prose on the subject.

Thanks Boyd.  I made the mistake of using git revert HEAD thinking it
would just delete that last revision, but it instead added a new
revision that acted as if it just reversed the changes.

What I really want to do is simply replace the last two commits on the
branch with one commit, so that when I make my patch it will be just
the full set of changes and not a lot of noise. Is there a way to do
that? (note: I did try the git merge --squash command but it just
showed me the usage, as I was on my bg/no-progress branch).  Note that
I know that I would not be able to do this once some of my changes had
merged upstream.

Thanks,
bgoodr
