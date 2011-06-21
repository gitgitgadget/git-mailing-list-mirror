From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] revert: Introduce skip-all to cleanup sequencer data
Date: Tue, 21 Jun 2011 08:48:49 +0200
Message-ID: <201106210848.50884.chriscool@tuxfamily.org>
References: <1308636458-19668-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 08:50:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYuml-0004Ux-1a
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 08:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab1FUGtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 02:49:00 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:54293 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137Ab1FUGs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 02:48:59 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4429AA613E;
	Tue, 21 Jun 2011 08:48:52 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1308636458-19668-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176128>

On Tuesday 21 June 2011 08:07:38 Ramkumar Ramachandra wrote:
> When the sequencer data is persisted after a failed cherry-pick, don't
> allow subsequent calls to cherry-pick to clobber this state: instead,
> error out with the complaint that an existing cherry-pick is in
> progress.  To fix existing tests and the "rebase -i" script, introduce
> a new "--skip-all" command-line option to call after every failed
> cherry-pick; it essentially clears out the sequencer data, thereby
> allowing subsequent calls.

Nitpick: I'd rather call it "--stop" or "--quit" (or maybe "--reset") to 
convey the meaning that we get out of cherry-pick mode.

Thanks,
Christian.
