From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 16:34:26 +0100
Message-ID: <dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com>
References: <200701150144.56793.jnareb@gmail.com>
	 <200701151003.44498.jnareb@gmail.com>
	 <20070115095613.GA4037@localdomain>
	 <200701151132.00971.jnareb@gmail.com>
	 <20070115112635.GA5134@localdomain>
	 <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:34:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVd-0000J2-Es
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:37 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VAg-0003eK-TP
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbXAOPeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 10:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbXAOPeq
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 10:34:46 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:22907 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXAOPeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 10:34:44 -0500
Received: by wr-out-0506.google.com with SMTP id i30so1049250wra
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 07:34:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MirxqEusp+WQyuXiiLPt00Dj3tsS+gUuoFsKg7DWl9+OZdUOmA1Fm6zDNMa2/uiK/PKaTf3taulbvjdTZxR9hH8aj8lzvt3Wra30HnHo+K8c9IbXDOHRoJpl58CaSPIFo/R2ZoBMGFhhHChWsqzoSC5y1WUjO4GJAn9nlkIaLN4=
Received: by 10.78.118.19 with SMTP id q19mr2584990huc.1168875276773;
        Mon, 15 Jan 2007 07:34:36 -0800 (PST)
Received: by 10.78.200.7 with HTTP; Mon, 15 Jan 2007 07:34:26 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: d43d774197166d70
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36845>

On 1/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> On Mon, 15 Jan 2007, Eric Wong wrote:

> > > Would you write "git repo-config --perl", then? ;-)

> > The below patch should be a start (only tested on my fairly standard
> > .git/config).  A --python option should be easy, too :)

> A bit shorter (and gets the booleans right, plus being even easier
> towards --python extension):

If we're going down this slippery slope, why not just give up and add
a --xml switch instead?  Readable by all and a lot more flexible than
--perl, --python, --ruby, --tcl, --sh, --c++, --fortran, --lisp,
--html, --that-next-silver-bullet-language-that-hasnt-been-invented-yet-but-will-need-its-own-switch-once-it-has-been.

That said, parsing the config file as-is can't be so difficult that we
need to export it to separate files with a different syntax, now can
it?

  nikolai
