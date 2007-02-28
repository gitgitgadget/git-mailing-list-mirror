From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Broken dependencies..
Date: Wed, 28 Feb 2007 09:00:21 +0000
Message-ID: <200702280900.22982.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0702271543080.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 10:00:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMKfq-00012u-Dt
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 10:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXB1JAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 04:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXB1JAc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 04:00:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:30433 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbXB1JAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 04:00:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so488186nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 01:00:28 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kLpagcTS3ff4WY0gEkUVclqDCK71+9BpQ8o3vc+v7viqhdk8ct4cRidDZx3llGZQ+c1wJDuzX9xB+t+z0QmeG1F0kVaRAHpylXaJ08dZgIXpeSSIOnoii4WEBejyPu2IXOJfCMgDGGXYusMX/GieOcwb2KF+gUyd+FIUG8tm4Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WQTphKqse8v+Qm1fY6N5tDpRLan1dnpeRTshB4BHH49A+1dzJ15jxdHQR9+CpcnvlHszG0tbEsTNaFaheof3LgnlTy9sD3utx4OCn7x9+XFW1tl6PV1h2l5JznOBFCYNmMiXbqIWaMA113P2oD8+gtagERvHXmsC434+0pKeO58=
Received: by 10.49.21.8 with SMTP id y8mr3178745nfi.1172653228283;
        Wed, 28 Feb 2007 01:00:28 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id q27sm5044251nfc.2007.02.28.01.00.25;
        Wed, 28 Feb 2007 01:00:26 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0702271543080.12485@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40908>

On Tuesday 2007 February 27 23:46, Linus Torvalds wrote:

> doing proper dependencies, but I'm too lazy to fix it. Any ideas on how to
> generate real dependency data so that we don't have these kinds of things
> (I bet there are other files than just fetch.c that lack the full header
> file dependencies, this one just happened to trigger now)?

Would gcc's "-MM" help?  I think qmake uses them when it's generating 
Makefiles.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
