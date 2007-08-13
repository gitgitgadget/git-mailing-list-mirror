From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 07:35:40 -0700
Message-ID: <a1bbc6950708130735g73508d1ev2114cea3612d77c9@mail.gmail.com>
References: <11869508753328-git-send-email-prohaska@zib.de>
	 <118695087531-git-send-email-prohaska@zib.de>
	 <7veji8ifs2.fsf@assigned-by-dhcp.cox.net>
	 <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
	 <46BFFB1A.4070704@trolltech.com>
	 <5BA0164D-8327-4B01-84CD-595D8573BEEF@zib.de>
	 <46C00515.5050308@trolltech.com>
	 <521D9D91-2422-4378-BD68-37550731E06A@zib.de>
	 <46C018DA.1020309@trolltech.com>
	 <DD0F51D8-390E-41DB-BD80-0BB440418D01@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Brian Downing" <bdowning@lavos.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 16:36:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKb1l-0006lZ-Da
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 16:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S946931AbXHMOfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 10:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S946864AbXHMOfq
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 10:35:46 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:56332 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S946894AbXHMOfm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 10:35:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1188617rvb
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 07:35:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rAvYjBM7mo25mJwwg8DR3AN/JkL5rJI7gMZ0pxNypDsPb1iZFoReH4HIh2DNRg9tEk5dc7FGXeckkiX/b7mxk7KdOntP0DJTmhIQCGjIpWw/E8SaQBovyxf6BrPWWLboTd4wHBHQfrtGhMJa2IjfNT1Ei8ihuBzPF5kMxmNXTOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bfu6Txgd7byaDKvDxtTjORhPbeYeK8QLg9RjZ+sZU1zrIcYrQu5W6C/zzHJytD9u1dRbE0v8OGjPatRX3kGxg88xW3noJRHDjRpt0F707TpwFB+prh4UOpuU1CyRFdsyNj6cVtVbd/d2hea89WUBopJAi+LVJttzvMGlgdhnXh4=
Received: by 10.140.249.20 with SMTP id w20mr2553205rvh.1187015740617;
        Mon, 13 Aug 2007 07:35:40 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Mon, 13 Aug 2007 07:35:40 -0700 (PDT)
In-Reply-To: <DD0F51D8-390E-41DB-BD80-0BB440418D01@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55764>

On 8/13/07, Steffen Prohaska <prohaska@zib.de> wrote:
> My target audience of Git on Windows are Windows users and, frankly,
> that is the only reasonable way to think about Windows. Why else should
> I boot Windows, if I don't have real Windows users in mind? I mean,
> Windows is not the superior platform to build Unix on top. The reason
> to boot Windows is Windows itself, including its real users.

I agree with this approach.

> Maybe I don't fully understand what msysgit is about. I thought it would
> be about real Windows support, which I think requires to accept what
> Windows users expect to be the right thing: Windows EOL.

msysgit is Build Environment for Git on Windows. It's purpose is to
facilitate Git development. This is not what end-user wants.
Another installer (WinGit) is targeting end users. It is just so
happens that msysgit is in better shape right now and more useful. But
long term it will not be the case.

Here is another consideration: let's say I've started a new git repo
under Windows with no autocrlf set. Then my repo will contain crlf
line endings.
Now let's say that someone else checks out this repo with
autocrlf=true. What would happen then? Will they get cr cr lf?
-- 
- Dmitry
