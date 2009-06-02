From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Tue, 02 Jun 2009 19:55:33 +0900
Message-ID: <20090602195533.6117@nanako3.lavabit.com>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
	<7v7i0scvcf.fsf@alter.siamese.dyndns.org>
	<op.utlq3vgx1e62zd@merlin.emma.line.org>
	<7vprek0ywq.fsf@alter.siamese.dyndns.org> <op.utlylkb61e62zd@balu>
	<7vskje6wsy.fsf@alter.siamese.dyndns.org> <op.utva2vxh1e62zd@balu>
	<7vy6t03ik0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Matthias Andree" <matthias.andree@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 12:56:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBRfE-00066X-1y
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 12:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbZFBK4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 06:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754711AbZFBK4E
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 06:56:04 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35036 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398AbZFBK4D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 06:56:03 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 2DB3A11B897;
	Tue,  2 Jun 2009 05:56:04 -0500 (CDT)
Received: from 4886.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id P7V967ZHDW6S; Tue, 02 Jun 2009 05:56:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=XBczDQz8fVw02nlm11E1sUB+tK7svfanodoW6pGyaiXM943E7y4WXPpEVMvJaliKZWWiQowJd6iFalXkmHsLlva6K9ZmCHde2ysjsIc5f0TXWOcE0PSRWa8AGhm440FAY/g87aMu1IapW58HJwRKfxHpZ07pPJ7l2z4DGK7b6Wg=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vy6t03ik0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120501>

Quoting Junio C Hamano <gitster@pobox.com>:

> I actually like the rationale you mentioned in the thread (perhaps in the
> original proposed commit message as well) that we should ask the freshly
> built git to describe the version if available, falling back to whichever
> git of random vintage found on the original $PATH.
>
> If it weren't for $X [*1*], my preference would have been (as I said in
> the discussion) to run ./git if available locally.
>
> But I think your "deal with details like $X to figure out the name of the
> freshly built git binary is in the Makefile, and pass it via GIT variable
> to GIT-VERSION-GEN" is a sensible approach.  I do not remember if your
> patch gave precedence to an installed git on the original $PATH or a
> freshly built one, though---the precedent probably does not matter in
> practice, and favoring the one found on $PATH over freshly built one does
> have an advantage if we were to support cross compilation (I have a
> suspicion that the current setup does not).
>
> Thanks.

Junio, I think you forgot to take a follow-up action on this thread after sending this message.  The patch favors the git program in the current directory.

Do you want to ask Matthias to resend the patch with an updated log message?



P.S. a happy birthday ;-)

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
