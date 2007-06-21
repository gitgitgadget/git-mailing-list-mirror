From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 10:50:01 +0100
Message-ID: <200706211050.03519.andyparkins@gmail.com>
References: <20070621030622.GD8477@spearce.org> <200706210900.49702.andyparkins@gmail.com> <7vtzt1ybld.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 11:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1JJ5-0003MZ-Gz
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 11:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbXFUJuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 05:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbXFUJuN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 05:50:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32436 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbXFUJuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 05:50:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so538099ugf
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 02:50:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eqG1gkIAMbtAkjDp4OGbFt9qqUA+UmCSdrnVYen7/WmyOEcET0Ht3X+u0R7HvfjAuX2c2m6K3IC16I3h1qtH/y4x05PE9IAfW9FlG6n33W8mEAvZGCviwfQVgHxoPRSh92LqnLeTPZ/1b0bQy++eu9RkYhHApr6RCZzdMVnsx9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RFTDy0GJdt+FJ1Dok+UNFbUgTzgoomUtzpWqhKWOC1Zlzjx5IN9enDe1BXjOG6JtZlO8m9CL7sOHmtameTx3ctnMCaB5gipBlg1nrtFYYReUvg6opqQUeby9tVgE+p8Pecgx9FBxvgTDwi+VesYkokFeFbN7lpxuOB+UqJ5CvNE=
Received: by 10.66.216.14 with SMTP id o14mr1918731ugg.1182419410171;
        Thu, 21 Jun 2007 02:50:10 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm3298169ikz.2007.06.21.02.50.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2007 02:50:09 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7vtzt1ybld.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50610>

On Thursday 2007 June 21, Junio C Hamano wrote:

> It's not even an argument, nor an attempt to justify it.  It was
> just an explanation of historical fact "It did not bother".
> Please re-read the final part of the message, which you omitted
> from your quote.

I omitted it because I didn't object to that part :-)

I appreciated (as always) your practicality in that what you proposed would 
let people keep their copies.  What I was objecting to was the idea that any 
repository with duplicate files was "stupid".


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
