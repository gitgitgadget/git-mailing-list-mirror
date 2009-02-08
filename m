From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: checking sha1's of files
Date: Sun, 8 Feb 2009 07:57:52 -0500
Message-ID: <81bfc67a0902080457k65988e5bw8a33ea8aff2c0c2f@mail.gmail.com>
References: <81bfc67a0902080139j1331d967g34bfc18f4068e443@mail.gmail.com>
	 <7veiy9z1v8.fsf@gitster.siamese.dyndns.org>
	 <81bfc67a0902080253x5082201co7da3319b8237f5a0@mail.gmail.com>
	 <20090208111343.GC14359@coredump.intra.peff.net>
	 <81bfc67a0902080422s7f12d86ft5196c184c06385f9@mail.gmail.com>
	 <20090208122731.GA24442@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 13:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW9Fp-0001bH-I7
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 13:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbZBHM5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 07:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbZBHM5y
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 07:57:54 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:20720 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbZBHM5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 07:57:53 -0500
Received: by qw-out-2122.google.com with SMTP id 3so885725qwe.37
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 04:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SRNNN0IalXdPjjujS3JGc5Qa4LQ3IJj0rAJkOPFN0Uk=;
        b=UWQYnQC/tshyeOzFaM7CnBux41lvc+SGLiHTF9zJndd+/OngyuXKB7F0fBEsRsuO0H
         b8a+FqFVYzmfBSMwiYZ2uXGWAyA0jMVBYnlbzC2wr95TOcTRCzHcggoTL3Ci0r0jNN2v
         TOoWrDvbULfSFX0qOEQ3ny/BQStnSCILJL5LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KHy2fZWv6FdLuT1CzYJRTRSbGdCuxrzGF0cILUFCksia0qMDTRfOTdzKdkVOboOA/9
         krtLQL7oUzyPBcD/52d+P5vSTXHCsLS1yQL9Ux4fhfwEJb3OjYDMBHaghGWAIlT1VFFW
         KKuadIaeYXvn1wOQBE3t4Kyb8NXV4UIYAfxLY=
Received: by 10.229.98.203 with SMTP id r11mr996414qcn.17.1234097872780; Sun, 
	08 Feb 2009 04:57:52 -0800 (PST)
In-Reply-To: <20090208122731.GA24442@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108972>

> If you want to know whether a file matches HEAD, just do:
>
>  git diff --quiet HEAD -- $LIST_OF_FILES
>
> which will return '0' for no changes or '1' if there are changes.

*headdesks* and somehow I think this is exactly what I need.

> Which really has nothing to do with hashes at all (though git will use
> them internally to avoid actually running a textual diff at all).  I was
> assuming that you didn't necessarily _have_ the git repository at
> verification time. So the hash becomes an easy way of saying "this is
> what the file _should_ look like".

I love git because it's so powerful, just like the rest of *nix. No
matter how long I use it something always makes me feel like a n00b.

the problem is that I only half understand what git is doing, just
enough to attempt a communication of what I want to do. It doesn't
help that I'm not the expert on the other side of this problem either.

thanks for the help guys, even if I do come off like a moron.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
