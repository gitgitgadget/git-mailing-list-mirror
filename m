From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: adding file by absolute name -- problem
Date: Mon, 23 Apr 2007 15:39:57 +0200
Message-ID: <1b46aba20704230639k56fc1839qcad38f1e5ee0e238@mail.gmail.com>
References: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com>
	 <Pine.LNX.4.64.0704231215370.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Yakov Lerner" <iler.ml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 15:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfym1-00008P-Dy
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 15:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbXDWNkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 09:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbXDWNkF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 09:40:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:45777 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbXDWNkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 09:40:04 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1541762wra
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 06:40:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j8y1eHt5g2qEOYfqz3hwOHWcakqYpfTvPyvbUmjNk4lMICJeI217IzC6BMamNGgJ44u9PM21l0ocf0fXwEZUq0IbytowmgzyTinDPxTtMlYJQIZop+diodaUOsg6ZcKJikcRU7l+scslWLfMHwWVG8kVWdlcPBV43Ri65GzksUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qndiiSBpvxrd7KD9R+ssNkofyVc7FHbcv+ZPfj5xg+TcYELy4b5HiuZ6nbhb+u8F/j79MzO2sJhvlHbaqGY8IEDKPMT6KtmIXjhGxAtYVZN1WlCzk4ENpD4/elCfnCJJ9tdVGuqk5qoc5JGFPoslA0PIMNZ3sgmU/ZgtkYBV4xg=
Received: by 10.114.130.1 with SMTP id c1mr2526150wad.1177335602526;
        Mon, 23 Apr 2007 06:40:02 -0700 (PDT)
Received: by 10.114.58.13 with HTTP; Mon, 23 Apr 2007 06:39:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704231215370.8822@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45321>

Hi!

2007/4/23, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 23 Apr 2007, Yakov Lerner wrote:
>
> > When I give absolute pathname /a/b/repo/d to git add, it
> > mostly does not work. I get errors from git-add. Is it by design ?
>
> AFAICT it is by design. I fail to see why absolute paths should be
> supported, too. You are supposed to be _in_ the working directory when
> adding files...

Since it is by design, a posible solution could be support an optional
parameter to give the program the path of the directory (something as
--dir /a/b). Then you could build a command line to be run from
another place, without using absolute paths in the rest of parameters.
Maybe it would be easier to implement by interested people. Anyway, I
don't need this feature, too.

I think that if currently the program does not support absolute paths,
this should be clearly stated in error messages and check for that in
a centralized place.
