From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: mirror git repos: rsync vs. --mirror
Date: Wed, 31 Mar 2010 07:14:46 +0530
Message-ID: <t2r2e24e5b91003301844i6ea98c92j6dba55d916c841f5@mail.gmail.com>
References: <robbat2-20100330T205331-531407911Z@orbis-terrarum.net>
	 <3a75d1efc7cf125d84b8e02b7dabf7aa@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Mar 31 03:44:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwmzG-0004ot-JT
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 03:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681Ab0CaBos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 21:44:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756644Ab0CaBor (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 21:44:47 -0400
Received: by vws20 with SMTP id 20so1207695vws.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 18:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=Cy4zr0KJBDTEcUjyY1cGrdR2dHr3nVkzkYEjm2p7hlc=;
        b=Hn4KqH43tFOcVjZRaU4yL3wdI0W9pwvIIb576Ey3ssqMWdh5ooh79ZbAC71aufb+hh
         acxzyZFYn7YPaLCCp5O9p6ip0pxjJLk5JeOBwnvC2jVVaZAAxrDKK4vsRT/NsYYnV3q1
         3eK+MP32vliGmFYwpqzGsyeZ2QtRvnhbuXsoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vW0TVwmXGD2cFWzvxhBRh5k7050m6QTt4lnYSCK+ybNpFKTLIe3hC9RqfLRDMcWdwJ
         f+fm5ofcVEmW5tj788hEvw57bJ7W0i50qoOovixtuLzL9V7CJ/0m0kAJ/LwyZg+x36yD
         rlpa8/Di1jV+cosZa3ptmj50+Jgi1Q0ZbnJU4=
Received: by 10.220.100.212 with HTTP; Tue, 30 Mar 2010 18:44:46 -0700 (PDT)
In-Reply-To: <3a75d1efc7cf125d84b8e02b7dabf7aa@212.159.54.234>
Received: by 10.220.128.136 with SMTP id k8mr363903vcs.178.1269999886841; Tue, 
	30 Mar 2010 18:44:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143633>

On Wed, Mar 31, 2010 at 3:30 AM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> On Tue, 30 Mar 2010 20:54:09 +0000, "Robin H. Johnson"
> <robbat2@gentoo.org>

>> git clone --mirror && git fetch:

>> Caveats:
>> - Branches and tags deleted in master persist in slaves :-(

> I don't think that fetch can do it, but "git remote prune origin" will.

as of 1.7 at least, fetch has --prune, and I tested it yesterday when
someone (same person?) asked this on #git
