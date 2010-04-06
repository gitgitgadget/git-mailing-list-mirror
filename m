From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5] Documentation/remote-helpers: Add invocation section
Date: Tue, 6 Apr 2010 18:53:00 +0530
Message-ID: <o2yf3271551004060623z46cdc599kec7f6f6dc0f28e9@mail.gmail.com>
References: <t2sf3271551004060404xe41ff754i9d16a265a4222a28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 15:23:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz8kk-0005Gn-Pa
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 15:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab0DFNXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 09:23:23 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:51281 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab0DFNXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 09:23:21 -0400
Received: by yxe29 with SMTP id 29so2722724yxe.4
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=CBLc8MwWoIm0Lzgd87q4BojOMjrJLOm65X79rM3IYGA=;
        b=h76IxrjVok6CeNNmx2/Z1bHmWQnT6JBIOT2OajTQCBCkQwEJBrR96cgWRApjnAgSFq
         hHy3SosCaQGzv7WKsYKDd6b6I2dQwgINx49toNcNbaSFsx1LUfCLZ40zabzx0nZE23y9
         Mtg+IEksxY5B6bOfsEyYzPiwzflCUOS0pWo0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Aq2LDByiNA1/Xbz29OGxN7uBxFg+Y9a5oNX/R2JHbBCar1Zr6Ozt8ZN7+7XVT0shkB
         OIY0PwwQg/S9QiLU9ayi3uoAQJFrSS6OLNibnTDJHlVg8BDCKpl+XL4PhFuX094sk8JC
         ahC3t0oZEs8iVqcYHt3uyqDQn7agI3yrXmkHU=
Received: by 10.90.69.14 with HTTP; Tue, 6 Apr 2010 06:23:00 -0700 (PDT)
In-Reply-To: <t2sf3271551004060404xe41ff754i9d16a265a4222a28@mail.gmail.com>
Received: by 10.90.19.22 with SMTP id 22mr2157828ags.67.1270560200161; Tue, 06 
	Apr 2010 06:23:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144141>

> +<nickname> with vcs set
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +A remote can be configured to use the
> +'git remote-<transport>' helper by setting the vcs variable to
> +<transport> in the [remote "<nickname>"] section of a configuration file.
> +The url variable in such a section is optional and can be set to an
> +arbitrary string <address>.

I'm sorry- this was sloppy. Plus, it doesn't apply to master or pu.
I'll send in another revision of the patch with this hunk removed
rebased on pu.

-- Ram
