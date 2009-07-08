From: Eric Raible <raible@gmail.com>
Subject: =?ISO-8859-1?Q?Re=3A_Schr=F6dinger=27s_diff?=
Date: Tue, 7 Jul 2009 17:17:21 -0700
Message-ID: <279b37b20907071717r71f982b6u7333ff10fadfc39@mail.gmail.com>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
	 <alpine.LNX.2.00.0907071316490.2147@iabervon.org>
	 <20090707193605.GA30945@coredump.intra.peff.net>
	 <7vtz1o9sv6.fsf@alter.siamese.dyndns.org>
	 <20090707195406.GA32131@coredump.intra.peff.net>
	 <7vfxd89lqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 02:17:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOKr3-0000b3-Al
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 02:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757886AbZGHARY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 20:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757878AbZGHARX
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 20:17:23 -0400
Received: from mail-vw0-f199.google.com ([209.85.212.199]:60183 "EHLO
	mail-vw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757827AbZGHARX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 20:17:23 -0400
Received: by vwj37 with SMTP id 37so81058vwj.33
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GEBW9Y9+xlJRAnSv7NeSz8fz8pyRrzHu1t7eamuP2jI=;
        b=fhlDjmTizz5TwwNOanDX5+o3G5CraZahTpuhTYcpoemwUN0ETbKrrQaFazvxJ6LgJv
         pG4oSXByOFqcgcGaMt8fvdUm2wbJ/kRIYN4rXSZQ806HE1Mj3sdbhXCxo2p06wnDWlv9
         g+MqPDytoTZMx37cNtlPdHSqcUYQIqIPfgEH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u6npee9qng3Ls6aCh44zpx5DpzoqOzHJek71j+KQAP65CN40nOanIPtmRdSM35XBfX
         dycRqhSMXu9Th1MK+LBL7olwJWUnBQY61YzvXAtnT/ZfrQvWgw5oA6+d+SzgGpFuji0I
         z4DqRfM/zKEvzSBpYPTKLyPw11eSXxPAaFqhE=
Received: by 10.220.96.15 with SMTP id f15mr13079586vcn.116.1247012241792; 
	Tue, 07 Jul 2009 17:17:21 -0700 (PDT)
In-Reply-To: <7vfxd89lqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122883>

On Tue, Jul 7, 2009 at 3:22 PM, Junio C Hamano<gitster@pobox.com> wrote:
> You notice
> that you screwed up the configuration to use your peculiar work tree
> representation, and you fix it once and for all.

A kinda dim-witted question:

So what's the best way of "fixing once and for all" a repo infected with
carriage returns when you want to use autocrlf=true moving forward?

And a hopefully less annoying one:

Would you accept a patch explaining how "git reset --hard" doesn't
actually rebuild the index from scratch, and how "git read-head" might
be recommended in some weird situations?
