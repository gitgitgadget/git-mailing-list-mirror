From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git repository
Date: Sat, 12 Jul 2008 00:14:00 +0200
Message-ID: <bd6139dc0807111514j75d1ae6dl3c3f5dbfb55961c7@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
	 <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
	 <alpine.DEB.1.00.0807112215050.8950@racer>
	 <alpine.DEB.1.00.0807112238350.8950@racer>
	 <bd6139dc0807111455s127c5a35hfd3f01cc75614f65@mail.gmail.com>
	 <alpine.DEB.1.00.0807112310140.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:15:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQtO-0007Jh-R8
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbYGKWOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756236AbYGKWOH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:14:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:10988 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756056AbYGKWOG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:14:06 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1988919ywe.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QBhrO1C+hoYq0C3gR/RYrLB1CBfQVfLqSexUqP++K9s=;
        b=QzvyKQWifxoWboOYPemc5dHJzs3WRRBgIDM4wHFVeTZDMTEPFDlCw2lsRGGMvb+fXj
         Q5VHI2cz05NPKX/EhcnWtJf3E8G3XdESAbAytphpDg/Vj6jg5dVdvYA2FaUXR87tYREe
         zDYv6q+jkDeypX7D74rRHD9AA5Ops0u3P0jmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=e3qxJPpJjuOYDNtzbvJAvcwlko5fcyw+n3Qn7CkaQIjB+83k0xAo9tWrF3J/GKDcwC
         eUbqGti+I/IiEVujjenilsR+ZQ01goZKK1jgr2ZqC/Jr14gw//VlS02I79nn0HXzo8o9
         cE60EyJXq0D4COe6PoN7cZ6lOuKCKXx2VkGJA=
Received: by 10.151.108.15 with SMTP id k15mr16667785ybm.88.1215814440381;
        Fri, 11 Jul 2008 15:14:00 -0700 (PDT)
Received: by 10.150.53.8 with HTTP; Fri, 11 Jul 2008 15:14:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807112310140.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88190>

On Sat, Jul 12, 2008 at 12:11 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> The mechanism is this: you look up the email in .mailmap (actually you
> parse that once, but the idea stays the same), and if there is a name for
> it, you use that _instead of_ the given author name.

Ah, so you suggest changing "format:%ae" to "format:%ae %an" and
falling back to the latter id specified on that line if the former is
not in .mailmap? That would work I guess, I'll put it on my TODO list
:).

> Otherwise you use the given author name, and typos be damned.

Fair enough :).

-- 
Cheers,

Sverre Rabbelier
