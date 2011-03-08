From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cherry-pick -x: add newline before pick note
Date: Tue, 8 Mar 2011 16:34:48 -0600
Message-ID: <20110308223448.GF26471@elie>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
 <loom.20110308T134920-72@post.gmane.org>
 <20110308220843.GA27156@elie>
 <20110308221855.GA4030@ugly.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Martin Svensson <martin.k.svensson@netinsight.se>,
	Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>
To: Oswald Buddenhagen <ossi@kde.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 23:35:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px5UZ-0006A1-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 23:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab1CHWez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 17:34:55 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57356 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab1CHWey (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 17:34:54 -0500
Received: by vxi39 with SMTP id 39so5172196vxi.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ieAFG7kTTqMS/JG7toovS+QhOGH82C5Y+Ggymm/Q2/I=;
        b=fgdWMhPLm28F7EzioddSReKWY+ru4LdMfNPXunUxqreHqhPtEvBLs/HcovQgyuDFXf
         g+anwwE30l5BsO/e/U4J24Be+iwaUvfEzvVjlfNosN65wt7aeUzfFuMinICFJuDv8Cd0
         bn2EC87q7uU93PFC6Gofah+YENzsW09P/hfR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kyqOeb3aRPmSCYKRCavUQm3Ps1Z0CWoe7r+aRQ7mx3jUJFCnOOg0p4gcq5BRZF6Wyg
         YAM47M+YU4R0Zq+LI1Rfi5mEpU4TI89ItZ01Bu+5HfGKN9oGP/Ev2fNp6vESwFFWGrOH
         AKgTkcCikDLlNOiFqXrfATSWPAshd8opIbBWE=
Received: by 10.52.97.2 with SMTP id dw2mr1054049vdb.54.1299623693545;
        Tue, 08 Mar 2011 14:34:53 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.sbcglobal.net [69.209.61.99])
        by mx.google.com with ESMTPS id cc16sm243011vdb.44.2011.03.08.14.34.51
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 14:34:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110308221855.GA4030@ugly.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168712>

Hi again.

Oswald Buddenhagen wrote:

> i posted via the gmane webform ...

(See <http://thread.gmane.org/gmane.comp.version-control.git/154490>.
It's obnoxious that there is not an easier way, I agree.)

> i did a much simpler patch in that vein as well, but scrapped it again -
> totally overengineered. the idea is to optimize the simple case -
> cherry-pick -x, push. everything else needs amends anyway.

It's been a vague wish of mine for a while to fix "cherry-pick -x -s".
I currently use it without amends and tolerate the blank line between
the "cherry picked" and the sign-off.

Maybe you can convince people that wanting no extra blank line between
an existing sign-off and the "cherry picked from" line is
overengineering and worth regressing.  I am not a fanatic about it ---
I just thought it was worth mentioning that this proposed change would
not be seen as positive by everyone.

Put another way, I don't find the two words "totally overengineered"
very convincing here.  For what it's worth.

Cheers,
Jonathan
