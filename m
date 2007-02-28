From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 19:45:39 +0100
Message-ID: <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org>
	 <200702281522.14965.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>
	 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Paolo Bonzini" <bonzini@gnu.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 19:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMToN-00034a-Mz
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbXB1Spl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbXB1Spl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:45:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:45899 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264AbXB1Spk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:45:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so199708uga
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 10:45:39 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tuu76I8SoM054KHFA+LF27cgzevdmwGFB6dVudySoX//12nbnGLbbEmw3UnkBUb6CoYHk5q/2pZhFcH7momS816qVBiu0VdRzL5B8yT5z1eEz8fHIy0Ygz6YGGei1rKEsmoOJbQRCUBSb0ckR+fk+Cx5fC5uEj8FRGljMCXPxyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o7mJRnXfkZ01KwG2pQ20lB5z5l6ncuGI8nzcZIZCquVb3juWAtPBnkiSdSNFvpki44dmQk2Lbfg7zj0llfWiM5ubpjNa9p3jYW6l8K7fHJ3urBTwRCbp0oO0gdDuxXhoRGi93DeRZCycVOElhXAW6fhHaqtHrIiRL6oM8Dpsclw=
Received: by 10.78.204.7 with SMTP id b7mr76647hug.1172688339141;
        Wed, 28 Feb 2007 10:45:39 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Wed, 28 Feb 2007 10:45:39 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40988>

On 2/28/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > How about adding an option to tell checkout/branch that a tracking
> > branch is wanted (-t perhaps) - or perhaps a way to say that you don't
> > want to track the remote (depending on which is more popular)?
>
> I don't think that you should be forced to do it explicitely. If you want
> to merge in another branch, you can do that _explicitely_. So, defaulting
> to what most people want anyway is A Good Thing.
>

As is an option to disable the feature. I.e. for scripts, which create branches
blindly, without knowing they working on a remote branch.
So, please, provide an option to do what git-checkout/git-branch did before:
which is just create the branch, nothing more.
