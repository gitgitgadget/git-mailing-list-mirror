From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Mon, 16 Jul 2007 19:55:26 +0200
Message-ID: <e5bfff550707161055i2f12b858n7be155765fb664@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707160504p52770227l9af66aa750d9efd6@mail.gmail.com>
	 <81b0412b0707160531mad35ed4x4c89b2d6c6f5f707@mail.gmail.com>
	 <7v4pk444rd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUnD-0008OB-00
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbXGPRz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbXGPRz2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:55:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:14004 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbXGPRz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 13:55:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1666477wah
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 10:55:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lraxMUmcZCVkRlJKPM8pCTgOSOGpwmY8V4cMNZ3N9qYi9qbpdY12ujRgas/RjUdvRD2hiPqpsLBcUfANcxAg/wYOvpwKdu1DCxpmiynNqWj5DtZQSHmfrHnnBgPPUnxcWFklNhSyK5r/8aZe5w7veGwgowaQDSqvWaL9fbIvvj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qZlrnKZ6nlIru8mKPf0nGem1dWj4VI/e0dHmAcKraezV4db+Gb3Kc1ZDoq2AFAWJ4y0uMjkOzFX8MMeZhT7pEn9Z/NjF21aLh1VK6EH3axJc+bX8qbn2YzFkPZOzPjedD2XOAK5lnlot7+hDyMDXwBv9i/XiRluDKBNPRiRBWbY=
Received: by 10.115.58.1 with SMTP id l1mr4341633wak.1184608526918;
        Mon, 16 Jul 2007 10:55:26 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Mon, 16 Jul 2007 10:55:26 -0700 (PDT)
In-Reply-To: <7v4pk444rd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52701>

On 7/16/07, Junio C Hamano <gitster@pobox.com> wrote:
>
> I'd say making --show-message-size option incompatible with diff output
> would be good enough futureproofing for now.
>
Oooops, I didn't see your post.

I agree 100%, please tell me if doc it's clear enough or it would be
better to clarify that "message log" it means only message and no diff
content.

Marco
