From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like write failures
Date: Mon, 4 Feb 2008 17:54:00 +0000
Message-ID: <e1dab3980802040954y41b0c7c7o5307101bddd1cc1b@mail.gmail.com>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
	 <alpine.LSU.1.00.0802041512140.7372@racer.site>
	 <e1dab3980802040724l5ef12528y69f1d572b7ac8d54@mail.gmail.com>
	 <alpine.LSU.1.00.0802041714560.7372@racer.site>
	 <e1dab3980802040939u1329ab6xa730f5ecc52c809a@mail.gmail.com>
	 <alpine.LFD.1.00.0802041245170.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"gi mailing list" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM5Wl-0008VE-Am
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbYBDRyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbYBDRyE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:54:04 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:46596 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYBDRyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 12:54:01 -0500
Received: by rn-out-0910.google.com with SMTP id i24so2049907rng.19
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lw0v0OvZYHQU4OJToF6Lmt+WNVmquMa9nbGkxUrauAE=;
        b=aYx7j97PK8zsMnn6U15DivmXUY9y6OoQKgrItxUwwoxVWk0dZvuKk08yXQqmgbDTq4ectuvBPs1x0gGjPwwCh8oGfoUL7d9cX/sVl8dH5LiZxrw0MK7SGmIJpyWeKyJvprmPwawbAQ7DgzNnGa1XFX5q6MMCEEfvP24B7W/5kTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NMGXSrsq3tEgZzCP6vVNaeEV9L5pL5VMDj7rCZ26cs1RHfCV0bKI9YY/9LdMxCTAo10WWe+7O0S4+8D4hJ5BVtkI8Crh91dnulMeXa/cix3LCMssS9TmZ6VdwrK37O3lY+VwLvOdRR/sX1MKUKYAoz67OLZU5dzzGAG+l7dVa60=
Received: by 10.150.189.9 with SMTP id m9mr3077136ybf.73.1202147640610;
        Mon, 04 Feb 2008 09:54:00 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Mon, 4 Feb 2008 09:54:00 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802041245170.2732@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72536>

On Feb 4, 2008 5:47 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 4 Feb 2008, David Tweed wrote:
> If they're prunning old objects already, they can prune old temporary
> pack files assuming the same level of (non) risk.

Thanks. I'll leave it a day or so, then post a final patch without the
modification time check.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
