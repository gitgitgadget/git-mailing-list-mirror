From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees 
	with various fanout schemes
Date: Thu, 27 Aug 2009 17:40:20 -0700
Message-ID: <fabb9a1e0908271740i53ec7d69td696d955366ad23c@mail.gmail.com>
References: <1251337437-16947-1-git-send-email-johan@herland.net> 
	<20090827212710.GV1033@spearce.org> <7vy6p5ncz0.fsf@alter.siamese.dyndns.org> 
	<200908280103.06015.johan@herland.net> <20090827233900.GA7347@coredump.intra.peff.net> 
	<7viqg8hj98.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 02:40:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgpWN-0005dF-0h
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 02:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbZH1Akl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 20:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbZH1Akl
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 20:40:41 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:37098 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZH1Akk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 20:40:40 -0400
Received: by ewy2 with SMTP id 2so1728222ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=bifIMLZzp1TZ7lFX9Q63AGIdskpbUNl18Vn7IlUKOEE=;
        b=CkRtQP62wPvgFx5I3XmPu6DsJTa25DrBXVokXmv/yOJTQl3mqEjN0WRoqBmcpR0k7c
         7VfPOH05k8vn752b5PhumPIn0YFyo0LtuZTvTCeUl/Hdt8cDq7Y5H8juZVnaDZqoG+hh
         PT45o3LBg7ZmzZdBaJHJ/e7COn3NQebk3B0wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KCF3iqdTdWSTS/E8A/8o1G+YjDBM2KWJISyhD36YMKYYLQqCZilDTyR/GD6X8ht/ml
         P4CCxCaQnWtJxoYB1F5rhHageyhZ1AtWfN8TFLxyDxhkaD7LFXOK03OmOFrbbj96JQ6R
         vCXLc7a6phd77JHfMnEqCoWdlA23R1CTycjj4=
Received: by 10.216.21.65 with SMTP id q43mr93963weq.43.1251420040188; Thu, 27 
	Aug 2009 17:40:40 -0700 (PDT)
In-Reply-To: <7viqg8hj98.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127237>

Heya,

On Thu, Aug 27, 2009 at 17:30, Junio C Hamano<gitster@pobox.com> wrote:
> So, how?

A note in branch foo (which you do not follow) was referenced by a
commit in branch bar (which you do follow)?

-- 
Cheers,

Sverre Rabbelier
