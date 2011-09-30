From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: RFC: reverse bisect
Date: Fri, 30 Sep 2011 07:31:41 +0200
Message-ID: <op.v2lwa4rp0aolir@keputer.lokaal>
References: <20110929142027.GA4936@zelva.suse.cz> <4E849C5B.7050201@kdbg.org>
 <20110930040924.GA28724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 07:31:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9VhR-0005To-RG
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 07:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab1I3Fbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 01:31:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59327 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab1I3Fbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 01:31:45 -0400
Received: by eya28 with SMTP id 28so869680eya.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 22:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=wyY0Ri7zOVSEFq3cNetCodPAoTA+reF2OTiIP4spehY=;
        b=Kvfe/NcKqzF+3oNJ5vp5ziN5aRbC4iqZ5jeXp/7ceTwjcfifzGkifJfII47t2wl06t
         Kn0ykBm3bJE+IwfO1qsjQ/Dq/56Em28MpuVL/ZEP/69dckNWpJ54bdfZF6TwfTTZ9ooC
         gWEWbaVyVbmDnFXn57gUkn1mcwemJ0ZAxHW/o=
Received: by 10.14.20.65 with SMTP id o41mr4128956eeo.55.1317360703906;
        Thu, 29 Sep 2011 22:31:43 -0700 (PDT)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id x45sm5606248eeh.11.2011.09.29.22.31.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 22:31:43 -0700 (PDT)
In-Reply-To: <20110930040924.GA28724@sigill.intra.peff.net>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182465>

On Fri, 30 Sep 2011 06:09:24 +0200, Jeff King <peff@peff.net> wrote:

> One catch is that the run command assumes a successful exit is "good",
> and anything else is "bad". Which makes:
>
>   git bisect run make test
>
> good for finding regressions, but is a little counterintuitive for the
> yes/no thing (a successful exit means "no").

Then you would require a script that inverts the result, no? From my
point of view it's either that or add an option telling bisect run how
to interpret the results. In the latter case you could still consider
adding the regression/improvement qualification to bisect start. It might
help getting the mind set right.

Frans
