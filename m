From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] checkout: allow full refnames for local branches
Date: Wed, 9 May 2007 11:07:32 +0200
Message-ID: <8c5c35580705090207y2979aaa5u7ce9de5fa1dfe658@mail.gmail.com>
References: <11787000032830-git-send-email-hjemli@gmail.com>
	 <7v7iriwfeu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 11:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hli95-0000Ur-54
	for gcvg-git@gmane.org; Wed, 09 May 2007 11:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbXEIJHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 05:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbXEIJHe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 05:07:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:51676 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbXEIJHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 05:07:33 -0400
Received: by wr-out-0506.google.com with SMTP id 76so138043wra
        for <git@vger.kernel.org>; Wed, 09 May 2007 02:07:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QtLBtmolIJJnSE5n3Gub1t5/mpLKR9rHnrRFljGMGsf56zsRZ9yrB82iGD8x4gX4t6rAPR6xbtQVRNQiYnLl1mF41uTOA+4MHnDuxb/pSYESOssDVVy78LV7pi2RJh0DKmMarKNiFU+5Z81hotH3x/x74yWwx2Vg+4I1/MM/BWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D8/ZW9Ao0Z70zE/5J8tdoekOmvtnQmvMz8kJ6GxDkMA1cbqui1hHFLgvJYnVjE6Ieajs7egckabTxMhzLld3DbhWOOL443BqNyoOEJnjA7bHGz+BLH/X4yboPcI4zZSxpbYrtogVa12a47DHJNZUYPvJ4VpLrpXqRjTLS9B8X9s=
Received: by 10.114.25.3 with SMTP id 3mr126201way.1178701652414;
        Wed, 09 May 2007 02:07:32 -0700 (PDT)
Received: by 10.114.234.19 with HTTP; Wed, 9 May 2007 02:07:32 -0700 (PDT)
In-Reply-To: <7v7iriwfeu.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46686>

On 5/9/07, Junio C Hamano <junkio@cox.net> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > This teaches git-checkout to strip the prefix 'refs/heads/' from the
> > supplied <branch> argument
>
> Why is this necessary, may I ask?
>

I'm playing around with a gui frontend, and there I use
git-for-each-ref to obtain possible arguments for git-checkout. That's
how I discovered the 'problem', and solved it by stripping
'refs/heads/' in my frontend. But then I thought it would be nice if
'git-checkout' did the stripping on my behalf, since this might bite
others too :)

-- 
larsh
