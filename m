From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: What's in git.git (stable frozen)
Date: Sat, 5 Jan 2008 21:08:19 -0600
Message-ID: <449c10960801051908u38e87574i59ec314c3ddc775c@mail.gmail.com>
References: <20071022061115.GR14735@spearce.org>
	 <7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	 <7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	 <7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	 <7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	 <7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	 <7v63y8ble8.fsf@gitster.siamese.dyndns.org>
	 <449c10960801051321g785e45e3v8f7b129bb087e1ca@mail.gmail.com>
	 <7v4pdr7jco.fsf@gitster.siamese.dyndns.org>
	 <7vy7b364aw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Tsugikazu Shibata" <tshibata@ab.jp.nec.com>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Jeff King" <peff@peff.net>, "Dmitry Potapov" <dpotapov@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 04:08:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBLsX-0002ob-OO
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 04:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYAFDIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 22:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbYAFDIW
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 22:08:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:36962 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbYAFDIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 22:08:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6639371rvb.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 19:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Tyf/ohzVaN5tyeHleSYDwUzoVOdtTFcc3FA5uaFwugs=;
        b=MyOtebZiCu3pM6rJu7kS6fnmAr0pQ8Q7QTQhbegtzpsOtlc7i1W7TsGHI3k700szLSNFc0vgksKrxkJBQjHojb97Vjbf+Hq0l5tolpRpwZPuZbFRSeOORmXcnHF3qyLr+InKQdWwJVdr+6akEL+mxHZ2vNyNwOLd7Om4sahK3Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bOdOhkEujX7l0WxLDSn3BDERxntaP5e9Rursi0vdoochPhuQEzXr7osN/v9EpmigcCPJAebliCq46MgbAMrC20ivDENAcZKByzogo3wCLy6QcqdovyXn+Mh8oN+neZBC4IMBRlWyMUMGaIiMmNUG7LTcYOfnou6/XGUbWoFDOXs=
Received: by 10.140.187.10 with SMTP id k10mr2400697rvf.86.1199588899046;
        Sat, 05 Jan 2008 19:08:19 -0800 (PST)
Received: by 10.141.53.1 with HTTP; Sat, 5 Jan 2008 19:08:19 -0800 (PST)
In-Reply-To: <7vy7b364aw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69708>

On Jan 5, 2008 9:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> I've updated the patch a bit as I noticed I completely missed the
> >> user-manual.txt and a handful of other files that weren't named
> >> git-*.txt. The new version is attached (gzipped).
> >
> > The asciidoc.conf change I resurrected from the earlier one but
> > it appears this breaks build with asciidoc 7.1.2 for some reason
> > (I haven't looked into that myself yet, and I won't be for the
> > next 12 hours or so).
>
> Ah, I spoke too fast.  I think I need to first do a clean-up
> patch to fix "gitlink::foobar[1]" that should have been spelled
> as "gitlink:foobar[1]" in a few places, and your change is good.

It looks like I still blew it and forgot the changes in asciidoc.conf
in the second patch, sorry about that. Let me know if you need
anything more, although this patch is pretty straightforward (once I
spent 3 hours trying to figure out why it was broken in the first
place and attempting to find a more sane way around it).

-Dan
