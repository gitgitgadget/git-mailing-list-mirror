From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git rev-list --boundary from..to
Date: Mon, 23 Apr 2007 16:38:34 +0200
Message-ID: <8aa486160704230738t75c90777k3787032fa4e348fb@mail.gmail.com>
References: <8aa486160704230634m130d1877k9e965847a2029751@mail.gmail.com>
	 <Pine.LNX.4.64.0704231624400.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 16:39:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfzgy-0006iT-H3
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 16:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbXDWOiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Apr 2007 10:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbXDWOiy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 10:38:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:19704 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbXDWOiw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 10:38:52 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1458025uga
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 07:38:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P8ZPVMyfwOn9/8wDguMnwZHR/HrC/nrUrTxjNixVXdO7P4q/yz9GtVpTZFp4XNgIRWq8+J/zCMmGIA3PdcgdpzjNFr29+rlW2kn71sASdKgiwr5J0j2vubUoR95WxL2jGhIAhEYpc7mvJxnUDrz9pjTzbfxbBHA5zqzQ4VoVz7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xjd2ouFf2I9QqqcGptnhZPY1NdsUarueLQUZoftDnCRlO0VbMhSdFfXF1k6RCyBLxrXbAeyUjICdeGLUR7gfcu6tIDzko/WThqZIa4JyBliKfXLWyjiyO/7lmAQsJtBKLhw8TBJLbAsHX8QPkCe93V2f36gjgXiLOw3qW3amzhY=
Received: by 10.78.171.13 with SMTP id t13mr412595hue.1177339114698;
        Mon, 23 Apr 2007 07:38:34 -0700 (PDT)
Received: by 10.78.131.7 with HTTP; Mon, 23 Apr 2007 07:38:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704231624400.8822@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45326>

On 4/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 23 Apr 2007, Santi B=E9jar wrote:
>
> >  git rev-list ${order} --boundary ${commitlimit}
> >
> >  is what is used in gitk. In v1.5.0.3:
> >
> >  $ gitk from..to
> >
> > shows the boundary commits next to the child, but it is no longer t=
he
> > case since v1.5.0.3-290-g86ab490.
> >
> >  Now all the boundary commits are at the bottom.
> >
> >  While at it, when used with --max-count they are at the bottom too=
,
> > and I understand why, but is there a way to tell "show me the bound=
ary
> > commits next to the child even if it means it takes more time"?
>
> I'd say "--parents", and infer the relevant information.

Sorry, I think I did not expressed it quite well. The "next to the
child" was about the order git-rev-list outputs the commits, not about
the parent information (moreover gitk uses --parents).


> While I agree
> that it was nicer to scripts earlier, IMHO it was incorrect, too.

Sorry but I do not understand what is incorrect. Are you talking about
the regression or about the --max-count question?

Santi
