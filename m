From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 12/19] 1/2: Add Python support library for CVS remote 
	helper
Date: Fri, 30 Oct 2009 05:27:27 -0700
Message-ID: <fabb9a1e0910300527w7033af71g8e65bcc69fde382b@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-13-git-send-email-srabbelier@gmail.com> 
	<200910300933.35567.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	David Aguilar <davvid@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 13:27:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3qa9-0007Xm-A0
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 13:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367AbZJ3M1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 08:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbZJ3M1n
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 08:27:43 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:40182 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbZJ3M1n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 08:27:43 -0400
Received: by ewy28 with SMTP id 28so2930146ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=PDPe8Us0ur7cykXi4ghTXqrVLn4HwGrdUiRL5+m+YUg=;
        b=v3dIDYfQ5i8ChL+XdmfjmHMTkVN+x5X6T2NH8QiUcrEOC3Yf1U3M2D4aPv/VPViOIX
         0khETN7nWru25JTS3ZYhsU29iTmDM5awWvTHaxeVYe0jkmR8xRCkIVtKQDpkmzbPYaUJ
         SMmJ8Dasksumiiik8WDva8LT1iVlbGxkKF53A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WM08t870T7My8wzDC/ZZVpECqrTJ4m3+6CBR8+8UEOf40Aqa2Zedwn474YdMtz/Ire
         4MMIpbmR1c0lLEONsfAhuK6RcJkU+oSgJr23QNWjG4mixPMLrV5Re3F+p55qpFvhrl9G
         3uPiBbQjrhlxCVDACsDZ5UBhMofhEe44bOKjc=
Received: by 10.216.87.134 with SMTP id y6mr572977wee.20.1256905667112; Fri, 
	30 Oct 2009 05:27:47 -0700 (PDT)
In-Reply-To: <200910300933.35567.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131700>

Heya,

On Fri, Oct 30, 2009 at 01:33, Johan Herland <johan@herland.net> wrote:
> Why? Or: why that one, and not the others? Also, you might want to mention
> your contribution in the commit message itself.

What others? And I thought my contributions were so minor it doesn't
really matter that much :).
> It seems the two functions you add (notify() and warn()) have a different
> indentation than the existing code (which uses 4 spaces). Please fix.

That's weird, will fix.

-- 
Cheers,

Sverre Rabbelier
