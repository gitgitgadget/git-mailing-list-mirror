From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Feature request: git-svn dcommit should send deltas upstream
Date: Mon, 01 Sep 2008 10:09:02 +0200
Message-ID: <87k5dw1e5d.fsf@mid.deneb.enyo.de>
References: <87myj0f3mb.fsf@mid.deneb.enyo.de>
	<20080829082311.GA7128@yp-box.dyndns.org>
	<87tzd4p1lt.fsf@mid.deneb.enyo.de> <87y72dkvq4.fsf@mid.deneb.enyo.de>
	<20080901034127.GA22120@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 01 10:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka4m3-0001AV-IR
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 10:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbYIAI10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 04:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYIAI10
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 04:27:26 -0400
Received: from mail.enyo.de ([212.9.189.167]:40343 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbYIAI1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 04:27:25 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1Ka4ke-000751-Ho; Mon, 01 Sep 2008 10:27:08 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Ka4T8-0006qJ-Ow; Mon, 01 Sep 2008 10:09:02 +0200
In-Reply-To: <20080901034127.GA22120@untitled> (Eric Wong's message of "Sun,
	31 Aug 2008 20:41:47 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94541>

* Eric Wong:

> Works for me, here.  I've also tested this editing an audio file and
> transmitting it over the wire without any trouble.  I've added one more
> patch on top of your series to check the (undef) return value of
> send_txstream.

I assumed that send_txstream croaks when it encounters an error.
Looking at the SWIG-generated sources, this seems to be the case.
