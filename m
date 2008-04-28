From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use whitespace.
Date: Mon, 28 Apr 2008 10:56:05 +0100
Message-ID: <e2b179460804280256g4ff903bu39c9460086df7157@mail.gmail.com>
References: <20080427151610.GB57955@Hermes.local>
	 <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness>
	 <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com>
	 <20080428094119.GA20499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Gernhardt" <benji@silverinsanity.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:57:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqQ6T-0007Ow-Tr
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 11:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765098AbYD1J4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 05:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765100AbYD1J4I
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 05:56:08 -0400
Received: from rv-out-0708.google.com ([209.85.198.244]:30497 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765098AbYD1J4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 05:56:06 -0400
Received: by rv-out-0506.google.com with SMTP id k29so2872852rvb.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BDmLWwGMuKsJJmP6Vi/XZeshxGoTw5BnUN0bwvOYWX0=;
        b=cr6qQE3MrZsxiIWjbW72Y6qywnQJrOj+fDr9spYbJUP7mPrBbMek96bSzzuZgujM3cXAXZkmNmlsh31kW8Ttcw/amIFPDpML+Hc2HZpikJp3DAfzp/QutcnoJ99/3ZOSmSXR62LxvpRDjyLxKGBg3xcuVqd/fXLJQ8EQNFxc3xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tDKcJGnrCIkQPzxeNzTRId04CVIcUniztx5evZxuGfiYwAS0maB4NRY3sUTzQsYTzfJCxZHM1lbz8K9n4TaEUFIMjf/gGVGFAg+KDvxDGrpDiLAIlO+Vs97Bm3ukbNxMaATOgpHQxRGTDD843sYz1xQtZWBUrc3aud8gtHhh25o=
Received: by 10.141.141.3 with SMTP id t3mr2323380rvn.52.1209376565670;
        Mon, 28 Apr 2008 02:56:05 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Mon, 28 Apr 2008 02:56:05 -0700 (PDT)
In-Reply-To: <20080428094119.GA20499@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80519>

2008/4/28 Jeff King <peff@peff.net>:
> If a failing test, then I wonder if we could get a few people to set up
> automated tests on alternate platforms. IIRC, Junio makes sure that
> master always passes test on his Linux box and KO (Debian and Redhat, I
> think?). Other platforms could "git pull && make test" daily. I could
> probably do Solaris (once I get the tests to complete pass at all!) and
> FreeBSD 6.

I could run automated build / test [/ bisect?] cycles on AIX if of any interest.

Mike
