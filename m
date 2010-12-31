From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 18/31] rebase: extract merge code to new source file
Date: Fri, 31 Dec 2010 09:05:01 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1012310841340.16976@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <201012292231.33333.j6t@kdbg.org> <alpine.DEB.1.10.1012292315070.7175@debian> <201012311323.47102.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 31 15:05:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYfbZ-0003Qk-7l
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 15:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab0LaOFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 09:05:09 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63371 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab0LaOFI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 09:05:08 -0500
Received: by qwa26 with SMTP id 26so11921880qwa.19
        for <git@vger.kernel.org>; Fri, 31 Dec 2010 06:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=o3/rPBrM3jTiIeQ215s76+c3ACC7UeTHHerKUWenbo4=;
        b=e8uWQ142a6Pr64OyP+wWqzOI67XWimfoVE6IckYlgIjdAj++0S78Fc34GOviBkSi2T
         LPcIUEg3zA0Nl4yptACQWH3d1koWhOzE4FRCYJkkBl/I7SiU97fW0T6Wrl+ZSoLyIKnf
         gyArf6HT3Mhse+sJCS+2mSJ3FhdwYX6PdJ5Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=t30ze+evAjvZtyW/CMfnhabIt6irp1p2/5rRIBBgqVSEBPBMD7L9o2RGUf7Cl2Z+GH
         oxqv5xqaW9t5jR5MOb7urxzkj2Fmn8sp+ICMn2teFoA+/3Z8GAlPi930zawCN1EDDGer
         PB9BM+++a9dnbUULSRhi8N985AIeIrYjLe7mE=
Received: by 10.224.63.218 with SMTP id c26mr16966755qai.24.1293804307371;
        Fri, 31 Dec 2010 06:05:07 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id q12sm9999081qcu.6.2010.12.31.06.05.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Dec 2010 06:05:05 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201012311323.47102.trast@student.ethz.ch>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164382>

On Fri, 31 Dec 2010, Thomas Rast wrote:

> Martin von Zweigbergk wrote:
> > On Wed, 29 Dec 2010, Johannes Sixt wrote:
> > > 
> > > Is export -f portable?
> > 
> > It seems like it isn't. What is a good way to check?
> 
> On my system I have POSIX docs for various commands, coming from the
> 'man-pages-posix' package.  Maybe your distribution has those too?
> Then you can simply run 'man 1p export' for the documentation.
> Anything that is documented there should be safe (except on Windows
> maybe).

Thanks. I'm running Debian and I just installed the package from
non-free. Thanks for the hint on the '1p' syntax as well.


/Martin
