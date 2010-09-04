From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Workflow question: Topic -> Next w/ frequent API changes
Date: Sun, 5 Sep 2010 09:54:28 +1000
Message-ID: <AANLkTikdi2-eM5VMq4cgoTGTB4i0i=i7=3Co10FxYy7k@mail.gmail.com>
References: <4C827535.9040907@shatow.net>
	<AANLkTikT6R4-HMLNebwwsF0pxP_uBTdi=+QkAL2m1EL=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bryan Drewery <bryan@shatow.net>
X-From: git-owner@vger.kernel.org Sun Sep 05 01:54:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2ZJ-0003CQ-Na
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 01:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab0IDXya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 19:54:30 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46272 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296Ab0IDXy3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 19:54:29 -0400
Received: by qwh6 with SMTP id 6so2945054qwh.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zpbNgFRRX7swThDpGPaDnAvdmfU+Y8aOue0DPKpTYVo=;
        b=bprb+4rTd3ydblbQzCQkCgwtno8h8NgsA5i6HxAmbEQJJDds+q5adreReNjLB8yQjY
         5H/XnXQ4+37NARDufQSZvkDtvw5bnHrhHz1OGEdje6blXLN0pyO/pupMd4CcrSiQaCKF
         nnMq2BwhCR445+O8ofQdSXtJPoFmCQ8wT//Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cUYM1rwD+auVU24dB3sKalL113il5GSQomjplIDu5WvZaIThwxGWfn3cjT0k48kAcp
         elTJrow9LTOc2I5oG0/vM/dj2sS23sbrh8ay7R5rX5XzNQT/blnVokbOpq8kyuGmpCQe
         XLuUOWQ9BqoqVh1fW10PEa7i/SN4ssa9geSCk=
Received: by 10.229.1.106 with SMTP id 42mr1579643qce.237.1283644468635; Sat,
 04 Sep 2010 16:54:28 -0700 (PDT)
Received: by 10.229.96.7 with HTTP; Sat, 4 Sep 2010 16:54:28 -0700 (PDT)
In-Reply-To: <AANLkTikT6R4-HMLNebwwsF0pxP_uBTdi=+QkAL2m1EL=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155388>

> The idea is that each developer maintains a base branch, all
> dependencies are merged into that base branch
> and all their work is performed ontop of that base. As the work is
> stabilised, it is rebased onto topic branches based
> on well known tags and these topics are then published. The basic
> ideas is always merge into the _base_ of the working branch
> , never merge into the _tip_ =C2=A0and never publish the tip of the w=
orking branch.
>

A key point I missed here that is worth emphasising - as work is
rebased from the tip of the working branch onto stable topics that are
then published, the topics are then re-merged into the _base_ of the
working branch as well. This is very important - it keeps the working
tree stable, while keeping the topic branches clean.

> jon.
>
