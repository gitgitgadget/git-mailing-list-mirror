From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Wed, 17 Oct 2012 23:12:16 -0700
Message-ID: <CAGdFq_hsCjL5uunwg=N-y+FkFt-ZxORtrEcxAAHt-rDfA04cZw@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
 <20121017225913.GC21742@sigill.intra.peff.net> <CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com>
 <CAMP44s1b=dNaCbm1WkFBv6368Y+jDYdkPuscEFdiUnVJBStfVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 08:13:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOjLw-0005Aj-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 08:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab2JRGM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 02:12:57 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63025 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab2JRGM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 02:12:57 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so2640172qcr.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t2zdsWwCu03O3Zj9J4omCTRjqwgil84jjoTItNwrRkc=;
        b=v72EzSLzOK2R5SQOKmEFLOgPUOZvQIbA6bTfbze1Egedld1JgenCjUiSIOXxlHE4T4
         LUMjsqE/jRAIPDQ0xOPjt28lACl/lZjQzZ9SCI+RuO/Fh6B2agODr4butFS2gxRTK2sm
         5Y6HtrROEWFyyzesqSczZ8G2ywIj1AwYitm+f+AJOve8roe3nRqr7IFMwW24E7QDphrw
         zW1x6YS+9pjwY8wOsWOCZQeYkj6TuRCozBF3Loo00wh/lHoMlhXqK4tCq1cLQARnYmYl
         jQwcG1oxd0Eir2AYolVFwylhOky9c/C9JpW1gZ2YjYWz1QLMwa5I8ZaR4ztMu/ScfArp
         7y0Q==
Received: by 10.229.176.29 with SMTP id bc29mr9179775qcb.113.1350540776420;
 Wed, 17 Oct 2012 23:12:56 -0700 (PDT)
Received: by 10.49.36.195 with HTTP; Wed, 17 Oct 2012 23:12:16 -0700 (PDT)
In-Reply-To: <CAMP44s1b=dNaCbm1WkFBv6368Y+jDYdkPuscEFdiUnVJBStfVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207970>

On Wed, Oct 17, 2012 at 10:18 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Right now I've just added an error when using remote repositories. But
> it seems there's no way around it; if we want to have support for
> remote repos, we need to make a local clone.

My git-remote-hg does the local clone into .git/ using a hash of the
url (although you could just as well use urlencode, basically any way
to safely use a url as a directory name). Have a look if you want.

-- 
Cheers,

Sverre Rabbelier
