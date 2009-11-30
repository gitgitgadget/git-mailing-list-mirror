From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 08:55:51 +0100
Message-ID: <fabb9a1e0911292355v260b9f0ck79d993e25f0c5c61@mail.gmail.com>
References: <20091130075221.GA5421@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF17V-0000Wv-NU
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZK3H4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZK3H4G
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:56:06 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:40790 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbZK3H4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:56:05 -0500
Received: by vws35 with SMTP id 35so983830vws.4
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 23:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=cKT7wjOglAmuwZX9AbO/ff5q/K4FHSCOEtV5Tx7SsfI=;
        b=OnlTKUsUllQHqX3EI/JF5pOuzCamF6lW6pCkp4IgbDO9UT515XxRGOsbGDtyFXK5i3
         Kdobp7C+7maOPZkNtuZl1b0k/5TlRsU8Nm0rOZ6+OsV10cuzsI38OykrFhiqvAqMN7w/
         mYG6ZyFY1NpTDrUfrcvjYajGj2hWuHcHBmTnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=b3xNR17ITtbAjgZhsxJzYkNs68jNLjZ5NZX1CocqUwblTqsP2kwi19Ubzy81RliG8/
         2kT/XjX+02AJzdXlwS9HYFXuQxzlbJe7IYwVDbTHaRENCKUZiXW0OzuQNo/h3lWiVPG6
         ebiyJ5NLX++1GBbHzPTT9FDWaKeDT8uBo70d4=
Received: by 10.220.125.7 with SMTP id w7mr4745407vcr.74.1259567771099; Sun, 
	29 Nov 2009 23:56:11 -0800 (PST)
In-Reply-To: <20091130075221.GA5421@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134074>

Heya,

On Mon, Nov 30, 2009 at 08:52, Jeff King <peff@peff.net> wrote:
> This feels a little funny for NO_PYTHON to mean "no remote helpers at
> all". But that is the way the Makefile is set up, since we seem to have
> only python helpers.

I don't understand what you mean? Do you mean NO_PYTHON implies "no
remote helpers at all", or "not having any remote helpers" implies
NO_PYTHON? Either way, I'm not sure how to set it up differently, not
having that much Makefile foo myself, so maybe Johan and Daniel could
comment?

-- 
Cheers,

Sverre Rabbelier
