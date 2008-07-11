From: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Fri, 11 Jul 2008 22:53:14 +0300
Message-ID: <20080711225314.4ac268bf@linux360.ro>
References: <20080710170735.4c5b237a@linux360.ro>
	<7vskugkimt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: ryan@michonline.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 21:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHOhz-0003zs-1A
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 21:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbYGKTyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 15:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbYGKTyL
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 15:54:11 -0400
Received: from [194.117.236.238] ([194.117.236.238]:38086 "EHLO
	heracles.linux360.ro" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbYGKTyK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 15:54:10 -0400
Received: from localhost (82-76-182-196.rdsnet.ro [82.76.182.196] (may be forged))
	(authenticated bits=0)
	by heracles.linux360.ro (8.13.1/8.13.1) with ESMTP id m6BJrqZg030697
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jul 2008 22:53:54 +0300
In-Reply-To: <7vskugkimt.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.12.1; x86_64-pc-linux-gnu)
X-Spam-Status: No, score=1.8 required=5.0 tests=AWL,BAYES_00,HELO_LOCALHOST,
	RDNS_NONE autolearn=no version=3.2.4
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on heracles.linux360.ro
X-Virus-Scanned: ClamAV 0.93/6834/Sat Apr 19 00:09:50 2008 on heracles.linux360.ro
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88164>

On Fri, 11 Jul 2008 00:03:06 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro> writes:
> 
> > This option allows the user to process patches with git-send-email
> > and then import them into an email client, without having to send
> > them directly. The output format is mbox.
> 
> Input format is also mbox, so an obvious question is "why?"

Hi,

git-send-email has a lot more mail processing power than
git-format-patch. For example, there is no way to fill in "To:" with
git-format-patch.

I use this because I want to send the emails with my mail client
(Claws-Mail), not directly. This allows me to use git-send-email to
process patches instead of kludging the headers with something like
formail.


	Eduard
