From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: Solaris test failure -- FAIL 61: invalid bool (set)
Date: Tue, 19 Feb 2008 19:11:01 -0500
Message-ID: <8ec76080802191611s3348beb1icd0b24db8b0a9556@mail.gmail.com>
References: <8ec76080802191322t2417ea48y1537011f1031dff8@mail.gmail.com>
	 <alpine.LSU.1.00.0802192220440.7826@racer.site>
	 <8ec76080802191517k5f070d45l497063d93e080272@mail.gmail.com>
	 <20080219234422.GA9987@coredump.intra.peff.net>
	 <20080219234945.GB9987@coredump.intra.peff.net>
	 <20080219235250.GA12979@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 01:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRcYl-0002WY-E6
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 01:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbYBTALF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 19:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbYBTALE
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 19:11:04 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:14354 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbYBTALB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 19:11:01 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1768707rvb.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 16:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=THbS7/Z2s5DACRvjP7AzwlxCVdW+9SmP8b9xh3ZZihU=;
        b=Mnm1aGsWHBw7hra8AZcklcPjtCuIiy/B9ZEH19dZkAd8FMyq9KJhkERO4+1tWqxjgosnEAZX260qlVVRuOt42YMf4KpN5JTc4n54NFE6kijaQETFSN2tvyw4td9peFSTYhY5lCaVJschfVMfaboQmL6iQZwDDVARmhPYFGzKx3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L4++gia+KNrxYlqXFeAOE6oFlkLY8vlN0nLHF7ViRlpzZJJNECcgJyKqMHlH2FHpiFa7FlJiduG7UXr+c71d1+7WZstr7BzZYlfZzBbiafdmv+YEr/kqp6wQuaHM/gOKEVKvgFkRYPEF3HGLzoRrEtMl1USqBjBPupfmMGXVQI8=
Received: by 10.140.126.14 with SMTP id y14mr5186089rvc.96.1203466261455;
        Tue, 19 Feb 2008 16:11:01 -0800 (PST)
Received: by 10.141.195.19 with HTTP; Tue, 19 Feb 2008 16:11:01 -0800 (PST)
In-Reply-To: <20080219235250.GA12979@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74482>

Thanks for the quick patch, Jeff.

That certainly fixes t1300-repo-config.sh.

I must be seeing the same failures as you ( in t3404-rebase-interactive.sh ).

Thanks for your help, everyone.

-Whit


On Feb 19, 2008 6:52 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 19, 2008 at 06:49:45PM -0500, Jeff King wrote:
>
> > Otherwise, test t1300:58 fails when trying to match the text. It's
> > just a typo in my previous patch.
>
> Bah, and there are even more errors at the end of the test (though I am
> not sure if they are related to the fix, or were there already). I don't
> have time to look at this anymore right now, but I will try to run the
> full test suite on Solaris later tonight.
>
> -Peff
>
