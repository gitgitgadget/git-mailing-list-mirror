From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 23:30:17 -0500
Message-ID: <9e4733910711122030q7bbf6057ubb6b5b27e1885500@mail.gmail.com>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	 <Pine.LNX.4.64.0711121412410.4362@racer.site>
	 <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
	 <Pine.LNX.4.64.0711121613570.4362@racer.site>
	 <9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com>
	 <Pine.LNX.4.64.0711121635130.4362@racer.site>
	 <9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com>
	 <20071113042017.GB9745@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 05:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrnQ5-0006G8-I8
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 05:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbXKMEaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 23:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755937AbXKMEaU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 23:30:20 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:34733 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbXKMEaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 23:30:18 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1162250nze
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 20:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RpeBpTRImS4AT2in3IKCFVvRFsdgERSGNke6bJn01QM=;
        b=UdGto+FsjD18qQHRz5tVWTNqIy41Hw0yCzhncJms+zDcPz+PzjTpEgk5+/pky6OSE12RBecbjqZYWnObVuwSCKyz1fYfagoL4hyHf8xVpxD0LJwnZbewKWH3VhilFNEAuYmGiE/soj31ZSKBX0V6yM/6wIrrehgb81CFWy1Y3C0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sfZ6ZXhhSjFs7eGjV6uyJU5BjfCxq6fn+F7kSs4m1llT+AcQn7pDvVFV5h8iP0rFq+IrxCfZBqzGJNfmGFA1GCnKdZrTvbHikFsuHmGLo/arY9JtBVn5AV8O0vPxY0WbED1xf/CX9s7iqH/pVNk+uY8tA1fElhYS0k5rXrbsNcU=
Received: by 10.115.108.1 with SMTP id k1mr558053wam.1194928217260;
        Mon, 12 Nov 2007 20:30:17 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 20:30:17 -0800 (PST)
In-Reply-To: <20071113042017.GB9745@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64749>

On 11/12/07, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 12, 2007 at 12:21:20PM -0500, Jon Smirl wrote:
>
> > Running git update-server-info at the remote end fixed it.
> >
> > I am using 'git push' to send changes, I though that was supposed to
> > update the server info automatically.
>
> It is typically triggered by the post-update hook. Make sure that your
> remote repo's .git/hooks/post-update has the execute bit set.

Execute bit was not set. I just set it for all the scripts. +x is not
getting turned on with a default git init-db. I just made a new repo
to check, no +x on the scripts.

-- 
Jon Smirl
jonsmirl@gmail.com
