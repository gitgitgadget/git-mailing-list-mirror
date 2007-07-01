From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: t7004-tag.sh fails (old gpg?)
Date: Sun, 1 Jul 2007 17:45:37 +0200
Message-ID: <1b46aba20707010845s69fd3915p8460392ad92bba4b@mail.gmail.com>
References: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0707011507310.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 17:45:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I51cL-0006LF-KY
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 17:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbXGAPpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 11:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbXGAPpj
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 11:45:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:24958 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbXGAPpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 11:45:38 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1965429wah
        for <git@vger.kernel.org>; Sun, 01 Jul 2007 08:45:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cr6s7PGPcOpEDbecA+8JD2sx7v69i7rw3y3ctfm6Rdl2gl1OhYeJiv7j8aC734JCjJb30sjW2lr793vkpwmrPvwRPqm6HLy+qgqMiwv+FrLBY5IsQzpCNy9RHorOsyLMlLXqH+/BQ/tXdC/I9snXMLs5pbDrVIjHMrzpCtlmqCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M5M70mzABLGtc+wsqdqoJyfQXhFmXIUsI44GgOrJXcpmfSqQIi/iHfOdn+28npVNKVtLQjrVBuW1N+M9Hd5ymtPDOoC+o9MwOHn/IEaLDqQ6Ds1bSJkEeuwAtTJUQ5YjVyLYqKM97/Qrr/ZJBb+qrrC1Co7pV/3Gtwp3n0bxCCg=
Received: by 10.114.175.16 with SMTP id x16mr4306463wae.1183304737860;
        Sun, 01 Jul 2007 08:45:37 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Sun, 1 Jul 2007 08:45:37 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707011507310.4438@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51303>

2007/7/1, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Sun, 1 Jul 2007, Sven Verdoolaege wrote:
>
> > gpg: Warning: using insecure memory!
> > gpg: [don't know]: invalid packet (ctb=00)
> > gpg: read_keyblock: read error: invalid packet
> > gpg: enum_keyblocks failed: invalid keyring
> > gpg: skipped `C O Mitter <committer@example.com>': invalid keyring
> > gpg: signing failed: invalid keyring
>
> That means that gpg somehow barfs on the keyring. I somehow had the
> impression that the keyrings were binary compatible on different
> systems... What system do you have?
>
> > bash-3.00$ gpg --version
> > gpg (GnuPG) 1.0.6
>
> It is 1.4.5 here.

I have gpg (GnuPG) 1.4.1 here, in the system I used to generate the key.
