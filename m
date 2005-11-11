From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: file descriptor leak? or expected behavior?
Date: Fri, 11 Nov 2005 17:22:52 -0600
Message-ID: <e39c6bdc9e3f264e1248f937d9509c51@freescale.com>
References: <dd9dee136a573d72fc7332373cfd8ac1@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 00:23:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaiET-0000uo-1I
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 00:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVKKXWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 18:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVKKXWy
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 18:22:54 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:17407 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751377AbVKKXWx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 18:22:53 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id jABNYx8B005279
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 16:34:59 -0700 (MST)
Received: from [192.168.1.101] (mvp-10-214-72-75.am.freescale.net [10.214.72.75])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id jABNT6jg012867;
	Fri, 11 Nov 2005 17:29:06 -0600 (CST)
In-Reply-To: <dd9dee136a573d72fc7332373cfd8ac1@freescale.com>
To: Becky Bruce <becky.bruce@freescale.com>
X-Mailer: Apple Mail (2.623)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11644>


On Nov 11, 2005, at 4:58 PM, Becky Bruce wrote:
>
> error: Couldn't create temporary file
> .git/objects/04/48fa7de8a416a48cd1977f29858be54e67c078.temp for .git
> /objects/04/48fa7de8a416a48cd1977f29858be54e67c078: Error 24: Too many
> open files


By the way, in case this looks funny to anyone, this isn't the default 
message - I added the "Error 24" part because I'm used to looking at 
error numbers.

This is what the message looks like from an unmodified git:

error: Couldn't create temporary file 
.git/objects/a0/7e2c9307fa338896ecca300dc88033a8922885.temp for 
.git/objects/a0/7e2c9307fa338896ecca300dc88033a8922885: Too many open 
files


Cheers,
B
