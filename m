From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 28 Nov 2007 13:56:05 +0100
Message-ID: <200711281356.06333.jnareb@gmail.com>
References: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de> <fii9ta$b2j$1@ger.gmane.org> <Pine.LNX.4.64.0711281221090.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:56:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxMSu-00017l-H7
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 13:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbXK1M4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 07:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754167AbXK1M4N
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 07:56:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:34336 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbXK1M4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 07:56:12 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1381753nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 04:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=L8B0AFicoOOQkZlGvmKqbYt0uSaJxMBBReH1u54Xoo8=;
        b=DvBIc7XpJjjuK1rL3q5dqNbv5M1ItkB7777uEQAvzbqWnh/5rL3Q0REsAv+2R3IF799/KLNZoarZoCadQxkalpcxEyfP6zQr1yAGRSoy47R00MDK54CXVuVl0V0Jx/R75NGRbIk4Ej8jWhRH52xrpqqmeRAYT1bEXefTSOI9y0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=E2aQXMCwET249JoOG+6jGgLelPG9SHuEpHH8/sVpOCZlHLwoAqETN+TikWuAIo5Ar9bysxJC//KaZ9Kfwkgi0Ru4q761YDhsR7QXnwz4Btc9lXJa5Louv3lxXegNnj4xDrB5r5qxkoppgfFczCtn+VzqOnL/aylLQRqPZAlqL0M=
Received: by 10.86.81.8 with SMTP id e8mr4955826fgb.1196254570527;
        Wed, 28 Nov 2007 04:56:10 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.215.156])
        by mx.google.com with ESMTPS id 4sm2596441fgg.2007.11.28.04.56.08
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Nov 2007 04:56:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0711281221090.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66313>

Johannes Schindelin wrote:
> On Wed, 28 Nov 2007, Jakub Narebski wrote:
 
>> Yes, I could reencode commit messages...
> 
> Right.
> 
>> P.S. One nice use of proposed (at one time) 'note' header would be to 
>> save revision identifier from the version control system you import (CVS 
>> revision number, Subversion sequential revision number, etc.).
> 
> Why not put it into the commit message?  It is not information that git 
> uses, so it does not belong into the commit header IMO.  (IIRC I made the 
> same point already at the time 'note' was discussed.)

There are no problems if communication is only in one direction,
i.e. if it is only import to git repository. If communication is
two-directional, for example importing CVS repository into git
and using git-cvsserver, or using Subversion repository with the
help of git-svn, you would want commit messages preserved exactly.
This includes not adding information about original revision id
to commit message, and not recoding commit message to other encoding.

Just a thought...

-- 
Jakub Narebski
Poland
