From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees 
	with various fanout schemes
Date: Thu, 27 Aug 2009 19:51:48 -0700
Message-ID: <fabb9a1e0908271951t1f2db976jb1de1e7687ad9791@mail.gmail.com>
References: <1251337437-16947-1-git-send-email-johan@herland.net> 
	<20090827212710.GV1033@spearce.org> <7vy6p5ncz0.fsf@alter.siamese.dyndns.org> 
	<200908280103.06015.johan@herland.net> <20090827233900.GA7347@coredump.intra.peff.net> 
	<7viqg8hj98.fsf@alter.siamese.dyndns.org> <fabb9a1e0908271740i53ec7d69td696d955366ad23c@mail.gmail.com> 
	<7vocq0d86p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 04:52:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgrZa-0007iV-LH
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 04:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbZH1CwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 22:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZH1CwI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 22:52:08 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:28049 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbZH1CwH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 22:52:07 -0400
Received: by ey-out-2122.google.com with SMTP id 25so363668eya.19
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=OmGWuuLtgJ7y1EUrnXIyL/HlXTVWsvNDqviKaTUYw0g=;
        b=ccCFv2VXnYkYwSwvRWJP+kYVScDkDy1FCEzXx+2dT0y2L/VEfyuXzmLk1vP1S1rIxC
         PmjUaWdWgamEgBFbgsjcSHI0kyCPzqMBFy+KbuU4gQ3Y+qH6HVDEdmX6FV1oW62ufOM2
         cHIM1dHGqEJ/1t01CnPug1Fy5jW70qU13IVi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=l1WVgkY8IYv5en7zGFZNkRDafvL1KdflXAc3xOfjtvQIrDOUkn0iAyYoAfPgAfLq3R
         EkFNJTFO6W5Arph146iPv/Vwkh7uQMrQlOROW5sZGII0c6+l08egT+SnfseTcflkkyKw
         wOqgZ9tcxswtZ72xzJ+Kx7zbxFEclY9OwjJ1k=
Received: by 10.216.88.79 with SMTP id z57mr121499wee.22.1251427928115; Thu, 
	27 Aug 2009 19:52:08 -0700 (PDT)
In-Reply-To: <7vocq0d86p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127245>

Heya,

On Thu, Aug 27, 2009 at 18:43, Junio C Hamano<gitster@pobox.com> wrote:
> Did you mean "a commit in branch bar referred to a commit in branch foo",
> similar to the way the "cherry-picked from X" comment can refer to a
> missing commit?

Yes, sorry, I meant referred to in the commit message.

-- 
Cheers,

Sverre Rabbelier
