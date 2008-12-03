From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH] git-svn: Make branch use correct svn-remote
Date: Wed, 3 Dec 2008 15:42:46 -0500
Message-ID: <20081203204246.GA28841@euler>
References: <1228185780-22938-1-git-send-email-deskinm@umich.edu> <20081202215157.GB9650@hand.yhbt.net> <7vbpvtj4kl.fsf@gitster.siamese.dyndns.org> <49365259.5090803@drmicha.warpmail.net> <7v1vwpdnwy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:46:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ybZ-0005aG-Di
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 21:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760643AbYLCUnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 15:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760680AbYLCUnA
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 15:43:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:47040 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760674AbYLCUm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 15:42:58 -0500
Received: by ug-out-1314.google.com with SMTP id 39so3523380ugf.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 12:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=zmNrpOmJ4t6W/tRXlJp+PGy3V4CazNlL8I6x1GEnrZk=;
        b=gXfD7c5lR2L4K0Dh3oxDohjfxZxwiw6VlrG6JFyUqhEUrEV5s7GbK+kuNNtwO2zg+H
         MfW0GEh5aV49QvxxnPvBoYX03Sk52Ca5jdqUi36NE4lpWQsKuhYq0ubbhEBro3fDTSmM
         M7rL2DuB7ZX7kDHdTnt/DPt/0T86xMjTcB+hU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=cM2pCNyOHzeau8GIFhdYklViXpjGcJ10+g458VU/5OkmsQCzVOKqlb2wE7x8NaQ7rz
         lOHPKhru2zC6+wokuQtskwEVr8vmxxS10RJKg3EQi6KbMzBtC7/JmsexE3jWwpt+NUTK
         26KdAw4dWdHQsveXDkxC5fEFH6ndlek1SsQxI=
Received: by 10.86.95.8 with SMTP id s8mr8142727fgb.79.1228336975832;
        Wed, 03 Dec 2008 12:42:55 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id 4sm6641720fge.50.2008.12.03.12.42.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 12:42:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v1vwpdnwy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102285>

On Wed, Dec 03, 2008 at 12:06:05PM -0800, Junio C Hamano wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > Patch coming. (Sorry I always forget the ccs with send-email.)
> 
> Thanks, indeed my environment has svn 1.4.2 installed and Deskin's patch
> with your patch squashed in makes everything happy again.

Ah, curse my trusting svn to work the same between versions, and not
testing on 1.4.  Thanks for the quick fix, Michael.

Deskin Miller
