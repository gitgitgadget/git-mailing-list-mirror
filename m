From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsimport infinite loop
Date: Sun, 10 Feb 2008 01:01:43 +1300
Message-ID: <46a038f90802090401n431659a5p1a9b457d4338695d@mail.gmail.com>
References: <200802091245.38578.peter_e@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Eisentraut" <peter_e@gmx.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 13:02:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNoPh-0001RD-5K
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 13:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbYBIMBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 07:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbYBIMBq
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 07:01:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:38290 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYBIMBp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 07:01:45 -0500
Received: by ug-out-1314.google.com with SMTP id z38so50943ugc.16
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 04:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0iY0yApj2EITLMzkGFgdvowALc6KIS5Pmz79JPOnz5o=;
        b=cUowPFePDVBp05Dzp95JzcruPewTyrgkjR2/2skfspTkMd5K7pqFFpr+43a30yLRrCzT9iWpIpTAyUxKmOjz9+zGk3MJnVcmI2r6+oZA0zNwclh9LSpdButO05TwP/+txm8P8RPU/SXeLE2SgT1zlA67zzZih/yee6jYVSWVE14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=loitsXdCXDK2vERplRV06kCSV+p5nnn1hDktiiGk4MMalJKunYcPdRmYaYVIXrO6systuWy3XoWlGxW4Eg+n/iXTcxRkco9xC/VYu1y6sWF1RM9Cl7kL018Z6OoAKnhbw9Ds+uN+0IIvu+lCTuupoq8joJ4PPr9YOgktkJX1rq4=
Received: by 10.66.255.7 with SMTP id c7mr6591665ugi.43.1202558503669;
        Sat, 09 Feb 2008 04:01:43 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Sat, 9 Feb 2008 04:01:43 -0800 (PST)
In-Reply-To: <200802091245.38578.peter_e@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73215>

On Feb 10, 2008 12:45 AM, Peter Eisentraut <peter_e@gmx.net> wrote:
> I've let this run all night and it doesn't stop.
>
> I don't want to exclude the possibility that the CVS repository has had some
> funny business done to it over the years, but surely an infinite loop
> shouldn't happen in any case.  Please advise.

Might be a bug in cvsps -- I tried an import earlier this year of the
Pg repo and had a similar problem. parsecvs did handle it, but cannot
do incrementals, which is a real shame.

cheers.


m
