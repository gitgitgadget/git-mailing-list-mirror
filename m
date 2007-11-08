From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 00:16:59 +1100
Message-ID: <ee77f5c20711080516n4f207ba3pccc8efffa2a6ad4c@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <Pine.LNX.4.64.0711072242230.4362@racer.site>
	 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
	 <Pine.LNX.4.64.0711072255420.4362@racer.site>
	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	 <243E1E6E-4723-42D3-933C-D2A0D1ACE287@silverinsanity.com>
	 <ee77f5c20711071531q5acc4d06u264f5daad7c04cc4@mail.gmail.com>
	 <47325415.1070205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Jon Smirl" <jonsmirl@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:17:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq7G3-0000L5-Em
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 14:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072AbXKHNRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 08:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbXKHNRC
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 08:17:02 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:26780 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbXKHNRA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 08:17:00 -0500
Received: by rv-out-0910.google.com with SMTP id k20so138556rvb
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 05:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=k6v6hPKGixhC1tDdSgtoV9H0NQshbUPGoyFPsEUmyA0=;
        b=JjCD4R71G4JJvgX2+uL31ofrW1U2qKFggL30Sd+TPUE18R+zXqd7DYqx/fUHxCYEvL7Wf0n/QOrgqR91a1+LYNYqUZFjLsczL7fet1fMRHY6wcvPBX39RUJhqKaWwKPZ3ZshFzFpCyy04KYvF2s4gnh0+VmAdI0F8KSFfFaryXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=onOtGBBmGNkne8eM2jrY8fukHBmBHeIbDC2Kc9y39vvZp6XPb0LcdVTBhzEG+2rG29TWQQ9dvapPQr8IO+Sn8bklraVuRB0RrvGiA7Y0s2TDANzA0aYRQvaoLCKH776X0/YDdRldfVwX52/HbRa1UT+IMC2QuGtTeHvF5B4+cPM=
Received: by 10.140.136.6 with SMTP id j6mr232334rvd.1194527819645;
        Thu, 08 Nov 2007 05:16:59 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Thu, 8 Nov 2007 05:16:59 -0800 (PST)
In-Reply-To: <47325415.1070205@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64017>

On Nov 8, 2007 11:11 AM, Andreas Ericsson <ae@op5.se> wrote:
>
> David Symonds wrote:
> > On Nov 8, 2007 10:19 AM, Brian Gernhardt <benji@silverinsanity.com> wrote:
> >> However, Dave's suggestion of altering git-status output to be
> >> relative to (but not limited by) CWD has merit.  Too bad I don't have
> >> time to work on it right now.
> >
> > I am happy to hack on this if there's not widespread revolt against the concept.
> >
>
> I'd definitely like that feature, but I wonder how many people will run
> "git commit -a" in a subdir after seeing only what they want to see in the
> output, and then accidentally committing junk somewhere else in the repo.

I never suggested path *limited*, only path *relative*. git-status
would still show all the same files, but their paths would be relative
to your current directory, so there'd be no confusion like you
mentioned. This is how Johannes' patch works.


Dave.
