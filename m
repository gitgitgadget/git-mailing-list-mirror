From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/2] Make 'cvs ci' lockless in git-cvsserver by using git-update-ref
Date: Wed, 28 Feb 2007 08:44:44 +0000
Message-ID: <200702280844.45949.andyparkins@gmail.com>
References: <200702210908.59579.andyparkins@gmail.com> <200702271248.59652.andyparkins@gmail.com> <7v1wkbb1yf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 09:44:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMKQf-0002vj-20
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 09:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbXB1Iov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 03:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbXB1Iov
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 03:44:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:14208 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbXB1Iou (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 03:44:50 -0500
Received: by nf-out-0910.google.com with SMTP id o25so484596nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 00:44:49 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=N5sOGJL1nApr01a8id7Tdz0RcogbFJxAW2H9vQZLSvtE0U9YMVgFuoUGXnfoRg1/ggxNYzRhTIZWHwZ26vqiWhlFFShr8CL6gJbv657NN6PaEz/nsDeuAKGr/bvA6vmGcJT1C36UxS5hYm/y8D4B5HNk2ZHKcU39Mfy0MFn48R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=W4OmEmAiptxYv3XUL87NSPWPODeCbY3oMxpBO0gq7n5bYOLiasI+BKUWef0hQrCD7YmuWrCFjC50JGZDeaNunjNz7tDwy166MwayrSJUb9fb+G3OWj/FZWocrgh2xUfq/H9OWMs/U9ucqRv5iC3tWhgNQhIxEZC6U+Xq9jSfZOI=
Received: by 10.49.90.4 with SMTP id s4mr3140653nfl.1172652289243;
        Wed, 28 Feb 2007 00:44:49 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id m16sm5008345nfc.2007.02.28.00.44.46;
        Wed, 28 Feb 2007 00:44:46 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7v1wkbb1yf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40905>

On Tuesday 2007 February 27 23:44, Junio C Hamano wrote:

> The extra one was introduced by a later patch to honor the
> update hook since I wrote the original patch you forward ported.

Apologies.  I must have applied your patch in the wrong place on my branch.  
It did seem unlikely that you would have made a mistake.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
