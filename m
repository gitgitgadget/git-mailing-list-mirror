From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: problem pushing repository
Date: Fri, 22 Jun 2007 09:36:50 -0400
Message-ID: <799406d60706220636q4f7a3c17v6833d2eda25e8f0d@mail.gmail.com>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
	 <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
	 <20070622022426.GA2961@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 15:36:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1jJn-0000B0-G8
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 15:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbXFVNgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 09:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755168AbXFVNgw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 09:36:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:55623 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032AbXFVNgv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 09:36:51 -0400
Received: by wx-out-0506.google.com with SMTP id t15so816301wxc
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 06:36:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fWYVLI15eHomTZri85jlc8ubVNYju9avc/BYEIvYpf2y3SQQPm+LmQUJQVUv2acrrph0yt7lizi1CV3H7WH2nmvywOa8JemHByVxt4UTbJSPSPaqp818fwKLn0OgndACDbvsafmhFf9jVZgTxDzO25uhqZy4xx0XVFm2I+STvb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k7sWuCtPFh1rc5pLC/10E2cQBCk74wrINVdQ72nrzkQP+rhqzwdBiJdGp6XvOprRnZPj5FZTQ8UCpXGV63N8de3OoehG2d+0DYASpfm2x1C4Bx4f78DL6nAt3k8lAMsDAQGs9OkfKhSfi8quBORroFpngzsuRrpjFDbuXrcjj/g=
Received: by 10.90.99.20 with SMTP id w20mr2566895agb.1182519410179;
        Fri, 22 Jun 2007 06:36:50 -0700 (PDT)
Received: by 10.90.28.17 with HTTP; Fri, 22 Jun 2007 06:36:50 -0700 (PDT)
In-Reply-To: <20070622022426.GA2961@bowser.ruder>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50696>

On 21/06/07, Andrew Ruder <andy@aeruder.net> wrote:
> On Thu, Jun 21, 2007 at 07:00:18PM -0700, Junio C Hamano wrote:
> >       $ ssh newberry.ihepa.ufl.edu sh -c 'echo $PATH'
> >
> > may be a good starting point to test this, and the first step
> > to fix it would be
> >
> >       $ man ssh
> >       $ man sshd
>
> While I wholeheartedly agree with Junio here, you may also find
>
> remote.<name>.receivepack
>
> useful, see git-push(1) and git-config(1) for more information.

This seems like the best way to fix this issue, however it isn't clear
from the man page what I need to put in my ~/.gitconfig. With the
following in .gitconfig

[remote]
glue.receivepack = /home/ram/opt/git/bin/git-receive-pack

I get the following error when trying to push

[ram@skymoo glue]$ git push
ssh://newberry.ihepa.ufl.edu/~/public_html/git/glue.git
fatal: bad config file line 6 in /Users/ram/.gitconfig

so this is clearly not the right entry. Can someone please give me a
push in the right direction?

Cheers

Adam
