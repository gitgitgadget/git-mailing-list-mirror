From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: Patching bad commits
Date: Mon, 5 Jul 2010 14:07:20 +0530
Message-ID: <AANLkTilrvCyCCIlU9M1HPAdxLREvyVL0pKyNsJR2wpN7@mail.gmail.com>
References: <4c291e41.4f1ee30a.3484.fffff729@mx.google.com>
	<AANLkTimAAtO9p2rQW4pITKQehhYF6pppBUgPxoyrLOvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 10:37:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVhBC-00010j-5l
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 10:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab0GEIhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 04:37:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39831 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab0GEIhV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 04:37:21 -0400
Received: by vws5 with SMTP id 5so5780737vws.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=8/pRjcdNqV+hHLl5dKHKfiTmje+YIr8OG27AUCweWy4=;
        b=wexb4IeuYXRwcPWzXlDqdcRvadhnkWk/k0Ju5cCiOqr0O6pfmNqQGWa5jKcDsxLbCI
         s1kTCcqwGgXYCkOouNl+5Gb3lbWeADxEu2FCKNVstpSbahwIbrefHmOYk9wwpf/Kv7tP
         D/r6+Xj3p9LTvaYVtppe0i5YySVPNdA93Y0Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=i2yxY+hMZFDQ+2fZo4Udjti2QccX1omOP+1hYmNGHenF9EB9etPSKz93by3Jt+wvnH
         7WJ7MDBvHsn+heByBPVgZFS6MCXm4GxUbRHSsXn1pJ4r26eYlRtilMiiz3RpqSG8RBcM
         TShxzovIvJE/TWnx5JvihmoeE60d94iQo5hZM=
Received: by 10.220.49.212 with SMTP id w20mr1363912vcf.106.1278319040391; 
	Mon, 05 Jul 2010 01:37:20 -0700 (PDT)
Received: by 10.151.47.13 with HTTP; Mon, 5 Jul 2010 01:37:20 -0700 (PDT)
In-Reply-To: <AANLkTimAAtO9p2rQW4pITKQehhYF6pppBUgPxoyrLOvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150251>

On Tue, Jun 29, 2010 at 3:53 AM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Mon, Jun 28, 2010 at 6:03 PM, Michael Witten <mfwitten@gmail.com> wrote:
>> Sometimes bisecting is less than useful because a number of commits
>> fail to build.
>>

You could automate the process of skipping certain commits when build fails.
  make || git bisect skip
Automatically mark commits as bad when your test fails:
  ./test || git bisect bad
Otherwise 'git bisect good' is what you do.

I think you can put these together in a loop that works automatically
without much user intervention.

Hope this helps.

Cheers
Antriksh Pany
