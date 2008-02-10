From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 08:46:30 -0800
Message-ID: <ee77f5c20802100846g10937a49m4901f88a70a6de0@mail.gmail.com>
References: <200802081828.43849.kendy@suse.cz>
	 <alpine.LFD.1.00.0802081250240.2732@xanadu.home>
	 <200802091525.36284.kendy@suse.cz>
	 <e5bfff550802092323u3ec3c9c8uf6e92399395efd27@mail.gmail.com>
	 <alpine.LSU.1.00.0802101207330.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Jan Holesovsky" <kendy@suse.cz>, "Nicolas Pitre" <nico@cam.org>,
	git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:47:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOFKd-0002Jg-M2
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbYBJQqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbYBJQqc
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:46:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:61876 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbYBJQqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:46:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1648333wah.23
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DlNXB4IXClzYEnKRrjZLU8exV56/IgzPtFNAOKdGeeg=;
        b=gysfFaPCfVzP0waYfn0X2GFDCmFrzws8UY5FPNQnMojRRSVm3ModuqWiPYUuELlguTq5PtzG3eRqG8aIlHtsIe0UUKSFCEyZQnBrUFws3MEEpf73YEHRa7KenM82j8VoGnL5X+UeiJP5fWs89HDK76Y31HAZ0YmDL+yYmD67zTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Je4z9isWdlF/EN7xPchIg57BMXOCQMIcNFmE6Hmlvy+fAFJckxh0y/TCEfkRTHvq+6mRAtY9obWDDd73epwgvvpAkRTcE3XFXlVYqiyF2lDo7HfhuLNlbSMyKcpPciNKBzBA1HCTgAdsHS4TcIcmnutM5p1+SdSb6+CbsyCY4aM=
Received: by 10.140.144.4 with SMTP id r4mr10028224rvd.15.1202661990458;
        Sun, 10 Feb 2008 08:46:30 -0800 (PST)
Received: by 10.140.135.17 with HTTP; Sun, 10 Feb 2008 08:46:30 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802101207330.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73372>

On Feb 10, 2008 4:08 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 10 Feb 2008, Marco Costalba wrote:
>
> > Linux git repository is not very big and can be downloaded with easy. On
> > the other end Linux history spans many more years then the repo does.
> >
> > The design choice here is two have *two repositories*, one with recent
> > stuff and one historical, with stuff older then version 2.6.12
>
> I do not think that this is an option: Jan already tried a shallow clone
> (which would amount to something like what you propose), and it was still
> too large.

I think that was still pulling all the branches, so a shallow clone of
just a couple of branches might be feasible.


Dave.
