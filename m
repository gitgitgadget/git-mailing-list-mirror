From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 08 Sep 2008 17:04:51 +0200
Message-ID: <48C53F13.10608@gnu.org>
References: <20080907103415.GA3139@cuci.nl> <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org> <20080908115129.GA19031@cuci.nl> <20080908143807.GB10252@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:53:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kckvn-0006B9-3N
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 19:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbYIHRwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 13:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbYIHRwg
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 13:52:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:38882 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbYIHRwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 13:52:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1554500fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 10:52:33 -0700 (PDT)
Received: by 10.86.63.19 with SMTP id l19mr11381671fga.77.1220886292914;
        Mon, 08 Sep 2008 08:04:52 -0700 (PDT)
Received: from scientist-2.lan ( [89.96.108.150])
        by mx.google.com with ESMTPS id 4sm5340694fge.8.2008.09.08.08.04.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 08:04:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080908143807.GB10252@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95279>


> Sorry for wandering into a thread in the middle.  But we've already
> been down this road before, and decided the additional header wasn't
> worth it from cherry-pick.  What's changed?  The fact that gitk
> wants to hyperlink this?  Why can't it just regex out a string of
> hex digits longer than 6 and see if there is a commit that matches?

The main difference is that git-cherry too often does not work right now
(I have a local patch so that it more-or-less works with my GNU
ChangeLogs, but it does not improve the situation if rerere kicks in).

(Of course git cherry could also regex out a string of hex digits longer
than 6 and see if there is a commit that matches).

Paolo
