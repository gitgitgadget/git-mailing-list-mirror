From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] stage: remove unused, unreferenced builtin-alias
Date: Tue, 25 Jun 2013 00:18:29 +0530
Message-ID: <CALkWK0nRLMby4A4A8YwkCp2Q8cpBdW3XWPRwt0fnE=8iHX3Tcw@mail.gmail.com>
References: <1372097546-27721-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:49:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBpP-0003oH-2J
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab3FXStK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:49:10 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:59467 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3FXStJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:49:09 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so25548258iec.21
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eqHV0TEIr4KyqndFO9jLGYjMfj+1unoimH3XTl5rstA=;
        b=L26gswV5SxMDWH2jvdOy2W1gdpesXZW5akCKytfhgao+QIhPpG/MwHA8kbou42S3CP
         6Bl4yiM+H4lBne0tRxdujniiVIGgtrCv0S2BtXtfNCvswfUbFB5MAbTnLyEmOGaxYP3C
         PKSIfgORbu5H2UB7PCsMoHWiOUS/8n99V8liDLgi6TwuKuh/9ZZTHv83fWOFZdl+DmYm
         8aicYNrlrQYVG/lOFpfqVQy7kdENtvNvWLosVJBD2iI5VysI44QxKlx1fliYK3VB6XIO
         1QxceqPwKtTXDw+b1OTHmw/+/Cpg+jpMKjZHfGvKtAaL2mHrgkjAGD1txC8ezz+uBw6D
         YDHA==
X-Received: by 10.42.76.5 with SMTP id c5mr8931206ick.91.1372099749108; Mon,
 24 Jun 2013 11:49:09 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 11:48:29 -0700 (PDT)
In-Reply-To: <1372097546-27721-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228896>

Ramkumar Ramachandra wrote:
> 11920d2 (Add a built-in alias for 'stage' to the 'add' command,
> 2008-12-01) added a the 'git stage' command which simply calls
> cmd_add().  Since then, no references to it have been made anywhere on
> the internet; there is no evidence that anyone even knows about its
> existence.  It is a long-lost forgotten command that only serves the
> purpose of preventing the user from having a custom alias.stage to do
> something useful.  Remove it.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  I just found out about its existence.

Should we plan a deprecation (2.0 perhaps)?
