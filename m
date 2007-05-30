From: "James Bowes" <jbowes@dangerouslyinc.com>
Subject: Re: [PATCH] rev-parse: Identify short sha1 sums correctly.
Date: Tue, 29 May 2007 21:09:50 -0400
Message-ID: <3f80363f0705291809y23b1bf06j4076ecc09fe8c0d5@mail.gmail.com>
References: <1180481391179-git-send-email-jbowes@dangerouslyinc.com>
	 <7vtztv3zf1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 03:10:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtChQ-0008PL-3l
	for gcvg-git@gmane.org; Wed, 30 May 2007 03:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbXE3BJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 21:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbXE3BJ5
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 21:09:57 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:49507 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbXE3BJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 21:09:56 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1384815nzf
        for <git@vger.kernel.org>; Tue, 29 May 2007 18:09:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JnOL2P66WPJ+HnwtqE/Z4xeZJ8iwx6/CLbvkPbPS6ykIeS8BSKLIT2KA3RDBt2AR9IdIq6fGVFuxbSmQOrqYqDHuSKmBcda4VfLtYPtYAfr/WC2n7yWtLzUXu9KAOB3f2QFDtan19ZCyI0HlDhAgKRoXFVW6k7cuLLXcMxpX2Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KOyjg8HBoPfTJRoAHK2ADc0z7mWJHyLQOwKImnw4gIcdLWMrIvKhKlPaegZuGrnkUIV4fxIZIU/qB6fGI4jmJyNpk3XYoFl4Lxmg8SeDiYmhOBKxmsqPa4mMjdMJ2B9UEIlO6BhynAR5RJPTM6WCRX0+jQRLJ1hpOB9u0Rdfbgc=
Received: by 10.114.60.19 with SMTP id i19mr3653518waa.1180487395322;
        Tue, 29 May 2007 18:09:55 -0700 (PDT)
Received: by 10.114.194.4 with HTTP; Tue, 29 May 2007 18:09:50 -0700 (PDT)
In-Reply-To: <7vtztv3zf1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: 5f4666caf71ab662
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48718>

On 5/29/07, Junio C Hamano <junkio@cox.net> wrote:
> Thanks, James.

Glad to help when I can.

> This seems to fix the bug I mentioned about 'next' in the last
> "What's cooking" message.  Also I have been seeing a segfault
> from rev-parse in t5500 (rev-parse --short hits the same issue,
> because the bug caused object name not to be abreviated) but
> that is also fixed with this patch.
>
> Will apply, instead of reverting the "lazy index loading".
>
>
>

-James
