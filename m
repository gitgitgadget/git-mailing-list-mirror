From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] log --graph: draw '>' and '<' with --left-right
Date: Thu, 22 May 2008 15:14:13 +0200
Message-ID: <bd6139dc0805220614l2504ca0bk432d3101d853b28c@mail.gmail.com>
References: <alpine.DEB.1.00.0805221235430.30431@racer>
	 <alpine.DEB.1.00.0805221344360.30431@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Adam Simpkins" <adam@adamsimpkins.net>, git@vger.kernel.org,
	gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 22 15:15:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzAdP-0007hW-AN
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 15:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762778AbYEVNOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 09:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763030AbYEVNOP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 09:14:15 -0400
Received: from rn-out-0910.google.com ([64.233.170.184]:33581 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759963AbYEVNOO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 09:14:14 -0400
Received: by rn-out-0910.google.com with SMTP id k40so38365rnd.17
        for <git@vger.kernel.org>; Thu, 22 May 2008 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9jy+neEr/PMXrTu53u0SCla0MdTlCKl5E0Psf+NOi9I=;
        b=i1HX1P5vGtKlrTT1LJxgKu6zNxQuTICcfeun4Kgahil9FRLIvlcyH9we2RHJ/A5JTAulTJOVq220yEJwftIU+XaglIyBhvvdSzSEJxqIenz1kBCuTGTIBiZPSYk6IQougdk6yByhWuR5AmpjqYduslC2EQ0T2E/o1iWsNIzFBWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=chzNyl5kSFDqXf9goI9J5hOSHzfZ+mLp6zPUsizlp8Hhh1273D5jqKLw3/uQSoIXkKzm/TVnsyTx7KxYgo9cPaGDeONpzZsJHVC5KIlqb59E2UakDBypqpC0OwqvnhJQq3YGK9LJiDcevP9R9l4zSc8OEJ/AYeccKTpOGYeh1e8=
Received: by 10.142.203.13 with SMTP id a13mr10708wfg.193.1211462053080;
        Thu, 22 May 2008 06:14:13 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Thu, 22 May 2008 06:14:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805221344360.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82629>

On Thu, May 22, 2008 at 2:47 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Sverre just notified me that the commit message is not brilliant.  How
> about this:
>
> -- snip --
> When calling "git log --left-right <branch1>...<branch2>", a single "<" or
> ">" is shown in front of the commit line, to indicate which branch1 this
> commit comes from, branch1 or branch2.
>
> However, it is easy to miss in the output of "git log --graph ...", since
> the graph still has "*" for regular commits and "M" for merge commits.  So
> imitate gitk, and show the "<" and ">" characters in the graph, too,
> instead of "*" (or "M").
> -- snap --

I admit that I didn't know how gitk does things, but yeah, this is a
lot more explanatory and makes sense :).

-- 
Cheers,

Sverre Rabbelier
