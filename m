From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Sat, 21 Nov 2009 21:59:33 +0200
Message-ID: <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
	 <20091121193600.GA3296@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 21 21:50:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwsY-00041R-7M
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbZKUUG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 15:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZKUUG4
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 15:06:56 -0500
Received: from mail-iw0-f202.google.com ([209.85.223.202]:37749 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbZKUUGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 15:06:55 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Nov 2009 15:06:55 EST
Received: by iwn40 with SMTP id 40so2989483iwn.32
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=AvcGW4MuNP1yftsuUWIbzmNtzORmw6MJMw1rW+f+QZ8=;
        b=BtblPfnA5XDuoulg/Z1Ua+8E03nyqXR41C2jcp9nZ+pVdqyvfA9ZdeX/H+4bkFa4E2
         rFI5+CgxXVFqUjKcz8N+h1ebfBVnCfBuP0cfXO57Sa078WDr9xuH+NkCffvzQmgY++r8
         yXwtL5YRaQaShL4xtDOsdyDHeamiV2AgsIltk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=StWqRUJPBOPp4SP25g1/9ojsjlsvpYy1Z4f/DlSGchU12kktMVIRjTqAONA/LFJbm1
         1MC5Fn64ocDtrgVU2QhGium0h8JbfAjnbJ4p4F9RNSPP/oS8BOJulGn1wnaekNl2HSxq
         GoSGv/plWTCgAA/XlEh+BSYz5BU1Hlil5RN7Q=
Received: by 10.231.5.79 with SMTP id 15mr227230ibu.7.1258833573893; Sat, 21 
	Nov 2009 11:59:33 -0800 (PST)
In-Reply-To: <20091121193600.GA3296@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133399>

On Sat, Nov 21, 2009 at 9:36 PM, Jeff King <peff@peff.net> wrote:
> So my first thought was "how in the world is this different from setting
> the envelope sender?"
>
> Reading the code, it seems:

[...]

> that this is a boolean to mean "use the from address as the envelope
> sender".
>
> It was of course all the more confusing for not being documented at all,
> but even if documented,

Right, I forgot the one-liner for the help.

> --envelope-from is IMHO confusingly similar to
> --envelope-sender. Maybe --use-from-in-envelope would be a better name?

Ok. I don't have any opinion on the name.

> And of course, your patch is missing docs and tests.

There are no tests for 'envelope-sender', so I don't think it should
be a requirement for this patch to do so. I'll add the documentation
though.

Will resend v2.

-- 
Felipe Contreras
