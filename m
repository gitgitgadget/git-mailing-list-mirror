From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Something is broken in repack
Date: Mon, 10 Dec 2007 15:16:50 -0500
Message-ID: <118833cc0712101216x989e720pe190c60025409bd2@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <alpine.LFD.0.99999.0712101434560.555@xanadu.home>
	 <9e4733910712101205q218152a2td14a8931e63d2610@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 21:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1p3y-0007XP-Q1
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 21:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbXLJUQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 15:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbXLJUQx
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 15:16:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:49971 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbXLJUQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 15:16:52 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1088227nfb
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 12:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lV4zOFdw7pECYxlHJe33UCYzxwedEp414vdC2J/DzXQ=;
        b=uNffjkV08DAqVNpY+on3IXRteDBJBP+sQF4/gmu8jN+5n9iZwk/01HKKIwkGeBX8aBulA57xrghuEzAngkzaIQr6kWXCeYtH0AEJKDYv/99NG3MsaTV5l8+FXp2FdlTciCFubhVDfYmBiKEuWlWYOhCi0GCASCCOry7MdgwT4S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fFNyifmq/S+J9QzK7BX32RTJylAIAVLk98NMO9IIrU7xk84+hJ2rowkiKME9epDF42ltkRwP4XdZRM92tQtKiDvMfN6p3iLJpDcE42P287dgPnubX1WQxZ0gefNXJ9oHB3afGwgeLlDJxab4kg1o+YRHsAugj+KH8NEQVdNDzEI=
Received: by 10.86.91.12 with SMTP id o12mr5887236fgb.1197317810422;
        Mon, 10 Dec 2007 12:16:50 -0800 (PST)
Received: by 10.86.82.19 with HTTP; Mon, 10 Dec 2007 12:16:50 -0800 (PST)
In-Reply-To: <9e4733910712101205q218152a2td14a8931e63d2610@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67752>

> Here's another observation, the gcc objects are larger. Kernel has
> 650K objects in 190MB, gcc has 870K objects in 330MB. Average gcc
> object is 30% larger. How should the average kernel developer
> interpret this?

Could this be explained by the ChangeLog file?  It's large; it has tons of
revisions; it is a prime candidate for delta compression.

Morten
