From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [PATCH] git-format-patch: add --no-binary to omit binary changes in the patch.
Date: Fri, 9 May 2008 23:08:18 +0200
Message-ID: <2c6b72b30805091408i1924b755k3d1f5f4bb0cfaf08@mail.gmail.com>
References: <1210096079-32399-1-git-send-email-cmarcelo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Caio Marcelo de Oliveira Filho" <cmarcelo@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 23:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuZq2-0000s9-M3
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 23:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbYEIVIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 17:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbYEIVIU
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 17:08:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:32118 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbYEIVIT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 17:08:19 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1750676rvb.1
        for <git@vger.kernel.org>; Fri, 09 May 2008 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WpIAD+HG3nvF4W0dg9Vn5KTSoY/IwAyWJIneV8MAwxI=;
        b=h74r+PIvHPmbSc2SsLXWUaYQ1ATvfUNhD/lQUWdcwuIq2EGOJ6u7VDwGt2qq9Nkrmh6qCMUF3TiP6oMboNHycIB6ta9ZR17lYqgK6TsTLRob1jQ+j+riHGDqEWjkieacxxzwAlua3KcbSLAbeKcfwlPhvi326toHD24JJkVgCBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qjGJdcC+c7UiHIkS1uS6XLpamkwtE6jp953lzIVEfdte80Y4BmUc3nWUZUn5v1Q4NsVzhm4CgjFDdVIW+UrU49Yjcoi7hXLIXJfyemeUBFIvLSbErxoK7ZFa6X/usIF17DN/h3F5gmIiPUagwY5tXQb9tHnRUOOqAXU6c8XYnFY=
Received: by 10.141.78.14 with SMTP id f14mr2376010rvl.119.1210367298913;
        Fri, 09 May 2008 14:08:18 -0700 (PDT)
Received: by 10.141.3.15 with HTTP; Fri, 9 May 2008 14:08:18 -0700 (PDT)
In-Reply-To: <1210096079-32399-1-git-send-email-cmarcelo@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81630>

On Tue, May 6, 2008 at 7:47 PM, Caio Marcelo de Oliveira Filho
<cmarcelo@gmail.com> wrote:
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index b5207b7..81c930a 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -150,6 +150,12 @@ include::diff-options.txt[]
>        Instead of using `.patch` as the suffix for generated
>        filenames, use specified suffix.  A common alternative is
>        `--suffix=.txt`.
> +
> +--no-binary::
> +       Don't output contents of changes in binary files, just take note
> +       that they differ.  Note that this disable the patch to be properly
> +       applied.  By default the contents of changes in those files are
> +       encoded in the patch.
>  +
>  Note that you would need to include the leading dot `.` if you
>  want a filename like `0001-description-of-my-change.patch`, and
> diff --git a/builtin-log.c b/builtin-log.c

The '+' on the start of a line means continue last list item. In other
words, your update to the manpage will result in the --no-binary
option having a second paragraph that was really intended for the
--suffix option.

-- 
Jonas Fonseca
