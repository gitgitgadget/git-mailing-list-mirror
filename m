From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] git show <remote>: bad information: Local ref configured
 if push.default=tracking
Date: Fri, 12 Nov 2010 22:46:56 -0600
Message-ID: <20101113044656.GA7934@burratino>
References: <201011130041.oAD0fdmM017083@no.baka.org>
 <20101113010934.GA4017@burratino>
 <201011130144.oAD1iBeK022905@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Finn Arne Gangstad <finnag@pvv.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Sat Nov 13 05:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH81W-0001HD-4D
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 05:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab0KMEr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 23:47:29 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43521 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0KMEr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 23:47:28 -0500
Received: by yxn35 with SMTP id 35so404142yxn.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 20:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iCvn4doadfDJ/e7DUPB9ACHqQKA0sJyC7eDsoplbjm4=;
        b=L1pGfSX+WhA2cDrZos8YsrHB4SZ2Mhr5L6F9QVxOu9lbRxYxHFMejD+vpxQ4UWi7lc
         E72s9Vkn9nHBgqN+81d9MT9/cxZ36xWqGn9sc7+M4WgKrQQ3oHez1MEKX+xONrQhjgd4
         WWHLPgMroQ6Ngm02NAM5+8JU6183OYafwTaOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uTz8sVwmGzPQPlphdqPOm0BVVoVsHN7RxG22MjwJBP2LCohHVgMjvJlP5Jhv9DX+1S
         D6/8JeRgzR6d9a4iRIJpg2X/wAy/lNrmiHNDwPtFE8pgvJQ7Vmn78pu+Ejx7s9IWKsW8
         75DNv5XWZqgJ4NkbZZZnreJJbpatT+X5SackE=
Received: by 10.101.69.3 with SMTP id w3mr2239374ank.32.1289623647639;
        Fri, 12 Nov 2010 20:47:27 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 13sm854849anq.30.2010.11.12.20.47.24
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 20:47:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201011130144.oAD1iBeK022905@no.baka.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161383>

Seth Robertson wrote:

> I already had this turned on in my ~/.gitconfig.  However, you bring
> up a good point, the output as shown would be correct if the default
> "matching" value was used.

Yep, the get_push_ref_states() function used by "git remote show"
wasn't updated when the "[push] default" configuration item was
introduced.

>     For your test example: rather than sample output, could you

Sorry to make busy work.  Your examples still would useful as a
test script for anyone who wants to fix this.

Thanks again for the report.

Regards,
Jonathan
