From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix warnings in PATH_INFO code and add export_ok/strict_export
Date: Mon, 18 Sep 2006 00:45:44 +0200
Organization: At home
Message-ID: <eekj5b$rlc$1@sea.gmane.org>
References: <20060916192750.GA27008@moooo.ath.cx> <20060916223027.GA32679@moooo.ath.cx> <20060916223101.GB32679@moooo.ath.cx> <7v64fm7u2q.fsf@assigned-by-dhcp.cox.net> <20060917090710.GA18153@moooo.ath.cx> <7vodte4w9w.fsf@assigned-by-dhcp.cox.net> <20060917132948.GA976@moooo.ath.cx> <7v4pv62lni.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 18 00:45:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP5O2-0006KM-3r
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 00:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWIQWpN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 18:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWIQWpN
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 18:45:13 -0400
Received: from main.gmane.org ([80.91.229.2]:9618 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965146AbWIQWpL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 18:45:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GP5Nr-0006IT-Nj
	for git@vger.kernel.org; Mon, 18 Sep 2006 00:45:07 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Sep 2006 00:45:07 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Sep 2006 00:45:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27211>

Junio C Hamano wrote:

> Matthias Lederhofer <matled@gmx.net> writes:
> 
>> This patch replaces the other two warning fixes by Jakub and me.  I've
>> put the whole thing in a sub-routine to keep the indentation level
>> low.
> 
> Looks much cleaner with this extra sub.
> 
> This does not seem have the "colon as a cue that the URL is also
> talking about a branch", Jakub's summary of the discussion
> between you two on #git channel.  I think that proposal makes
> sense as well.

Well, that is because this patch _predates_ the discussion 
(and proposal/conclusions). 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
