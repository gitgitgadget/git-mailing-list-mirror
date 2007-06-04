From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [ANNOUNCE] qgit new "smart browsing" feature
Date: Mon, 4 Jun 2007 13:09:50 +0100
Message-ID: <200706041309.54279.andyparkins@gmail.com>
References: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com> <200706040921.55861.andyparkins@gmail.com> <e5bfff550706040420j22852e4btc41a88c79bffc49f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 14:10:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvBOB-0006Sm-Pp
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 14:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbXFDMKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 08:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbXFDMKA
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 08:10:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:1910 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbXFDMJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 08:09:59 -0400
Received: by ug-out-1314.google.com with SMTP id j3so730712ugf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 05:09:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SOKnNXbRvT57volr2suwuADJaPDRQnXWfrcmVlNYgX2abhtP4rBMTIjyeu4CtGAb9ejfAMGD3s5n6EEGJ1PU17PghIBEBW/Payd2StB4HuYwQF/aC8xjE+FcoQwwWPpXXANHvDFa1M6qo8YzcmaK7UUpTm5hc8Zc2sUlXCKaQRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tiQvjgHzdYvKaWMjrfEF8QpKL8sTRgHcaVMeTbE2vX58TS+cZB9IKGY8qxz0qINbmBaRV/G8GvC2oLgy85R7CNM0LNKtzSf9gTn3haJwG+cUnj0dXszvVcxgZAnfTv5qIM9ijE5EKnULAPjUZFJayu4JoyAPeK2mBmLvN0N9APw=
Received: by 10.67.115.19 with SMTP id s19mr3074204ugm.1180958998392;
        Mon, 04 Jun 2007 05:09:58 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y34sm654338iky.2007.06.04.05.09.57;
        Mon, 04 Jun 2007 05:09:57 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706040420j22852e4btc41a88c79bffc49f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49096>

On Monday 2007 June 04, Marco Costalba wrote:

> The tabbed widget is here to stay. I do not plan to remove it. But the
> tabbed widget is also slower then a well behaved scroll swicth or link
> clicking.

Ah - I've not explained myself clearly.  What I mean is _another_ tab widget, 
instead of the scroll-to-switch.  It can't possibly be slower, as it's the 
same amount of work for Qt...  So it would look like this (excuse rubbish 
ASCII art):

 +-----------------------------+
 |                             |
 | <rev list here>             |
 |                             |
 |                             |
 +-----------------------------+
 | Log | Patch |               |
 +-----|       |---------------+
 | <diff goes here>            |
 |                             |
 +-----------------------------| 

At the moment, you have a label in the top left of the text window that is 
mouse-clicked to change mode; I'm suggesting replacing that with a tab widget 
as above where you mouse click to change mode.  It's no more operations, 
doesn't include a strange floating label and is a more standard and 
recognisable user interface.

If you still wanted up and down buttons, they could very easily go to the far 
right of the log|patch tabs, similar to the "close" button on the top tabs.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
