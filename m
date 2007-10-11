From: Baz <brian.ewins@gmail.com>
Subject: Re: Suggestion for mailing lists... split [PATCH]-es into own list
Date: Thu, 11 Oct 2007 23:53:38 +0100
Message-ID: <2faad3050710111553x3ec8a2abh1ec20f2683a019dd@mail.gmail.com>
References: <e47324780710110857s472bf099u3e350d17a2c29f78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Thomas Harning Jr." <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 00:54:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig6v4-0004bF-5x
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 00:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbXJKWxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 18:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbXJKWxt
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 18:53:49 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:34458 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbXJKWxm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 18:53:42 -0400
Received: by nz-out-0506.google.com with SMTP id s18so569696nze
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7i4VPY2XHDnf0mxZa0f7WaitclqoWMpkhtaBFxOCEBs=;
        b=IUSSlCy9iI5AUn+lZhunEll+o/0RSI/I2rHT69FHqqxZMVafYAUaJYpjzE9nTWO41oeWNseLFJBqEm3ECXT6CefuuHZvcbQ7MO7sX2BCNftpWEBE0Y2+VCekNJbreYE/fSb5AGSfYWTxn5RttceEAX/B1FMaTpXO8BGJrBssP+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oc2ACr3eH+u790j5fr/Apa/f2JBbpdLsrNGPsv//OGjsFu54DVxK/VwijoXcGgysTq/6madHS0ICtUTY07t2+/aMs47iWUi0Bsb3mNTX53Mfau04XVo2XEHD1pvTHjzBYdhzZpuOkG4BJMsnOzwBE1eGa1req3uATOEpie+DbGk=
Received: by 10.142.142.16 with SMTP id p16mr863341wfd.1192143218281;
        Thu, 11 Oct 2007 15:53:38 -0700 (PDT)
Received: by 10.142.157.1 with HTTP; Thu, 11 Oct 2007 15:53:38 -0700 (PDT)
In-Reply-To: <e47324780710110857s472bf099u3e350d17a2c29f78@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60649>

On 11/10/2007, Thomas Harning Jr. <harningt@gmail.com> wrote:
> I use gmail as my mail client and it doesn't grok 'PATCH' filters
> (primarily the case of the word).
>
> Are there any of you using Gmail that has managed to get around this issue....?

Try this in the 'has the words' box (the whole thing):
to:git@vger.kernel.org -("+++ b" subject:"[PATCH")

Obviously get rid of the '-' for the other filter you'll want. Patches
that lead to discussion will probably get both tags. The "+++ b" is so
you don't class mails that don't have a patch in the body as patch
mails.

> Perhaps we should have a separate mailing list for patches vs discussion.
>
> --
> Thomas Harning Jr.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
