From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] Second parent for reverts
Date: Fri, 11 May 2007 10:33:15 +1200
Message-ID: <46a038f90705101533m12957692lea94cce2a416f788@mail.gmail.com>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
	 <7v7irhslx1.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.98.0705091513050.4062@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705100927340.3986@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 11 00:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmHCK-0001gJ-VA
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbXEJWdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758206AbXEJWdQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:33:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:35088 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbXEJWdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:33:16 -0400
Received: by wx-out-0506.google.com with SMTP id h31so696060wxd
        for <git@vger.kernel.org>; Thu, 10 May 2007 15:33:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QhZ+ccM7mLgGE61rxZWR7FIGBMZmob2/TgwQhE5vrpidS6AdgpjkYk+sslKmzc1r9ip/LmRJO0W2yXxCg/qAEO4lWlsahnwQap1saWoDSNdwuUdoDf0IKCiBfJPCgaKp13Aq4d1GvhJOGRP6fgMKJqB3WEAQrJqD9cXHMlk/+eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tdDZaCsA7Sprc97YVDy+mRW4HJCj+9SGrwu3kBL9Yy3FgPKfo9/H3NnHKDAPfxTKCZzAj/CtWoEkV6F0U4PCj2CEkBc8Br+aOagMPIrlmszHuNkvn7cXu3xpgX1es3OB6EDLm7zV+HcImS+z5qyNkzdbyuWTofJbktBuH/RJ+QY=
Received: by 10.90.90.3 with SMTP id n3mr2409606agb.1178836395107;
        Thu, 10 May 2007 15:33:15 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Thu, 10 May 2007 15:33:15 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0705100927340.3986@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46915>

On 5/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Designing your SCM around the notion
> that everybody will use a totally integrated system is a mistake! It's a
> *huge* mistake.

A huge mistake _everyone else_ makes. git is the only scm that works
transparently with everything else -- witness the myriad of
importers/exporters/gateways we have, all depending on the fact that
git tracks content, and does not get distracted with fancy metadata.

cheers



martin
