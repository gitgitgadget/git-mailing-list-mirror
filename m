From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] check-ignore: correct documentation about output
Date: Fri, 20 Nov 2015 21:29:41 +0100
Message-ID: <1448051381.6899.2.camel@kaarsemaker.net>
References: <20151108201036.GA28434@spirit>
	 <20151120113129.GE11198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 21:29:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzsJZ-0002zV-Hi
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 21:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760211AbbKTU3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 15:29:45 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38654 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760137AbbKTU3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 15:29:44 -0500
Received: by wmec201 with SMTP id c201so35689742wme.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 12:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=rNez3M2lAp46O+L+lggHrqybD6Yb1uBMeXTWHMvPf2w=;
        b=e/IZDvLJosS5bBJp8MtfsJVJMJ+o24HVf/kuCcl1nWX0zytZN15cV0mX7IshEfzbzF
         RpWhGuwdI2aEzOM7mr228Eb89JjsrDH+o0B63XROu6icjj1j/ZARxRkMBlKq5Qk87OK+
         fjAPMyuHrpGWcjiJ5DeQ+C9NgHMQWvLVbjye6VQqyKgSQJuaLtSXoJCCuZvCijuLecTY
         Yg7LGp8DWctK712LiQGGl2ndTjHCO4HSYlaRzpDc7sm6LXG/2ScL9Nq9EjC/1YP9eAZo
         0SjVv5YZZaH4+99caiPb6+Y6k0BuX2GojrO4TJTLskYP9fVqJRUFRN/VFI5E34ZMYw1P
         j1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=rNez3M2lAp46O+L+lggHrqybD6Yb1uBMeXTWHMvPf2w=;
        b=YyomrRsrqEo7ZYDEE+dDf6Po3NkF1M8PRNzPVvndc8ds6z+Kqf1EU7WF1S7/W2boV9
         +yjg7vQmAUV+olK/G7S/VyPnTwqWMrGauUcObOb2+PkBIEFrkMBMJ/ZFIAYNOdPucBm0
         mPqc5XbYEuohmnEPKnNvd/u7WayM3bIKlT4rkcCsocY0Wo8x56TI3X6jMCYRLSYsU4h8
         WC88yR8fr9TBzBL5QICp1dcueGiYSxpgPXcoNIGx1YXkJqPNrnFkdJpdyAd+UPhcdouc
         5UAgEzrAwhWdqVmMWa+HPZDVQAMFCK6vhdn6jJbPu1zkgoPCaUnvuqgQGypG4PshcyL5
         h5EA==
X-Gm-Message-State: ALoCoQkUUVg+JhM/UsR3raYxsDPHy9qElsJSm1T6yvoHfv703mCZ+Sh6a3o49K1z/1KH9MfUiCmM
X-Received: by 10.194.92.170 with SMTP id cn10mr16615175wjb.12.1448051382474;
        Fri, 20 Nov 2015 12:29:42 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id i18sm1041723wmf.6.2015.11.20.12.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2015 12:29:42 -0800 (PST)
In-Reply-To: <20151120113129.GE11198@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281530>

[Peff, sorry for the duplicate mail. It seems I can't brain today...] 

On vr, 2015-11-20 at 06:31 -0500, Jeff King wrote:
> On Sun, Nov 08, 2015 at 09:10:39PM +0100, Dennis Kaarsemaker wrote:
> 
> > By default git check-ignore shows only the filenames that will be
> > ignored, not the pattern that causes their exclusion.
> 
> Yeah, I think the described behavior is really about the "-v" output.

Yup.

> > --- a/Documentation/git-check-ignore.txt
> > +++ b/Documentation/git-check-ignore.txt
> > @@ -16,10 +16,9 @@ DESCRIPTION
> >  -----------
> >  
> >  For each pathname given via the command-line or from a file via
> > -`--stdin`, show the pattern from .gitignore (or other input files
> > to
> > -the exclude mechanism) that decides if the pathname is excluded or
> > -included.  Later patterns within a file take precedence over
> > earlier
> > -ones.
> > +`--stdin`, check whether the file is excluded by .gitignore (or
> > other
> > +input files to the exclude mechanism) and output the path if it is
> > +excluded.
> 
> This just drops the mention of patterns entirely. Is the description 
> of "-v" sufficient to cover this (especially I am thinking of the
> last-pattern-wins behavior)?

The -v should then also describe precendence rules between files. Or
maybe just link to gitignore(5).

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
