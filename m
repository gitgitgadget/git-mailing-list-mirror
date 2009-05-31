From: Aaron Gray <aaronngray.lists@googlemail.com>
Subject: Re: Resetting working files
Date: Sun, 31 May 2009 17:50:35 +0100
Message-ID: <9719867c0905310950x153db8efw179a8a10ac3f4640@mail.gmail.com>
References: <DA26600008CE404B831978F6EBB31C6B@HPLAPTOP> <4A229B9A.6060807@dirk.my1.cc> 
	<20090531162515.GB8129@m62s10.vlinux.de> <20090531163225.GE3674@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Peter Baumann <waste.manager@gmx.de>,
	Aaron Gray <aaronngray.lists@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 31 18:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAoFV-00029o-Cj
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583AbZEaQu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 May 2009 12:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757369AbZEaQu4
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:50:56 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:39688 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096AbZEaQuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 May 2009 12:50:55 -0400
Received: by bwz22 with SMTP id 22so7047324bwz.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=D7/408O4dpCd+oGTa11rD34sUJZyeq6zu+uiRxZAaLs=;
        b=UvzpBAgyiTNquJt+Au1qSJ2pGBADQlVVwDs5kEXFSvjqywRKJA9h/hHMK3uZFqhyVp
         qYj4It3DTLapuzU/CEHC22YMsIfbQb3P7UL06qHTDRgWGP1a/FQsCHb0IH0FhKD56UAh
         g/ybi/UmuBltCbSXHE5Hsi8bjj8/yNzFvLkec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=OK8y+5Twdr3eoYMilBEA5gneTC18XYMtdQqGbWYHutS58v938UkuA8T5hwMEu+iM6L
         tgTCemonZuggg8bPZezq/otR1PrGNMtEnLR1n9Tqy8cmMcEK4T02e8d9pbHf/7NFaRiN
         1aKWGfOyfYXX4OTetJO3xfG0B0SdTGzZwh6eE=
Received: by 10.204.70.135 with SMTP id d7mr4745792bkj.194.1243788656119; Sun, 
	31 May 2009 09:50:56 -0700 (PDT)
In-Reply-To: <20090531163225.GE3674@debian.b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120421>

2009/5/31 bill lam <cbill.lam@gmail.com>
>
> On Sun, 31 May 2009, Peter Baumann wrote:
> > =A0 =A0 =A0 echo modified >> a.txt
> > =A0 =A0 =A0 git add a.txt
> > =A0 =A0 =A0 git checkout -- a.txt =A0 =A0 =A0 =A0 =A0 (1)
> >
> > =A0 =A0 =A0 git checkout HEAD -- a.txt =A0 =A0 =A0(2)
> >
> >
> > (1) This will do nothing to your file 'a.txt' in your workdir becau=
se
> > =A0 =A0 the index and the workdir are identical
> >
> > (2) This will reset your file to the state before you run that bogu=
s
> > =A0 =A0 echo modified >> a.txt =A0 comand
>
> I still do not understand what index is.
> 1. is index an replica of the committed tree
> 2. is index only transient in that its content will be reset once
> =A0 committed?
> 3. or other ?

I think index is HEAD or a revision hash. Am I correct ?

Aaron
