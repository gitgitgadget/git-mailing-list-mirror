From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Pulling tags from git.git
Date: Thu, 09 Mar 2006 08:37:02 +0100
Message-ID: <87zmk0dq75.fsf@mid.deneb.enyo.de>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>
	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>
	<440D5285.3050401@op5.se> <7voe0ilf25.fsf@assigned-by-dhcp.cox.net>
	<440D7A7D.8070507@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 09 17:32:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHO2M-0000IX-IK
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 17:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWCIQar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 11:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWCIQar
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 11:30:47 -0500
Received: from mail.enyo.de ([212.9.189.167]:473 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932679AbWCIQaq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 11:30:46 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1FHO2G-0006dB-KU
	for git@vger.kernel.org; Thu, 09 Mar 2006 17:30:44 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.60)
	(envelope-from <fw@deneb.enyo.de>)
	id 1FHFhm-0000Za-Q8
	for git@vger.kernel.org; Thu, 09 Mar 2006 08:37:02 +0100
To: git@vger.kernel.org
In-Reply-To: <440D7A7D.8070507@op5.se> (Andreas Ericsson's message of "Tue, 07
	Mar 2006 13:20:13 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17424>

* Andreas Ericsson:

[lightweight tags]

> I'm fairly sure we shouldn't. The default update-hook prevents them
> (if enabled), and I can't for the life of me think of why anyone would
> want to distribute such tags.

The current implementation is rather counter-intuitive because it's
much easier to create lightweight tags, and you wonder why they aren't
replicated by fetches (but some other tags are).
