From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Allow the ident attribute to include a length specifier
Date: Mon, 14 May 2007 14:29:54 +0100
Message-ID: <200705141429.58412.andyparkins@gmail.com>
References: <200705141405.29550.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 15:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnadK-0004O6-GO
	for gcvg-git@gmane.org; Mon, 14 May 2007 15:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbXENNaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 09:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754439AbXENNaG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 09:30:06 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:11184 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbXENNaD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 09:30:03 -0400
Received: by mu-out-0910.google.com with SMTP id w1so1121530mue
        for <git@vger.kernel.org>; Mon, 14 May 2007 06:30:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Q2CK6wCl/rKke7R5tWehaQpgW+HUtw8Y4IIuhjIuvRHr9jc4B5TonqbCYDP5jfRw4XlPKjyGUuxZzd1/ghWwrJ7JJ6vaFDepqp/9ULsc31VjUtJB698m51bsN7gPZyiUVpk2GPIuVP5KrShXVYMebiX3xoMHivFO2PGz98xr5dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TB15+N+Pyw6SQ325bMB4w4QxnlK9AS9w+JOps5LoEuv6Wqly5gxuZg6NolEV0VUsR4OvadN/m98LLXYazU/Uyst3DUOqkGfdnB5DqGfj3Ia2MvaymZAzwyLGqPZhtGgjHW0MARrgMwJbdCy05qevcQ7aJBaanCejnyCrZznxV5g=
Received: by 10.82.162.14 with SMTP id k14mr1703509bue.1179149401956;
        Mon, 14 May 2007 06:30:01 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c25sm15575595ika.2007.05.14.06.30.00;
        Mon, 14 May 2007 06:30:00 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200705141405.29550.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47239>

On Monday 2007 May 14, Andy Parkins wrote:
> When the ident attribute is found for a path, then git replaces $ident$
> with:
>
>   $ident: df2a1fd3ebce86876721bd7e12ce02ac89c885db $

Is it too late to request a change to this?  Make the field $Id$.  $Id$ is 
present already in SVN and CVS; it would mean that people converting their 
existing repositories won't have to make any changes to the source files 
should they want to make use of the ident attribute.

Given that it's a feature that's meant to calm those very people, it seems 
obtuse to make them edit every file just to make use of it.

I think that bzr uses $Id$; Mercurial has examples for $Id$; monotone has $Id$ 
on its wishlist.  I can't think of a good reason not to stick with the 
de-facto standard and call ours $Id$ instead of $ident$.

(I accept that this doesn't help those using $Author$, $Rev$, etc, but it's 
better than nothing)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
