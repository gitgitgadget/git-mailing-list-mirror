From: Alexandru Sutii <sutii.alex@gmail.com>
Subject: Re: GSoC questions
Date: Mon, 28 Mar 2011 23:26:47 +0300
Message-ID: <AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
	<20110328001152.GA11294@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, libgit2@librelist.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 22:26:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4J1Z-0003bA-Dy
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 22:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab1C1U0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 16:26:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57380 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab1C1U0s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 16:26:48 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so4054817iwn.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UmnyuzXoP0DdouB3aX2ynWXsIFSwVMvaj6hFUtchdZk=;
        b=cnVhoHFb41n8c2VDL4S2GdT5YvBsiHgYInXMIzBRTlkzbHYqKcImRTQYtlv+iPuxlT
         e1CXyoy1DqquMmzsH6GT5GJgUbJzWMDU7NRVCNdYtOiRhiBy5dXUnj6rZT0kPD3uaFhf
         gKOp0Rl//wHIY0LhRSPleLSrx8GVg79HD34t0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=coJhq2v0OIwGiXok35cR3mX7I50ftluHXY4Cnc3q75ixHuReJQx3en+t0323o5OmV8
         SnfnFoYjngyA93QMDRG2xDwMpKEtvsutarOa1R4pPmoXljNrUz0h8ftJbdo3BWVz462f
         uYdGazJyaBA6ce0QqfCw+tfV8z2bgWUuAyH0s=
Received: by 10.42.138.4 with SMTP id a4mr7526724icu.258.1301344007802; Mon,
 28 Mar 2011 13:26:47 -0700 (PDT)
Received: by 10.43.133.2 with HTTP; Mon, 28 Mar 2011 13:26:47 -0700 (PDT)
In-Reply-To: <20110328001152.GA11294@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170185>

> Is there some particular part of git functionality you would like to
> focus on (history creation, history mining, object store maintenance,
> configuration, transport)?  The list of low-level commands (plumbing)
> in the git manual might be a good place to get an idea of the scope.
>
> The ideas page mentions areas in which libgit2 functionality is
> incomplete --- depending on your interest, you might want to focus on
> one of these (so the project would be to add functionality to libgit2
> as well as using it) or to steer clear of them (to focus on
> functionality libgit2 already has).

Hello again! Thanks for your and Jeff's reply.

I have decided on "minimal Git client based on libgit2" project. I have looked
over the git manual page and I would like to work on manipulation commands
functionality. I am also open for adding functionality to libgit2 as
well as using it.

I have read the references from your mail and I am currently trying to
understand project's architecture, as I am totally new to git's source code.
Hope I will manage to identify the source code parts that interest me in
a short time and maybe realize to implement something.

In the meantime I would greatly appreciate some guidelines where to look.

--Alex.
