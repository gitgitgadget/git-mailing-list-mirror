From: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Mon, 14 Jul 2008 03:05:34 +0300
Message-ID: <20080714030534.70b91fd6@linux360.ro>
References: <20080710170735.4c5b237a@linux360.ro>
	<7vskudr11m.fsf@gitster.siamese.dyndns.org>
	<32541b130807131432j78e5100dyea20893268321466@mail.gmail.com>
	<7vbq11qxfb.fsf@gitster.siamese.dyndns.org>
	<32541b130807131444s5e9ea0d6v9610dd5871467fc9@mail.gmail.com>
	<7vvdz9o2wu.fsf@gitster.siamese.dyndns.org>
	<32541b130807131521w79cbf23m5934678e68312798@mail.gmail.com>
	<7vlk05o14i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>, ryan@michonline.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 02:08:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIBbl-0004NE-Lp
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 02:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbYGNAG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 20:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbYGNAG7
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 20:06:59 -0400
Received: from [194.117.236.238] ([194.117.236.238]:34887 "EHLO
	heracles.linux360.ro" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbYGNAG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 20:06:59 -0400
Received: from localhost (82-76-182-196.rdsnet.ro [82.76.182.196] (may be forged))
	(authenticated bits=0)
	by heracles.linux360.ro (8.13.1/8.13.1) with ESMTP id m6E06WFI020208
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jul 2008 03:06:32 +0300
In-Reply-To: <7vlk05o14i.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.1; x86_64-pc-linux-gnu)
X-Spam-Status: No, score=1.7 required=5.0 tests=AWL,BAYES_00,HELO_LOCALHOST,
	RDNS_NONE autolearn=no version=3.2.4
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on heracles.linux360.ro
X-Virus-Scanned: ClamAV 0.93/6834/Sat Apr 19 00:09:50 2008 on heracles.linux360.ro
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88362>

On Sun, 13 Jul 2008 15:44:29 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> However, strictly speaking,(2) may break the standard workflow of
> generating patches with format-patch and feeding the result to
> send-email, as format-patch does not do /^From / munging (and it
> shouldn't).  The issue is mostly theoretical --- it only matters if
> your commit log has a line that begins with ">From ", and people who
> have worked with e-mail for any nontrivial period have already
> learned to reword their sentences to avoid lines that begin with
> "From " (or ">From ", for that matter) anyway.

Munging happens only when doing --export. If you don't supply that
option, it won't affect anything, so there is no breakage.

BTW, git-format-patch already produces output somewhat compatible with
mbox, as it adds a From_ line.


	Eduard
