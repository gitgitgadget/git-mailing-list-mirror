From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: gitweb not friendly to firefox?
Date: Thu, 1 Mar 2007 11:34:20 +0000
Message-ID: <200703011134.22451.andyparkins@gmail.com>
References: <989B956029373F45A0B8AF02970818902DA70E@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Li Yang-r58472" <LeoLi@freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 12:34:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMjYj-0004nG-Uo
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 12:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbXCALei (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 06:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbXCALeh
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 06:34:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:63772 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965024AbXCALeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 06:34:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so861693nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 03:34:29 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GoE9u1bL0tGu4v93GtRt1mx0s0qyrQ8mwUn1WUnVq+MVkt67XHtMRs52lAuVviDZgFO5eaYcgkZlFzzuYlSQthHYjZvWxzLfx2Uxi71ZsFh7/IUuHI5MwHfdBFamFD2H67KDkD1Zd/B+vuomkdIX4eR/nRM6NtBOdGGeqXNTbvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HaccBBtY19Q4croTlrV5+eXh7JsRLjHzsyRs3yOOLWXpCmASZcf9M2wIlunse0DKCu5uxb1eR5rUwm7xeacVnwPitQ9VQUtvVooNPskwRSud45mT5RIJ2kenABytsdM01k5LTFXfSAnnF+FLI9w2/GofkOZQhvSvQEtet9Vg328=
Received: by 10.49.41.18 with SMTP id t18mr5468511nfj.1172748869790;
        Thu, 01 Mar 2007 03:34:29 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id p43sm8682121nfa.2007.03.01.03.34.25;
        Thu, 01 Mar 2007 03:34:25 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <989B956029373F45A0B8AF02970818902DA70E@zch01exm26.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41085>

On Thursday 2007 March 01 10:57, Li Yang-r58472 wrote:

> XML Parsing Error: not well-formed
> Location:
> http://10.193.20.133/gitweb/?p=linux-2.6.git;a=commit;h=c0051ec763eca4c1
> adfcb8d461243d0a7b444bb7
> Line Number 43, Column 38:<tr><td>author</td><td>Li Yang
> <LeoLi@freescale.com></td></tr>
> -------------------------------------^
>
>
> Would it be anything wrong with my gitweb configuration or apache setup?

When I've had errors like that in the past it has been because:
 a) Firefox installation corrupt; try running with a new profile 
    (firefox -ProfileManager)
 b) Firefox has been upgraded but you haven't restarted it since.
 c) An extension is incompatible with your current version, but doesn't know 
    it


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
