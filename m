From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Navigating remote branches in qgit
Date: Mon, 5 Feb 2007 18:45:28 +0100
Message-ID: <e5bfff550702050945l528b764apacc69b79c60dfb7a@mail.gmail.com>
References: <1170574889.21644.38.camel@dv>
	 <e5bfff550702040300x60bb1dfdxd312dc214bc49014@mail.gmail.com>
	 <1170645235.4191.26.camel@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 18:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE7ua-0008S6-Vg
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 18:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952AbXBERpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 12:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932978AbXBERpb
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 12:45:31 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:13114 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932952AbXBERpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 12:45:30 -0500
Received: by an-out-0708.google.com with SMTP id b33so1082232ana
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 09:45:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qVp7WCXWTZfDavg1bglBiXS3VV9k0VpnaKLsReVMm7zW+OZuP6pVPgN4jjPLI89WodKZDt8LuwUBKXJsNFyqV/79GuVFLtZCH4U10+VheXqj80nofpJODpwtnQevVnEp6pk8ihGXF5IXbUnk0Bk7hLC12JHwZAtzCCekZdkj+/g=
Received: by 10.114.153.18 with SMTP id a18mr637732wae.1170697528837;
        Mon, 05 Feb 2007 09:45:28 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Mon, 5 Feb 2007 09:45:28 -0800 (PST)
In-Reply-To: <1170645235.4191.26.camel@dv.roinet.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38761>

Hello Pavel,

> OK, I understand.  I feel quite ambivalent on this if we stop showing
> StGIT bases.  They seem internal details of StGIT to me.
>

Probably you are right. Patch pushed.
 >
> I've made a patch that makes qgit use the same color as gitk.  It looks
> much better to my eyes.
>

Thanks, applied.

> I think the popup menu for remote branches should have one more level of
> hierarchy.  The branches should be grouped by remotes:
>
> Remote branches -> wireless-2.6 -> master
>                                    upstream
>                    wireless-dev -> master
>                                    for-linus
>
> It may not be as quick to access, but jumping the branches is not going
> to happen often.  It's more important to provide a good visualization.
>

In your interesting test case at http://www.red-bean.com/proski/qgit/
all the remotes are on "origin", so in that case I don't see how
things could go better. Or perhaps I don't have understand the
grouping logic. In this case please give me some example based on your
repo, so I can understand the algorithm to use.

> Also, qgit seems to be confused on one of my repositories.  It doesn't
> show any tags in the main menu and shows tags with branches under
> "More".  I guess there are too many remote branches.  The tarball is in
> http://www.red-bean.com/proski/qgit/
>

Thanks. Fixed and patch pushed.


  Marco
