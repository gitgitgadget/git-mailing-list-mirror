From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: Why does git-svn dcommit rewrite the log messages?
Date: Thu, 2 Aug 2007 21:44:46 -0400
Message-ID: <e2a1d0aa0708021844y251273a4q9af44e066cca2b42@mail.gmail.com>
References: <e2a1d0aa0708011419m1f6cb323ge9e93680147a298@mail.gmail.com>
	 <46B23415.8030008@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Sam Vilain" <sam@vilain.net>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 03:45:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGmDs-0002uC-Be
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 03:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895AbXHCBos (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 21:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756966AbXHCBos
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 21:44:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:49946 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575AbXHCBor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 21:44:47 -0400
Received: by wa-out-1112.google.com with SMTP id v27so698167wah
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 18:44:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f+XXrunbejqvNk3LcyWCmXvqWPnAK7dHhhuywv/hUOwaoKWS+4yJ7Z1CnRIHLBw2DQnkQnlYATo4+FIVt7IpmplL6kzacSKP3lW2ScGTVAjWS78eVkBmBDQ6km0MXMIEDyifeTqcSwU18lzj9L1T/xCxtYftV+ByQuLl/osLxfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HtRsi+p/6Ex6kZjiZviYGxdWJA329MjS71eZTkwwvgL3Bhh10RvueYiiDENI2dWlFPX961hlMfKpXWoUYts8RAvTM3QqBSBC9DHfQkGMvauRJxvUgdHPcj75yuDDsJR4vTXMYk/r8neiHXrzhaqmpaENJVs4eVmczNsJXLo568o=
Received: by 10.114.151.13 with SMTP id y13mr2445442wad.1186105486356;
        Thu, 02 Aug 2007 18:44:46 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Thu, 2 Aug 2007 18:44:46 -0700 (PDT)
In-Reply-To: <46B23415.8030008@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54659>

> Primarily it's so that the person who pushed via dcommit and people who
> sync via git-svn fetch get the same commit ID (assuming they are both
> using the same authors map).
>
> It might be possible to store the extra information needed to recreate
> exactly the original git commit in SVN revision properties, but this
> would need to be implemented once and basically not changed after that.
>
> You can disable this behaviour, but you'll end up with duplicate commits.
>
> Sam.
Thanks Sam,
Now I see the noMetadata option.  I'll give that try and see how much
trouble I get myself in.

As I was thinking about this some more, I started wondering if perhaps
the information could be stored in a .git-svnid file, that was
versioned on the subversion server as well as in the local git
repository.

I'll have to think through the implications of your explanation in the
mean time.

--wpd
