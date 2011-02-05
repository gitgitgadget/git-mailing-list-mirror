From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Fri, 4 Feb 2011 22:21:01 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1102042152070.14767@debian>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Feb 05 04:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlYi3-00029F-Qo
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 04:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088Ab1BEDVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 22:21:10 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57495 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab1BEDVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 22:21:09 -0500
Received: by qwa26 with SMTP id 26so2287201qwa.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 19:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=OfwnQy8ixo2KJP2Ze2cxHbGDYY9HOHphH80vKWlGVYY=;
        b=Y1dBmKFI11O1Pe+wdADHCWCO7mEIUi9BK797E8R6WMnBF0aBXccqbLMWeKkVwQCDpD
         PnI1HO/I7ESmNxldL59+kgJ0z5/3ywthqX7666p83k2/zIijCnfLMPoFSqM2bB8s/YYS
         fKc6gDIVgncM2C2tTZhbEWMXqBbzQRuxd5TOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=X0N/yqK5VHqZr9P2tZJEEnaNWW0byaooj2kh+lnfc3v4PM8aEH6EEbkbV62+3ie7PN
         MTcztQGleILhfyu4STATKE5Rls1p43Z7JD5sNY3j5+AWnd88SDaa2v03BiH2KUA0i0dx
         aix+qWsx0y0Tnm0Q9CSl2j3GwylTjB/y4cww0=
Received: by 10.229.98.131 with SMTP id q3mr385495qcn.236.1296876068384;
        Fri, 04 Feb 2011 19:21:08 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id q12sm994654qcu.6.2011.02.04.19.21.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Feb 2011 19:21:06 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166072>

On Mon, 31 Jan 2011, Nicolas Pitre wrote:

> 2) Create a build/ directory, or bin/ if prefered, to hold the result of 
>    the build.

I don't care much about the other items on the list, but I do agree
with this one. The biggest reason I like this is because it makes it
easier to tab complete. In all the cases so far that I have tab
completed "git-rebase--i" to open it in an editor or to run some git
command on it, I have wanted "git-rebase--interactive.sh"; I have
never wanted the build result.

It is also nice to have one less file to edit (.gitignore) when you
add a new source file, but that is of course much less important.

Are there any arguments against this part of Nicolas's proposal?

Btw, this is not really related to 1.8.0, is it? It seems to me like
it could be done at any time...


/Martin
