From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: 1dfcfbce2d643b7c7b56dc828f36ced9de2bf9f2
Date: Mon, 22 Aug 2005 08:06:08 +0200
Organization: Blaupunkt GmbH
Message-ID: <43096B50.60605@de.bosch.com>
References: <7vy86vf7lg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 00:41:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7KxA-0003YO-0V
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 00:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbVHVWil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 18:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVHVWii
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 18:38:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:38539 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751410AbVHVWif (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2005 18:38:35 -0400
Received: from smtp-v.fe.bosch.de (smtp-v.fe.bosch.de [139.15.237.2])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M6A1m7032481
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 23:10:02 -0700
Received: from mta3.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta6.fe.bosch.de (Postfix) with ESMTP id 0C18E38189
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 08:06:38 +0200 (CEST)
Received: from si-imc02.de.bosch.com (virusscan7.fe.internet.bosch.com [10.4.98.12])
	by mta3.fe.internet.bosch.com (Postfix) with ESMTP id B79628C080
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 08:06:09 +0200 (CEST)
Received: from hi-mail02.de.bosch.com ([10.34.16.71]) by si-imc02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 22 Aug 2005 08:06:09 +0200
Received: from [10.34.196.147] ([10.34.196.147]) by hi-mail02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 22 Aug 2005 08:06:08 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy86vf7lg.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 22 Aug 2005 06:06:08.0523 (UTC) FILETIME=[96A4D5B0:01C5A6DF]
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> A couple of people noticed that the latest commit in the
> "master" branch seems, eh, odd.

Seems to me that this breaks http update

cg-update http://www.kernel.org/pub/scm/git/git.git

error: Tried 
http://www.kernel.org/pub/scm/git/git.git/objects/6f/f87c4664981e4397625791c8ea3bbb5f2279a3
Cannot obtain needed blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3
while processing commit 1dfcfbce2d643b7c7b56dc828f36ced9de2bf9f2.
cg-pull: objects pull failed

Dirk
