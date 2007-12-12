From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Wed, 12 Dec 2007 10:02:44 -0500
Message-ID: <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	 <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com>
	 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
	 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
	 <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
	 <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
	 <20071212041002.GN14735@spearce.org>
	 <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
	 <20071212052329.GR14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David <davvid@gmail.com>, "Marco Costalba" <mcostalba@gmail.com>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:03:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2T77-0006iX-Pl
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbXLLPCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 10:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXLLPCq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:02:46 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:48715 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbXLLPCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:02:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so443808wah.23
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hDrBM2Yr3IUx/uDnk7nZeD1bj0/750IOY4aGqbYwJR4=;
        b=UGjS7KeShM6OBfJ2DvFyIm0mCozXYXTg8VxfHlhFuP10ZSDGQ69q3KvInB+ViYlLSKM+NRjIn9hQRkxfUNOcljfxXMemLKFTxZxLHMaMqmAqFcUhwqxgLawmBWCIqZwvBP7x/rfksXV/xp//b7NCX2DJ7EzQCwjgVkToEOOtDvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GyA6AnhZ1TqGwEK3b1jjrTE4pYiDiGuVORm0WPoaPRUrp/+zMpZ+yGy7XdgwKoD+y/n9ARdi55rluCHq2npFXDKMB1CcQ2/sM+/fSiHHjA0WzXySVE4Twp3RGVjgGKLH0O6jaUzxrM0aFV7CLLlZ4MP8JtNGl9t6U3dJwQyNFzY=
Received: by 10.114.92.2 with SMTP id p2mr866371wab.90.1197471764826;
        Wed, 12 Dec 2007 07:02:44 -0800 (PST)
Received: by 10.115.18.14 with HTTP; Wed, 12 Dec 2007 07:02:44 -0800 (PST)
In-Reply-To: <20071212052329.GR14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68044>

On Dec 12, 2007 12:23 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > I use git-gui and gitk for my git graphical needs because they rock
> > and at the end of the day, the fonts and antialiasing aren't that big
> > of a deal, especially since I'm usually doing quick scans and searches
> > over the information those tools display, not reading novels in them.
>
> Good points.  Features win over pretty most of the time.  But at
> some point pretty is important; especially to new user adoption.
> Plus if you are looking at it all day long it shouldn't be jarring
> to the eyes.  But git-gui still isn't even where I want it ot
> be feature-wise.  E.g. I'd *love* to teach it inotify support,
> so you don't even need to have that Rescan button.

On that note, did you see what I wrote above, about having "split
hunk" functionality? That would be killer. I know, I know, I should
write a patch... well, I've got a paper deadline coming up, and the
time it takes me to run git add -i over some clicks in git-gui plus
the time to figure out how to add that feature doesn't balance...

Jason
