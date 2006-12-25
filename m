From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Mon, 25 Dec 2006 10:03:54 +0600
Message-ID: <200612251003.55018.litvinov2004@gmail.com>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <7vpsabwq34.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612222319230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 25 05:04:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gyh4Q-0007Gi-Qc
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 05:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbWLYEEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 23:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbWLYEEF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 23:04:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:31056 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239AbWLYEEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 23:04:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3409208uga
        for <git@vger.kernel.org>; Sun, 24 Dec 2006 20:04:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=soD+iX+fNdY2mBkK5No01ME33p8kVtRaOuoyVj2CaQsOzo7sUWIGzTs0mropHhXvIIkP1iLHTVPQ7f7lRuER7zjkxg2iWiVqW+A6tGlu17jnxmIQFLgrq7txuV2wzYRgsM7F2zsfG/pS4umG3mrrSrjdDrgNv2+HgVCUxP0shvI=
Received: by 10.67.117.18 with SMTP id u18mr3978744ugm.1167019442950;
        Sun, 24 Dec 2006 20:04:02 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id 13sm16356474ugb.2006.12.24.20.04.00;
        Sun, 24 Dec 2006 20:04:02 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.63.0612222319230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35379>

> > > To me, characters are the symbols occupying one "column" each. Bytes
> > > are the 8-bit thingies that you usually use to encode the characters.

You can check man 3 wcwidth:
wcwidth - determine columns needed for a wide character

We possible could convert utf-8 encoded string into wchar_t[] and use that 
function.
