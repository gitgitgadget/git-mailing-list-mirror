From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 14:02:27 -0700
Message-ID: <20130424210227.GL29963@google.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org>
 <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org>
 <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
 <877gjrpsk4.fsf@hexa.v.cablecom.net>
 <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 23:02:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV6q6-0004Ag-7q
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 23:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117Ab3DXVCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 17:02:41 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58528 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758185Ab3DXVCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 17:02:32 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so1433347pad.39
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 14:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CR1PeHRkI94jLF2Y9SAlKlTxrBJM5so3/+8E4o/c5eE=;
        b=grGTM41CaBZGQv8P9Ivf2pxlut2+yF6Tt0jlCzymrD10I+3SlIToc12GjWKLXLDHxS
         em1eNeM99Euw9Dx1PpNz+otjLH+/GnU7FCt4M/thAt5h8A5zqSlCPnDpPCMDcYn7HVTh
         8wqiqqnYHe0kRlie+Y+8MtnYYfYHyDBwRMPf5RTDtAwf029z/rgJqjbsROWJUhM6j2ou
         /RtVXo1n0fC/Dp16nmM7ywXGdQ1A5NBHxWCrcxgWrUw0GIAiBPMKc4FLeLJRrejlOqPm
         5DTMlr3ug9g2pKYzOHQQ/hhI3AOIZtAqeJW42umerKSBKXPUFrJYza8720lnhtipGN2k
         7bEA==
X-Received: by 10.68.114.100 with SMTP id jf4mr46106701pbb.144.1366837352401;
        Wed, 24 Apr 2013 14:02:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z8sm4347461pbt.23.2013.04.24.14.02.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 14:02:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222323>

Ramkumar Ramachandra wrote:

> Isn't it obviously incredibly useful?  I'm working on a topic branch I
> need to send out to git.git, and I want see how my WIP looks: should I
> have to rebase on master just to see this?

Nope.  I just do "git log master..topic".
