From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: how to track the history of a line in a file
Date: Fri, 2 Jan 2009 13:49:34 -0800
Message-ID: <3ab397d0901021349h4ebae0c1g460a0c8abd4ec072@mail.gmail.com>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm>
	 <20090102212655.GA24082@coredump.intra.peff.net>
	 <alpine.DEB.1.10.0901021439080.21567@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Jan 02 22:51:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIrvJ-0005GA-0M
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 22:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772AbZABVti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758735AbZABVth
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:49:37 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:49696 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758608AbZABVtg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:49:36 -0500
Received: by qw-out-2122.google.com with SMTP id 3so5539200qwe.37
        for <git@vger.kernel.org>; Fri, 02 Jan 2009 13:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nLcsBgdnIiahRXns5E66OvUH4+bDGQeYltJdlV86gLQ=;
        b=U0mTZWkeKzNEK14MU014swMw+FCR6MN+Ua+votcXoUmZdFYzNNe6Fr59MwC7C217Ae
         FT7STBA5h2uTQpIww0UzSRXGA03I99d0lnOGvcJEkmbytskykkKiLgpgGYPtCHxX6BBe
         p8ESDp1H6DAcCMYSyB+1DltDca37vz1C8c9Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KtWedCCLUmOtRvGVM+/783VrCxVjrGr+rCUbB0gtgTBaEoB6k5LPry2IRbqR9+G0du
         6VIi8iq4hoRzki9di4Lf5ND2xLPwKzlMpID2z0I6R4t8f7jl1Y1TB3U4mATBYb/L27z9
         EV02b9k7NlyxottctQnWauG7uF6zPsGfYh/vQ=
Received: by 10.214.79.5 with SMTP id c5mr15442619qab.251.1230932974634;
        Fri, 02 Jan 2009 13:49:34 -0800 (PST)
Received: by 10.215.41.3 with HTTP; Fri, 2 Jan 2009 13:49:34 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0901021439080.21567@asgard.lang.hm>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104420>

> -oldline
> +newline
>
> it's a 1-1 correspondence
>
> if it's instead
> -oldline1
> -oldline2
> +newline1
> +newline2

what a neat idea.  i'm going to start malloc'ing 10,000 lines x 120
chars for each file i add, and edit them so that no new lines replace
removed lines unless it's intended that they were the same line.
