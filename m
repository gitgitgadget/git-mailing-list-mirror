From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Wed, 25 May 2005 18:02:22 +0200
Message-ID: <8764x7i99t.fsf@deneb.enyo.de>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org>
	<7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 18:02:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DayK4-0007oJ-5a
	for gcvg-git@gmane.org; Wed, 25 May 2005 18:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVEYQCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVEYQCo
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 12:02:44 -0400
Received: from mail.enyo.de ([212.9.189.167]:40121 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262365AbVEYQCe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 12:02:34 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by albireo.enyo.de with esmtp id 1DayKv-0001fx-Li; Wed, 25 May 2005 18:02:25 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.50)
	id 1DayKs-0007Kt-LN; Wed, 25 May 2005 18:02:22 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekbwru6x.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 24 May 2005 18:05:42 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Junio C. Hamano:

> LT> Btw, that "1 < argc" order is very unintuitive to most humans.
>
> Yeah?  Not to people around where I come from, I do not know
> why.  It is not done for the assignment confusion avoidance
> "1==a".

In a comparison, it's common to mention the most-varying part first.
If you do this consistently, it increases readability.
