From: Kalle Launiala <kalle.launiala@gmail.com>
Subject: Re: git with large files...
Date: Sun, 22 Jul 2012 12:37:23 +0300
Message-ID: <CAHLTmjmGs5NR96krBozdD2AaZ3NXM2E-FfH-pV6BxwOVsojX5g@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
	<86fw8mf3gp.fsf@red.stonehenge.com>
	<CACPiFC+a=46n-igTUBSDdpgDQyL4cz5vrcpurNBSsb+D1c0UnA@mail.gmail.com>
	<CAJDDKr5vZz_DepYKvdu34G60fmm8V_Sv8FU+J6O-DLoum07+jA@mail.gmail.com>
	<CA+EOSBk8XjA5=BO_kVOmfCPT-n2vKV1rbqUHnOnGi-ORF7wKLw@mail.gmail.com>
	<CACPiFCLTPi5i3RZHwOD-+OJ_zSbtOwe7VLy=NMO1MUKPVyPHEw@mail.gmail.com>
	<CA+EOSBkVh-PvASXf5NOOW40MWzt4gdBm-21ER1EbUWLkCJ3cCA@mail.gmail.com>
	<CA+EOSBm2o+9j0Ykpe01tQmTGApZeJA36mJ=Kt8bNAywfpbODPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 11:38:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sssc0-0006G1-Sb
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 11:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219Ab2GVJh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 05:37:57 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60155 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab2GVJhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 05:37:24 -0400
Received: by vbbff1 with SMTP id ff1so3955760vbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LPJ+ROyhjMCP6zidFRTWX7tnEuLr8n+KmQnf9sfzJO4=;
        b=CAMFiQJUZY1PFg+9/E0J54zYSKtQWPNeXel35Zw1fHnNLwRWtQ28876VIQ8h7RPY/l
         GJ0868582ytluKqs0YAFUbbX6W7RNxaRyrQY8ppZ1Wi64afhcP0JP3SKCD90B+ZzUs15
         hAXfSt5y7AkHrjOYsNSKMOdgVmbv5xeERQ+CrVzZe9S43jlAfUhMc52gkd+3bxPbXs8G
         wBPBIfuaxKhQY32y4jNoM62LaEh+6emCG7uhUYpEgsf6t3ZQ1mQwE5Ph399oMT8rlwRm
         yaRPRSjf9kptP0yJZ7tbzfoGlDn8Yf6STPDjokehjUzI3rpvZZJOB3usBDtIswO86BEo
         yvGw==
Received: by 10.220.219.7 with SMTP id hs7mr9324734vcb.0.1342949843254; Sun,
 22 Jul 2012 02:37:23 -0700 (PDT)
Received: by 10.52.162.97 with HTTP; Sun, 22 Jul 2012 02:37:23 -0700 (PDT)
In-Reply-To: <CA+EOSBm2o+9j0Ykpe01tQmTGApZeJA36mJ=Kt8bNAywfpbODPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201844>

While my example isn't about puppet, it's about another templating
technology - that is by technical design hence also completely open
source. We have a completely modulirized and completely distributed
deployment scenario that is based on git.

The fundamental core how git addresses the solution is explained here
- especially on the visualization.
http://abstractiondev.wordpress.com/git-based-distribution/

I'd like to add a point of view that will underline git behaviour as a
core requirement on distributed depoloyment - if there is any issue
with big files, that's a good concern to address.

While this can be well justified and argued to benefit for possibly
platform specific deployment tools such as rpm or msi modules, the
audit trail of distributed software (the core requirement for source
code andyway) still remains. If there is a "big file" that is part of
the audit process, it's consistency needs to be guaranteed. And there
is no way around it but the git way of doing complete secure hashed
history trail.

This is not "nice to have" feature, but critical requirement to deploy
embedded software for automated machinery to suffice safety
regulations. Hospital, aviation, nuclear device software all apply
here. Distributed software processes and projects all benefit from
this - and trying to "cut short" some part of the complete audit trail
of development will cause larger pain points elsewhere.

So is there real problem with big files performance or storage files?
Anything else than "uncommon" slowness on calculating and comparing
large file sha1 hashes?


Kalle
