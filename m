From: Sverre Rabbelier <alturin@gmail.com>
Subject: Re: [PATCH v3 1/2] git-am: emit usage when called w/o arguments and 
	w/o patch on stdin
Date: Wed, 28 Jan 2009 19:33:48 +0100
Message-ID: <bd6139dc0901281033r27b84f5dx7b55e1cfcf796a76@mail.gmail.com>
References: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
	 <780A42F8-E27C-404A-945C-38C16378EF57@ai.rug.nl>
	 <76718490901280840g7d36aa96u3d0f98a709ac9fde@mail.gmail.com>
	 <7v3af3thyj.fsf@gitster.siamese.dyndns.org>
	 <76718490901281026i45c26cb0r978f795a50dede19@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 19:35:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSFFs-0002rX-Ko
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 19:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbZA1Sdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 13:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbZA1Sdu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 13:33:50 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:51659 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbZA1Sdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 13:33:50 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3055205yxm.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 10:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iImNzLkqVQ7b2U9AG9XKDFTe+g9/Zw2w908K5dQgRRY=;
        b=sqxMrNwXPLrJCXCD/UKe/DKFYpNQGdhDeKOEwRAHiRl4EtRbd4SMN7M3oxL2GEtXih
         /LXBznrw5AkBxuh8IWQj53S2y7tc5E1wPQF/EJnQ66gAr5F+lCyAWYHcHpSWgb8dzTU8
         KNFV4nV8Pfa/wFI6PrHXhxteEfzhen52LMiv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=TfI9sIcafGraS53Gnz1qLaccGVxGeVSDIxAKMLXzJ1Q8ex9hW3AB39xpaE7/cq5nva
         ++v+BtJOsP2Nuk1Nqe604q7go7ePb25X7QgCmrAU1p2ieJPxMg5kjehNVvWZQ6gG6FhY
         CzuSBf8erBceNAAdSDFX9fwfgk6lV05yxji44=
Received: by 10.150.202.9 with SMTP id z9mr3152109ybf.11.1233167629001; Wed, 
	28 Jan 2009 10:33:49 -0800 (PST)
In-Reply-To: <76718490901281026i45c26cb0r978f795a50dede19@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107563>

On Wed, Jan 28, 2009 at 19:26, Jay Soffian <jaysoffian@gmail.com> wrote:
> Well perhaps we should just deal w/ctrl-c only and ignore the terminal
> check altogether.

That would suit my needs; as long as doing "git am" and then ^C does
not change my worktree and .git directory. Doing a stray "git am
--abort" after aborting does not obliterate my worktree as it does now
(not nice!), even so, it will change where my branch is currently at!

-- 
Cheers,

Sverre Rabbelier
