From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Barebone Porcelain.  Where to stop?
Date: Mon, 18 Jul 2005 11:22:33 +0100
Message-ID: <tnx3bqcxvkm.fsf@arm.com>
References: <7vek9yirdi.fsf@assigned-by-dhcp.cox.net>
	<42DB32F1.5020900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 12:24:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuSml-0005Ls-Ht
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 12:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVGRKX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 06:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVGRKX3
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 06:23:29 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:41143 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261602AbVGRKXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 06:23:19 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6IAMMs4007146;
	Mon, 18 Jul 2005 11:22:22 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id LAA08483;
	Mon, 18 Jul 2005 11:23:00 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 18 Jul 2005 11:22:59 +0100
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <42DB32F1.5020900@gmail.com> (Bryan Larsen's message of "Mon,
 18 Jul 2005 00:41:21 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 18 Jul 2005 10:22:59.0356 (UTC) FILETIME=[ABC215C0:01C58B82]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bryan Larsen <bryan.larsen@gmail.com> wrote:
> Any lack of porcelain momentum is probably due to git having better
> documentation than the current porcelains, such as cogito and stacked
> git.  The documentation, like tutorial.txt and Jeff Garzik's git
> kernel howto give the impression that most kernel folks use git
> instead of cogito.
>
> I personally think that the cogito interface and stacked git
> interfaces are much nicer than git's, and would like to see these two
> tools achieve some momentum.

I don't see git going towards stgit at all. Indeed, it gets closer to
cogito but I still like cogito over plain git since it's easier to use
(my goal, though, is to add pull/clone commands to stgit so that one
doesn't need to rely on directly using other tools).

I am aware that, probably, the biggest problem with stgit is the
documentation (and also a lack of regression tests). I hope I will
find some time soon to write a tutorial and improve the command line
help. I will setup a wiki in the next few days so that others can
easily fix/update the documentation.

-- 
Catalin
