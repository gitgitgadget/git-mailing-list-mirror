From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH] Basic Zsh completion support
Date: Sat, 18 Mar 2006 17:14:31 +0100
Message-ID: <dbfc82860603180814p36a5bf3eo4771610981870bca@mail.gmail.com>
References: <20060318145347.15128.85902.stgit@c165>
	 <dbfc82860603180725w2eb3057ey17fa8d9dc746127@mail.gmail.com>
	 <4fb292fa0603180752r731c628eoa2b96fcd6ef43e0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Fredrik Kuivinen" <freku045@student.liu.se>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Mar 18 17:14:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKe4Z-0007EZ-0B
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 17:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWCRQOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 11:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWCRQOc
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 11:14:32 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:46263 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751400AbWCRQOb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 11:14:31 -0500
Received: by xproxy.gmail.com with SMTP id t14so577701wxc
        for <git@vger.kernel.org>; Sat, 18 Mar 2006 08:14:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XBQZqJs7Sb+kGCYVb/jUHXYt+pY1Q9OTw9AjfVzvYLNwhRwKsXHceseNNQC31FgRH7+FhtzQ05Lxuf0Y/hRl90pGZtweuPWy4iRjJ+7B0oAwHL3KQDefL/sjhu8CJHf/apQlZ/PEMxAXk0G8QUayICpO2eV21d2CMmk6CJA89+Y=
Received: by 10.70.52.1 with SMTP id z1mr355838wxz;
        Sat, 18 Mar 2006 08:14:31 -0800 (PST)
Received: by 10.70.39.9 with HTTP; Sat, 18 Mar 2006 08:14:31 -0800 (PST)
To: "Bertrand Jacquin" <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0603180752r731c628eoa2b96fcd6ef43e0f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17699>

On 3/18/06, Bertrand Jacquin <beber.mailing@gmail.com> wrote:
> On 3/18/06, Nikolai Weibull <now@bitwi.se> wrote:
> > On 3/18/06, Fredrik Kuivinen <freku045@student.liu.se> wrote:
> > >
> > > Based on the completion code for quilt in the Zsh distribution.
> >
> > Actually, there's an almost-complete implementation in 4.3 already.
> > Written by me nonetheless.  You can take a look and make suggestions
> > if you like :-).  I have an updated version to deal with post
> > 1.0-changes locally that I'm going to put in Zsh's CVS soon enough.
>
> Any plan do to this for cogito ?

Sure, and stgit as well, but I haven't gotten around to it.  The idea
was to reuse as much as possible of the stuff that the three have in
common (like tags, references, and so on), but as I haven't used
either of the two (cogito and stgit) I haven't had a compelling reason
to sit down and do it.

  nikolai
