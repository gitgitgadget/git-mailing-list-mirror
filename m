From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Sat, 15 Aug 2009 19:30:58 -0700
Message-ID: <fabb9a1e0908151930g6e1df244r4ea515fad1e70c1e@mail.gmail.com>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com> 
	<1250226349-20397-2-git-send-email-srabbelier@gmail.com> <7vab22ubr5.fsf@alter.siamese.dyndns.org> 
	<7v7hx6suiy.fsf@alter.siamese.dyndns.org> <7vprax4yzd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 04:31:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McVWo-00024D-U3
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 04:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbZHPCbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Aug 2009 22:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbZHPCbS
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 22:31:18 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:45133 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbZHPCbR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 22:31:17 -0400
Received: by ey-out-2122.google.com with SMTP id 22so506658eye.37
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=uqFSiMshbGEufYmA4D7duwePXnkFeNeAR9lgOEAVTe4=;
        b=HwYjB6SUDBjwF5no/ySfmSAXveiG9gU9aOyePInlALod0eR4HCR8cCvHFot7PAXRuA
         06FMVScWORpaDRrfUZXsMz0EWQml9QoBO9nm64rKJkcgBupJjqd9cM4ehJvjfcm6Zdrr
         NtFvvUUQV4Mn3tvQH+PTsuADvwFW38egYzPYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=j8BGIltsQPu5/wvvFFMr/0big36BhVBZmfKopSFS33NHnmUhFwekzlp+NsJMHqF7R+
         aolwXPfB5ED6H6VIwwCxHjGWLRb+Z5G6NsF9lvjnlzLqZNVLqtIRnXhurqPana8/Xrxc
         rB4/aR9tk0hFaNAwMmOx/zlWZBSDI1GeY6cms=
Received: by 10.216.11.72 with SMTP id 50mr725419wew.64.1250389878091; Sat, 15 
	Aug 2009 19:31:18 -0700 (PDT)
In-Reply-To: <7vprax4yzd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126048>

Heya,

On Fri, Aug 14, 2009 at 19:01, Junio C Hamano<gitster@pobox.com> wrote:
> As we discussed in this thread at length, #2 is on the borderline. =A0=
It
> makes sense if you take only --delete out of possible vocabulary, but=
 when
> you think about it as a part of a coherent whole, it becomes somewhat
> iffy---it does not fit particularly well with other parts of the syst=
em.

I do not particularly care either way, I'm willing to implement
whatever we decide on, and if that's nothing at all" that's fine with
me too :).

--=20
Cheers,

Sverre Rabbelier
