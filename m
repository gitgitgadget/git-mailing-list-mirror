From: Eric Raible <raible@gmail.com>
Subject: Re: RFH: spawning pager takes long time when when unconnected from 
	network
Date: Tue, 10 Feb 2009 03:55:48 -0800
Message-ID: <279b37b20902100355r44985270x50ff8cb8a072868d@mail.gmail.com>
References: <loom.20090210T015515-886@post.gmane.org>
	 <4991337B.2010102@viscovery.net>
	 <loom.20090210T085859-630@post.gmane.org>
	 <alpine.DEB.1.00.0902101124160.10279@pacific.mpi-cbg.de>
	 <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
	 <20090210110729.GC12089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrEr-0007vI-Bb
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbZBJLzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZBJLzu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:55:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:17291 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZBJLzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:55:49 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2266139rvb.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AbsVNHIigQbc0BjKE3spKKqOmmBuRttgmb0wA3Jl3GM=;
        b=OGC3lW0j1FCnl7J4NH3lsyPVazflTE/nEYe5mbGSr39X0BRcIeTsvfJPw2v3jnEs1S
         q8R8M74M6sDz/FJrmD7wDWw8JwkzXQ91+MQYdBeotGGyRE1ek7jasUt7MAheAiPXyLRM
         EtO435q6O/KT9PibWb4iQJbXkrz2+gNAOA8JE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jD6lEwCucyoFv7FfnY4vGU5Yvd8kDR4IEpjZvVNwp1C6U069KWmzCeYE8c4ga+xWtj
         QGWqltNTEsGtFAtyM5HZHvZdpK6/ULEfs7vdcjHqCETbMAZyQyLcXwJly+KWPmlroIdE
         oxAzyyy241+jjr+amxXBoydrHgC50Q9L9n/Tw=
Received: by 10.141.197.21 with SMTP id z21mr503813rvp.107.1234266948820; Tue, 
	10 Feb 2009 03:55:48 -0800 (PST)
In-Reply-To: <20090210110729.GC12089@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109217>

On Tue, Feb 10, 2009 at 3:07 AM, Jeff King <peff@peff.net> wrote:
>> The long pause in question begins after the above output is produced
>> but before the list of files is shown.  The output is identical when setting
>> GIT_TRACE to a file.
>
> Does your shell run a .profile or similar, and if so, is there anything
> in it that might touch the network?
>
> -Peff
>

My shell is the standard vanilla msysgit shell, with no customizations.
It does of course seem that something is touching the network, but I
have no idea what that might be.  Nothing in my path, that's for sure.

- Eric
