From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: New mailmap file for the kernel
Date: Mon, 28 Jul 2008 13:53:08 +0200
Message-ID: <bd6139dc0807280453rbfc28ffid8314e74cc19b7f7@mail.gmail.com>
References: <9e4733910807272145y5b67112er4b90cc36141663c1@mail.gmail.com>
	 <alpine.DEB.1.00.0807281251000.2725@eeepc-johanness>
	 <bd6139dc0807280411k3a283c5dr4b874342aab167dc@mail.gmail.com>
	 <alpine.DEB.1.00.0807281321540.2725@eeepc-johanness>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:54:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNRIp-0004Fs-CF
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbYG1LxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 07:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbYG1LxK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:53:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:5101 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYG1LxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:53:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5687457wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vVJq02Pt8KVMIBiK3oHaJmzrfvwBHo3Z2q4tfy4EMd4=;
        b=kF4DkWvasXooiiuWEal4sMTlMKVJMNdPENJ1qXDldutOTT55PZR1LgET+DVWgQ+o9X
         AwBD4LiB/5xPZlrWnYcnh/xypnACGMDltFh9NWhmdKDQQxdj+atDT+d/VNyyHYjNiy7U
         RNzF69S1QTam13rkYx4qqa9Ye+IoXmBIYnMVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=mP2jUvFUNa9Z75MPqUquytqL/PBWRyXDqGSKlGTssnvcA8iEc9f/Nr1wNGz5O0wA5C
         mPajUokDacSZ/5a4sr8LUy59uyAtvxehvryn4wGPHueKvRfIEw+QHRGzMhWNcjqpFuFL
         G6jEhepgUbu286CmuCMeK2ELsc3/lGsOfHEZw=
Received: by 10.142.156.2 with SMTP id d2mr1553696wfe.321.1217245988896;
        Mon, 28 Jul 2008 04:53:08 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Mon, 28 Jul 2008 04:53:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807281321540.2725@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90447>

On Mon, Jul 28, 2008 at 13:23, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> And how exactly do you plan to make sure everybody has that hook
> installed?

It needn't be installed with everybody, only at the people that form
'upstream' (in the git case that'd be Junio, in the Linux case that'd
be Linus and his lieutenants).

> Also, it would be a major hassle, just for the benefits of statistics
> (which, funnily enough, not everybody cares about).

Hmmm, I'm not sure if it would be a major hassle once it's set up?
Once everybody has their name correctly in the mailmap nobody will
have to care?

> But we are not truly distributed.  Our community is small enough, and our
> maintainer good enough, that we do have a single upstream essentially.  We
> do not even have lieutenants through which new developers could come (and
> therefore would be old developers once they hit master).

Ah, I did not realize that. Thanks for explaining.

-- 
Cheers,

Sverre Rabbelier
