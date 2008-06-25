From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 16:37:39 -0400
Message-ID: <e06498070806251337v53260405t537e8363f797e91@mail.gmail.com>
References: <20080624222105.GA24549@dervierte> <48620C1A.6000509@panasas.com>
	 <alpine.DEB.1.00.0806251109380.9925@racer>
	 <486220CE.3070103@viscovery.net>
	 <alpine.DEB.1.00.0806251334060.9925@racer>
	 <20080625135100.GF20361@mit.edu>
	 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
	 <20080625195003.GB15077@mit.edu>
	 <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
	 <7vlk0tz33n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Theodore Tso" <tytso@mit.edu>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Boaz Harrosh" <bharrosh@panasas.com>, git@vger.kernel.org,
	jeske@google.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:38:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBblG-0005Rz-TG
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbYFYUhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbYFYUhn
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:37:43 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:25811 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbYFYUhm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:37:42 -0400
Received: by an-out-0708.google.com with SMTP id d40so851348and.103
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=n1+J1U+Fb3He9+6mvsT3+ngpWcprOOhEVP7BcJWEBLo=;
        b=GN0jt6efQUNYqZKE8OpnFgezKZWwhlN8tIvMzEZ1tFD3ZJBjhUWTstiO59aOvngRCG
         J2ESyUoPnmNP/XgYvNrRnlRhEO4JU3HLv1mAFxVV7yx2IuZccNQivocFHJGyQIwHzQVn
         FF+EIjf+BbABIDV7jLrX0LFngu3OcJUvr+i80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZdBx9lQyEgCswvJTmacq9RYyrBrMPAbLt6XJVGvlWWZtjBgkfgKz0EBaiZiCMzZb1o
         D7KAtlOdjI0tVyUGmXZnxsPYcWui//SB3pR1N/gxYfr1GepbHVwc0zdVLy+pTtpIm4rd
         Rpz56weSwpgceGPDcHO8XNWy+58PYbbzb2U04=
Received: by 10.100.33.13 with SMTP id g13mr19141268ang.96.1214426259658;
        Wed, 25 Jun 2008 13:37:39 -0700 (PDT)
Received: by 10.100.92.6 with HTTP; Wed, 25 Jun 2008 13:37:39 -0700 (PDT)
In-Reply-To: <7vlk0tz33n.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86341>

On Wed, Jun 25, 2008 at 4:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  * You say "git checkout branch" when you want to "check out that branch";
>
>  * You say "git checkout -- file" when you want to "check out the file
>   from the index";
>
>  * You say "git checkout v1.5 -- file" when you want to "check out the
>   file out of that revision".
>
> It's not that hard.

No, it's not "that hard."  But are you really claiming that it's
beyond improvement?
-- 
-Steven Walter <stevenrwalter@gmail.com>
