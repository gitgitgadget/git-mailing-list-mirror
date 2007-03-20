From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 09:26:00 +0000
Message-ID: <200703200926.05176.andyparkins@gmail.com>
References: <1174361424.3143.42.camel@dv> <200703200843.51473.andyparkins@gmail.com> <7vbqio7100.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pavel Roskin <proski@gnu.org>,
	Alexander Litvinov <litvinov2004@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 10:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTabi-0004qS-IN
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 10:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277AbXCTJ0N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 05:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933410AbXCTJ0M
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 05:26:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:4527 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933277AbXCTJ0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 05:26:11 -0400
Received: by nf-out-0910.google.com with SMTP id o25so268562nfa
        for <git@vger.kernel.org>; Tue, 20 Mar 2007 02:26:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oeex1z5kxtSqW1fHRgK/g4WWT1LPrn4JSZf5zTE21ZTq3YXp2c1KmJPtkku+kWzQ/AiDBkO8Cgh8fR13WA2Bosx18FFCJdjhyrZSz3ZxzeQYX4VOB/e82AVaFmy6i5Qr1erAHsU6v+4xZFNsJ51aXE5bTH2MfI+Y/Xmbp4BhEO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cRICpplq9GyHyDZz2IimPSEDnXbfaYpNrylGFyeylz1h18qV4yEEjMQ5dB6zVvLbgeCXkqidz2rUjei8WKrpnsyg/DmLSPSbGmLpx2rXJNHGtY5gA/m8q0Tt6yya8UIFwTgGZi3bzkxExBWdSX1SingM2U7S1y+ykBk6QzLnfGU=
Received: by 10.78.171.13 with SMTP id t13mr2935208hue.1174382769068;
        Tue, 20 Mar 2007 02:26:09 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c28sm1273899nfb.2007.03.20.02.26.07;
        Tue, 20 Mar 2007 02:26:08 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7vbqio7100.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42732>

On Tuesday 2007 March 20 08:49, Junio C Hamano wrote:

> >> noticed, because almost nobody uses it.
> >
> > I'm not sure that's going to be true for long - the 1.5.0 release notes
> > recommended setting it (assuming you didn't need backward compatibility)
> > - which is exactly what I (and I'm sure others) did.
>
> Well, it is fixed in 'master' to be in -rc2, and that validation
> does not exist in 'maint', so no harm is done.

It wasn't the presence of the bug I was highlighting - it was the idea that 
nobody uses that option.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
