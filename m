From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] new test fails "add -p" for adds on the top line
Date: Sat, 16 May 2009 19:55:35 +0200
Message-ID: <fabb9a1e0905161055q89b9e6ei77a922749ed8cd5e@mail.gmail.com>
References: <1c5969370905152010m486a8b85s96334e99e6c54ad5@mail.gmail.com> 
	<20090516192529.6117@nanako3.lavabit.com> <200905161612.30911.trast@student.ethz.ch> 
	<7viqk1ndlk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Matt Graham <mdg149@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 16 19:56:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5O7a-0006wB-8I
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 19:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbZEPRz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754502AbZEPRzz
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 13:55:55 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:1840 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbZEPRzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 13:55:54 -0400
Received: by mu-out-0910.google.com with SMTP id i2so1002320mue.1
        for <git@vger.kernel.org>; Sat, 16 May 2009 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fgxHLU4WzTE1cPBldJ+xHm8cBrQ2RTVzMWo9Id0Rzmw=;
        b=D0CQWhGt47W/P1P4Wn4stUpP8K6fm+NjSJLOWYGw3XqGnwXt8+UFNAb+Ri9eZ3KiCV
         3/jgAxTFMJGNaBVjAGeYKlrHbYCsPZj5DdsvgwZpNUYl+LTMf2P0J11IAxgoo+8P5fas
         Gdmat65mYalGlBDdz5C+nlLg9LaJrPC3590Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=beCvl3j1HjmfiS3XEkAj/JP2rCJ3ZK4iM0F9hPRI8umr7RmTJqqGBbQv4R6iH6/va0
         zyNbDA9K+ehvNVe5pOna/Rya6VhLFc55fTFuJshlk+muj3FJtfgeSnYZI5NcvJOg+6OO
         6onIeZ3xD0iiQu5Ab7fcfIjB01BmzfE6KN4Gk=
Received: by 10.103.198.20 with SMTP id a20mr3048996muq.63.1242496555092; Sat, 
	16 May 2009 10:55:55 -0700 (PDT)
In-Reply-To: <7viqk1ndlk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119372>

Heya,

On Sat, May 16, 2009 at 19:48, Junio C Hamano <gitster@pobox.com> wrote:
> We could also remove that "edit" thing; I do not use nor trust it
> (fundamentally you cannot trust it).

But it is very useful to split up patches! Of course, I always verify
the end result (usually by diffing against HEAD@{...}), but it is
definitely a very useful tool that I would hate to see removed :(.

-- 
Cheers,

Sverre Rabbelier
