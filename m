From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: type_size_sort
Date: Tue, 6 Dec 2005 22:01:30 -0500
Message-ID: <118833cc0512061901p565de8a8x5543c95903cd6c2a@mail.gmail.com>
References: <118833cc0512061319l3726fdfbs8286e7b3f5ab0713@mail.gmail.com>
	 <439604DF.5010603@op5.se>
	 <118833cc0512061651y57ddcdc7pd26996b40c08d225@mail.gmail.com>
	 <7vmzjdy721.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 04:02:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjpYu-0008OZ-Fe
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 04:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVLGDBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 22:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVLGDBb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 22:01:31 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:35658 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750816AbVLGDBb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 22:01:31 -0500
Received: by zproxy.gmail.com with SMTP id 34so235577nzf
        for <git@vger.kernel.org>; Tue, 06 Dec 2005 19:01:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pAHw1Nzhc60GRHLl8WcOg9L2cpV/sxPyl9rUcvdS7pKLrpyxh/XzY4Wzr2i8RBqQANv4BugGgb7FFBIX7nHrmEJaSVWrb2+Hg/8PXWPiLGhz7iN+TuLPdEWJbG+dTofzuJykfHuVEOtza0EZZmFLT/K1j40vg10HTxZITq8GVRM=
Received: by 10.65.241.17 with SMTP id t17mr1320626qbr;
        Tue, 06 Dec 2005 19:01:30 -0800 (PST)
Received: by 10.65.151.1 with HTTP; Tue, 6 Dec 2005 19:01:30 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzjdy721.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13317>

> Notice?  The comparison of two pointers you originally pointed
> out is not about the location in list[].  They are values stored
> there.

Ah, right you are.

Mildly relatedly, notice that a<b can be valid when a-b<0 is
not.  ptrdiff_t is not required to be big enough to hold the difference!
(A highly dubious part of the C standard.)

M.
