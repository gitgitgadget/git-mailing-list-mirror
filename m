From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: format-patch to diff-tree change breaks binary
 patches
Date: Mon, 5 May 2014 09:14:56 -0400
Message-ID: <20140505131456.GA21505@padd.com>
References: <20140425044618.GA7058@olive>
 <20140426124307.GB4767@padd.com>
 <535C2138.3050400@gmail.com>
 <535C25B5.4050506@gmail.com>
 <53648169.7010307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cdleonard@gmail.com
To: tolga ceylan <tolga.ceylan@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:41:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi0n-0006KZ-AW
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbaEENV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 09:21:27 -0400
Received: from honk.padd.com ([71.19.245.7]:42847 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932272AbaEENV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 09:21:27 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 May 2014 09:21:27 EDT
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id 4F09C5B41;
	Mon,  5 May 2014 06:14:59 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3A0732113B; Mon,  5 May 2014 09:14:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <53648169.7010307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248148>

tolga.ceylan@gmail.com wrote on Fri, 02 May 2014 22:40 -0700:
> 
> >
> >This is the error message git-apply emits in this case:
> >
> >error: cannot apply binary patch to '<filename>' without full index line
> >error: <filename>: patch does not apply
> >
> >Cheers,
> >Tolga
> 
> Any feedback is appreciated.

Sorry, travel delay.  This explanation is pretty
straight-forward, thanks.

Suggest you include it in the commit message along with the
other text you had, and resend to the list, cc me and junio.
Oh, and include an ack:

    Acked-by: Pete Wyckoff <pw@padd.com>
