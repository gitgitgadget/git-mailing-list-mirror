From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: [PATCHv5 0/5] *** SUBJECT HERE ***
Date: Mon, 13 Oct 2008 12:52:00 +0200
Message-ID: <85b5c3130810130352n2497221crf0f3ced8b80d82f7@mail.gmail.com>
References: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 12:53:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpL3U-0005U0-Ui
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 12:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774AbYJMKwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 06:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756607AbYJMKwG
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 06:52:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:37822 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbYJMKwC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 06:52:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1248357fgg.17
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=bhdNHsBa0Es3C6VBceYCPkUOKQPZpNxDrvquu5pZwRw=;
        b=ZyGyglhbJ7UubOt5Tx7tkiaG53DRJPcs0a9ARsFYolIvvWit1ZAwnpJvqP5QwER7f5
         5HqOVkXJvkHAHPn18guC+QlHV8X1qSbXD/5X7y4NTWLKUTOuYzTFohHKewgg+cAsAC5F
         IWPvxqpYYFyJUFviElfsz5jL0IHHxgkIa9/ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=KDc79eKbguteFFboKt7cXM4FdKwaXzkcixL9SbL3CtfHJCvLqy4Eh29jJ2+UJaPj1h
         Dk85uLcZDZV2jbO8b+A475VO4ubwEDdtapUHewNvPIJXNCt8XkIljDh2CrKQy+6/R2hs
         r67Z+1FiDezNB39jJEKf8wDUWrpITkv0paomo=
Received: by 10.86.92.4 with SMTP id p4mr4961065fgb.45.1223895120421;
        Mon, 13 Oct 2008 03:52:00 -0700 (PDT)
Received: by 10.86.33.8 with HTTP; Mon, 13 Oct 2008 03:52:00 -0700 (PDT)
In-Reply-To: <1223893165-26022-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: f1500b85a0fe9d4d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98108>

On Mon, Oct 13, 2008 at 12:19 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Fifth attempt for my gitweb PATH_INFO patchset, whose purpose is to
> reduce the use of CGI parameters by embedding as many parameters as
> possible in the URL path itself, provided the pathinfo feature is
> enabled.
>
> The new typical gitweb URL is therefore in the form
>
> $project/$action/$parent:$file..$hash:$file
>
> (with useless parts stripped). Backwards compatibility for old-style
> $project/$hash[:$file] URLs is kept, as long as $hash is not a refname whose
> name happens to match a git action.

Thanks Giuseppe for doing this. I just switched from Mercurial to git
recently and this is one thing that I was missing a lot in git.

Ondrej
