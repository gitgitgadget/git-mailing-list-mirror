From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 10:21:28 +0100
Message-ID: <200705181021.30062.andyparkins@gmail.com>
References: <200705170539.11402.andyparkins@gmail.com> <200705180857.18182.andyparkins@gmail.com> <200705181043.09203.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 11:22:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoyfD-0002qJ-8I
	for gcvg-git@gmane.org; Fri, 18 May 2007 11:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbXERJWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 05:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755861AbXERJWE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 05:22:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:34960 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbXERJWB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 05:22:01 -0400
Received: by ug-out-1314.google.com with SMTP id 44so504436uga
        for <git@vger.kernel.org>; Fri, 18 May 2007 02:22:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CGRz4QBw0alSY1V6PedU8PF3wFZyGXPjo3OSH+gQriO9sZNLuhiHeUMeUXBNotwh5fQLweM6av/nVMD/dN2Ux4BTBnzSGe2j9ln3SxbFjnQXHSUzrbVg5gzwogIj2mifajdie8SRKasFQ8Xaktjbqq3j0vQxmaCqZHKsgoLIC7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dLiULFwcZwcMJ8HIvfd0IPehjAPAadyAdf6WeBiykq7AT+zSXGwLc0RsdFIxyeCIzu+8DaSyW/E2mEo3w9uXxz8NziD/gZBMiNVw9F5get4o7JftdVO49rLa3PKfVHsl2W+IC4oeH41GGg6i9WgJLLHuaf6Uf/PiRYMwBK68KPE=
Received: by 10.82.180.17 with SMTP id c17mr2379112buf.1179480119562;
        Fri, 18 May 2007 02:21:59 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y37sm2744594iky.2007.05.18.02.21.44;
        Fri, 18 May 2007 02:21:53 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200705181043.09203.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47585>

On Friday 2007 May 18, Josef Weidendorfer wrote:

> It all depends on how we construct the default URL out of the subproject
> identifier. Options:
> (1) do not try to construct a default URL at all. Error out without a
> config (2) use a configurable rewriting scheme like s/(.*)/git://host/\1/
> (3) automatically detect a senseful rewriting scheme
>
> Let's start with (1). We can invent convenient default schemes later on.

All good; except let's start with 

 (1) if no config, try using the key itself - error out if that fails

Then everybody is happy - if you want to use your system where the key is not 
a URL, then don't - you'll get the error you want.  If the user chose to use 
a URL then magic will happen.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
