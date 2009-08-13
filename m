From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-cvsimport: add support for cvs pserver password 
	scrambling.
Date: Thu, 13 Aug 2009 13:04:58 -0700
Message-ID: <fabb9a1e0908131304m53ab2a68p9faade35969add5@mail.gmail.com>
References: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com> 
	<20090410093434.6117@nanako3.lavabit.com> <7vhc0udiac.fsf@gitster.siamese.dyndns.org> 
	<alpine.DEB.1.00.0908131837110.7429@intel-tinevez-2-302> <4da546dc0908131219q149844abi453d8429847af1cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Dirk_H=F6rner?= <dirker@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbge6-0002cO-6F
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 22:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037AbZHMUFg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 16:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756019AbZHMUFW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 16:05:22 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:54515 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbZHMUFS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 16:05:18 -0400
Received: by ewy10 with SMTP id 10so1054872ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eIPm4tLqc23bmdBMcAM0AqkvccGNp8FV1WrUeemm8jM=;
        b=d1QepWb6O4vzyVNj2vNHOMwcM4wYRJtgvEicMZ/B2kViEIUY8004OL9LCEoBVT9wlt
         2IvNIgCYJeKnXKIe0pWDAB20xNR1BpCoSd9/2jmicP9gKUy9gKiviSldO21X9DAm6KZg
         nnTsAA4tN9UG+O31vnMhQGuzm9Bm31N/BM9fY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vtGHFmSQkh97XYPu29IN0H51mrxS9sg1UhKYNXr+pMZoKNg3pa9ys8KRQ9QVilaykV
         TmZDbpNUPtJJ6jvBJ7vFje+HN9gG64fIWZCnV7SRxJ1Zcsf4IG3pYEhQQYLLElytqLAR
         8qBajQwYqmTWixItFvzgjWgzZb9fStgDVVdtU=
Received: by 10.216.85.203 with SMTP id u53mr237603wee.86.1250193918106; Thu, 
	13 Aug 2009 13:05:18 -0700 (PDT)
In-Reply-To: <4da546dc0908131219q149844abi453d8429847af1cf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125864>

Heya,

2009/8/13 Dirk H=F6rner <dirker@gmail.com>:
> sorry for the long delay, but I finally sat down, hacked two testcase=
s
> and amended the patch after rebasing to the most recent HEAD. Find it
> attached to this mail.

I think we'd rather find it inlined, as per SubmittingPatches ;).

--=20
Cheers,

Sverre Rabbelier
