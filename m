From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 7 Nov 2007 08:54:34 -0600
Message-ID: <20071107145434.GB6768@mediacenter.austin.rr.com>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com> <Pine.LNX.4.64.0711071110040.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 15:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmIU-0006Pf-5v
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 15:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759162AbXKGOyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 09:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757987AbXKGOyL
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 09:54:11 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:18979 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759158AbXKGOyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 09:54:09 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2471467wxd
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 06:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=u1NxL5slNmIaSHJ5w0mbhI0lD6RIbyzJcc81OS50Z1Q=;
        b=rOw94yAtj/8SyVdKyZ6g5GYgAFlsGVo9g1iiO3r4Jw8LFULMBUynEoPmVIpER2qg+BXNXw4ymV9jLP35ikN5L4YKLuhBccDF3g5roqA0QpHm2E7kSgMtyXt94R8qIaob4VD9tweVU82M0uN33e+hfd8NctFecTbj5NyhFhrQV2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RX60ig7a+W+aJrh2gOEIWVoX89tmOg5MzMo0viLKyClF5lGBPKEfe3XErHbr/zIhKtTqyzoQSEmCMq68RbldsQkDs9X8THHoVdAGN9uRhoWHlmHkshA7odw52NCz/iXvyLxWO+85Ey1eYgmGxQrJCuXQ1SEpi6RNBjE0e3v7gIQ=
Received: by 10.70.52.1 with SMTP id z1mr12335043wxz.1194447248153;
        Wed, 07 Nov 2007 06:54:08 -0800 (PST)
Received: from mediacenter.austin.rr.com ( [70.112.149.232])
        by mx.google.com with ESMTPS id h8sm12144456wxd.2007.11.07.06.54.06
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Nov 2007 06:54:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711071110040.4362@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63812>

On Wed, Nov 07, 2007 at 11:10:45AM +0000, Johannes Schindelin wrote:
> 
> you still have quite a number of instances where you wrap just one line 
> into curly brackets:
> 
> 	if (bla) {
> 		[just one line]
> 	}

Crap.  OK I count one instance unless you count:

	if (foo) {
		one_line();
	} else if (bar) {
		one_line();
		two_lines();
	} else {
		something_else();
	}

Now I suppose I can get rid of the curly braces here as well but I
personally find that strange and ugly.  So is there an official guideline
on if else statements?

Of course I'll fix the other one I missed and send a new patch.
