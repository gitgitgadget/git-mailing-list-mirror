From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 19:36:36 +0200
Message-ID: <E1DQ7Vg-0003fq-DC@be1.7eggert.dyndns.org>
References: <3X9X6-5JP-27@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Apr 25 19:34:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7SU-0000PH-7b
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVDYRiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVDYRiH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:38:07 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:30163 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262699AbVDYRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 13:37:40 -0400
Received: from be3.lrz.7eggert.dyndns.org (dsl-213-023-007-193.arcor-ip.net [213.23.7.193])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP
	id 162B5139878; Mon, 25 Apr 2005 19:37:37 +0200 (CEST)
Received: from be1.lrz ([192.168.1.201] helo=be1.7eggert.dyndns.org)
	by be3.lrz.7eggert.dyndns.org with esmtp (Exim 4.43)
	id 1DQ7ao-0000pq-Jq; Mon, 25 Apr 2005 19:41:58 +0200
Received: from localhost ([127.0.0.1] helo=be1)
	by be1.7eggert.dyndns.org with smtp (Exim 4.22)
	id 1DQ7Vg-0003fq-DC; Mon, 25 Apr 2005 19:36:40 +0200
To: Matthias-Christian Ott <matthias.christian@tiscali.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
User-Agent: KNode/0.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias-Christian Ott <matthias.christian@tiscali.de> wrote:

> The "git" didn't try store small variables, which aren't referenced, in
> the processor registers. It also didn't use the size_t type. I corrected
> a C++ style comment too.

I have compared functions using 'register' against functions not doing that.
Not using register allowed better optimization on my x86.
-- 
The most dangerous thing in the world is a second lieutenant with a map and
a compass.

