From: Gunnlaugur Thor Briem <gunnlaugur@gmail.com>
Subject: Re: [PATCH] Document git-svn fetch --log-window-size parameter
Date: Fri, 26 Oct 2012 13:45:57 +0000
Message-ID: <CAPs+M8+oa7AEBw-Lvs4TkeLrQ_Amx9_8NmCC6zYUPknMLaFNRA@mail.gmail.com>
References: <1350988406-97624-1-git-send-email-gunnlaugur@gmail.com>
 <20121025095202.GK8390@sigill.intra.peff.net> <20121026094602.GA7887@dcvr.yhbt.net>
 <20121026133250.GI1455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 26 15:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRkF6-0007Ly-2t
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 15:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934Ab2JZNqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 09:46:20 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:64797 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932911Ab2JZNqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 09:46:19 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2416439lag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xnML/flWsTx/0SGefXkOg4TOJAav0kNbmZCZ161FV+4=;
        b=Yj9bkiliPGE8m4eSwgkSaiFL4RdtET34LIxBX2L27l+/t1vlgNH68bQnIcdgztlD8g
         YkgqgXPTQi1Mo8Sub/7ye5BXZWcjFvvGl2YdRIIyWoQKd0Lo33w5YpKJDYTkUaUvqVCV
         cdc/T9OJ1CQQUKeTKR849sBb9IAdPxdludYkOrRxHaF7oefJXMzSdfmzKL/B3DXyEQyg
         CbRLXggVTbg2YrRTLNtbmmU3RBwKpnHM1hYXEsEpJKQ6VgQ8jdugC9R/Ibgd1vajRnOy
         LTyax6MF+X0/IbcRQyUeYAk2EdnVkb+UZ2cqkk3HbjcOG06NvV9ewmnQwVmsKwgecEbW
         zjaA==
Received: by 10.112.103.135 with SMTP id fw7mr8948645lbb.16.1351259177777;
 Fri, 26 Oct 2012 06:46:17 -0700 (PDT)
Received: by 10.112.56.166 with HTTP; Fri, 26 Oct 2012 06:45:57 -0700 (PDT)
In-Reply-To: <20121026133250.GI1455@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208445>

On Fri, Oct 26, 2012 at 1:32 PM, Jeff King <peff@peff.net> wrote:
> That's probably worth mentioning. Gunnlaugur, any objection to me
> amending your commit with:
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 64756c9..8b0d3ad 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -150,7 +150,8 @@ Skip "branches" and "tags" of first level directories;;
>      Fetch <n> log entries per request when scanning Subversion history.
>      The default is 100. For very large Subversion repositories, larger
>      values may be needed for 'clone'/'fetch' to complete in reasonable
> -    time. But overly large values may lead to request timeouts.
> +    time. But overly large values may lead to higher memory usage and
> +    request timeouts.
>
>  'clone'::
>         Runs 'init' and 'fetch'.  It will automatically create a
>
> ?

No objection, that sounds fine to me.

-Gulli
