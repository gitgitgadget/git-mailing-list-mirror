From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Mon, 21 Mar 2011 16:57:05 +0100
Message-ID: <1300723030.2583.24.camel@bee.lab.cmartin.tk>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
	 <1300371853-8965-1-git-send-email-cmn@elego.de>
	 <7vpqpoyjo3.fsf@alter.siamese.dyndns.org>
	 <1300701380.2583.13.camel@bee.lab.cmartin.tk>
	 <20110321111414.GD16334@sigill.intra.peff.net>
	 <1300721194.2583.22.camel@bee.lab.cmartin.tk>
	 <20110321155108.GA27662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 16:57:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1hTv-0000A6-7S
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 16:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab1CUP5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 11:57:16 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:45433 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab1CUP5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 11:57:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id F15A71B4BC5;
	Mon, 21 Mar 2011 16:57:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJjjqyFbgtw8; Mon, 21 Mar 2011 16:57:09 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 81F511B4BCB;
	Mon, 21 Mar 2011 16:57:09 +0100 (CET)
In-Reply-To: <20110321155108.GA27662@sigill.intra.peff.net>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169604>

On lun, 2011-03-21 at 11:51 -0400, Jeff King wrote:
> Yeah, I am happy to just drop it. AFAICT, an error return from snprintf
> is a bug in your program[1] or a bug in libc. In either case, it should
> fail or produce bogus output on the first run, and we don't need to
> worry about checking errors all the time. Noting the error helps a
> little with detection, but since we already install our own vsnprintf on
> known-buggy platforms, I haven't seen a single complaint.

 Then the patch in <1300359664-6230-1-git-send-email-cmn@elego.de>
should do the trick.

   cmn
