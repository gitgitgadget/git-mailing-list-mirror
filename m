Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75DA21FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 20:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbcFTUwa (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 16:52:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41163 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752525AbcFTUw2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 16:52:28 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 55C24203F9
	for <git@vger.kernel.org>; Mon, 20 Jun 2016 16:43:39 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute7.internal (MEProxy); Mon, 20 Jun 2016 16:43:39 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=nfEALjR2eUrHE1wqR7LX9HuisPo=; b=HUPfu
	ao5vFj7Jk8Oe8KXsZOOOUqbgqCSOar+XSC1bVItMznivH4i8GQ7FvWbFRBaOt/C+
	AlldB4mzac7TlMHCPAH1wR1+d/cX8WQdvG4qBOZBcvHUquD7XQFMMNdGG7qkDbjy
	GLZdQW0pA8iyvsBbeJX1dix0973EzGx0IF+1tU=
X-Sasl-enc: tWyuuf/OcpfemtTSYH5Fe8jCigc53IjnXSegm3bRyONT 1466455419
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0DFA9F29EE
	for <git@vger.kernel.org>; Mon, 20 Jun 2016 16:43:39 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
	by ebox.rath.org (Postfix) with ESMTPS id 4B58F3001AC
	for <git@vger.kernel.org>; Mon, 20 Jun 2016 20:43:37 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
	id DBEEEBFF93; Mon, 20 Jun 2016 13:43:37 -0700 (PDT)
From:	Nikolaus Rath <Nikolaus@rath.org>
To:	git@vger.kernel.org
Subject: How to find commits unique to a branch
Mail-Copies-To:	never
Mail-Followup-To: git@vger.kernel.org
Date:	Mon, 20 Jun 2016 13:43:37 -0700
Message-ID: <878txz8ubq.fsf@thinkpad.rath.org>
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

What's the best way to find all commits in a branch A that have not been
cherry-picked from (or to) another branch B?

I think I could format-patch all commits in every branch into separate
files, hash the Author and Date of each files, and then compare the two
lists. But I'm hoping there's a way to instead have git do the
heavy-lifting?


Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             »Time flies like an arrow, fruit flies like a Banana.«
