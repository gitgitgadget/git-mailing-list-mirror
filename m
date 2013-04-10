From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] transport-helper: mention helper name when it dies
Date: Wed, 10 Apr 2013 14:23:56 -0700
Message-ID: <CAGdFq_j5vB+OJAkuk-EMLjyrbiY7QrBiwWPraPA7SWTtuUqgZA@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net> <20130410211603.GB3256@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:24:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2VW-0008Bx-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934464Ab3DJVYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:24:38 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:57222 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761639Ab3DJVYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:24:37 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so1175351ieb.37
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JlbNuXUHulHUjNaCDhrvIrm01fQ5+epbbLUIfXhL6Nw=;
        b=PD2/K1sGf/a9MmO+6HrZgZhY8mWSC6JNF/LqFx28cKvm7nHQMqoL+GPvNXu3EuRF/d
         QjpVOXoUZmSicEu2P3fisP+xR/GfyQUJe/6cqFtDBfXsuWmZsl57Pea1FCywRZiXrN3+
         DK0fRc+WGmtwHkrEFf+lcNUGxp+9i6eErpVM1gZ4Tri0OB6gYtDSMkBZClRFT6gOeWgH
         lOSs06+EmtsG1ztmqdaxCD6QHilG+2EDlKlGdgvGFUYlUg4n3O/0JVgPnDzMtdZnccjW
         xV1Ib7xEFFq0V3vaMpHreoEViP1WrnH05GtHjrXfasEqAePPMp7UADCySDMyJ+dpOK65
         LA1g==
X-Received: by 10.50.100.201 with SMTP id fa9mr13786509igb.28.1365629076934;
 Wed, 10 Apr 2013 14:24:36 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Wed, 10 Apr 2013 14:23:56 -0700 (PDT)
In-Reply-To: <20130410211603.GB3256@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220773>

On Wed, Apr 10, 2013 at 2:16 PM, Jeff King <peff@peff.net> wrote:
> When we try to read from a remote-helper and get EOF or an
> error, we print a message indicating that the helper died.
> However, users may not know that a remote helper was in use
> (e.g., when using git-over-http), or even what a remote
> helper is.
>
> Let's print the name of the helper (e.g., "git-remote-https");
> this makes it more obvious what the program is for, and
> provides a useful token for reporting bugs or searching for
> more information (e.g., in manpages).
>
> Signed-off-by: Jeff King <peff@peff.net>

Better than nothing:

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

--
Cheers,

Sverre Rabbelier
