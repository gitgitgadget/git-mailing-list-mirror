From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Mon, 5 Oct 2009 23:13:35 +0200
Message-ID: <fabb9a1e0910051413nf8581c8vdf01508d59c4e1a4@mail.gmail.com>
References: <4AC8F22F.5070101@gmail.com> <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de> 
	<6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com> 
	<alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de> <fabb9a1e0910050239h614118cfw8a5055e4ed966dd1@mail.gmail.com> 
	<6672d0160910050910x3a9aa6a3w742c09e7f2f42187@mail.gmail.com> 
	<87ab05r5hg.fsf@dylle.kalibalik.dk> <alpine.DEB.1.00.0910052248500.4985@pacific.mpi-cbg.de> 
	<7vbpkl8s8x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Anders Melchiorsen <mail@spoon.kalibalik.dk>,
	=?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muv2C-0004P2-Cg
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbZJEVOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 17:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbZJEVOd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:14:33 -0400
Received: from mail-ew0-f225.google.com ([209.85.219.225]:49804 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbZJEVOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 17:14:32 -0400
Received: by ewy25 with SMTP id 25so3086886ewy.21
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=k4OiX7x7KAT5O1aORdpJzHkW7DIW2M4etYG4imo2+oc=;
        b=B1xowwwUKBR5z67bA0anA3X0Y15br/8T2UopgykB4YJQ/yt7cgaTi793dpVI74zjXn
         2XofY+aPaBEo2ghij1N5CnjP9YoCYPcrb9rUzGo+tJfKp2WY6U/qJHtHlN/EsgiX14Le
         xkfF8bPYoblT123QfkvnbSFMNQpdVPhpvq3B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=RpIQoUeoaEOzJyh3TMA5nENJuKFxDU9ZufNiqLfqyut4JUhRua4jr395AwA0WWGepo
         Re1opxQxuLNwcJiOFk4LepUfI0kWLzU7szucQOlmMx4poSFRWkqih6bfVZbIIRc8fKsM
         5G2GcYoAJ+IoLffxFUlKuEA3GB/D7vEY67i7k=
Received: by 10.216.21.2 with SMTP id q2mr132629weq.78.1254777235122; Mon, 05 
	Oct 2009 14:13:55 -0700 (PDT)
In-Reply-To: <7vbpkl8s8x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129593>

Heya,

2009/10/5 Junio C Hamano <gitster@pobox.com>:
> If the rebase insn sheet were richer, and had a way to show the full
> message, like this:

But that's not what rebase -i's insn sheet is about is it?  It's not
"rewrite my commits so that they are the way I want them", it's about
"change the order of my commits"/squash some/drop some. The polishing
of the commits itself is done after finishing the insn sheet.

> I do not see why we shouldn't allow people to edit any part of the above
> to reword.

Because it then becomes very hard to do any actual reordering. I'm not
saying it's a bad idea, just that it's a bad idea to do it in 'git
rebase -i', conceptually. Although what you suggest would be useful to
me, I just think it should be a different command, git rewrite perhaps
:P. Definitely not "git rebase -i --rewrite-message" though, becaue it
is not at all about rebasing anymore.

-- 
Cheers,

Sverre Rabbelier
