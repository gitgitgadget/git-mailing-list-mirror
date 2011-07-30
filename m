From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Sat, 30 Jul 2011 15:48:08 +0200
Message-ID: <201107301548.09815.chriscool@tuxfamily.org>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 15:48:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn9ty-0007Bo-LS
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 15:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab1G3NsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 09:48:22 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:59984 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab1G3NsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 09:48:21 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 58DB0A621D;
	Sat, 30 Jul 2011 15:48:12 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178195>

Hi,

On Saturday 30 July 2011 10:28:26 Jon Seymour wrote:
> For some bisection tasks, checking out the commit at each stage of the
> bisection process is unecessary or undesirable.
> 
> This series adds support for a --no-checkout[=<ref>] option to git-bisect.

Sorry but I didn't reply to your previous email when you asked about a "--no-
checkout[=<ref>]" compromise. I thought that Junio would reply and then I 
forgot about it.

My opinion is that if you really want to be able to use another ref, then 
there should be a special "--update-ref=<ref>" or "--use-ref=<ref>" option 
that is different from "--no-checkout".

"--no-checkout" looks like a boolean argument. And "--no-checkout[=<ref>]" may 
make the user think that this option will not checkout <ref>, and then it 
leads to the confusing question "but why would it checkout this f&#@ing ref in 
the first place?".

Thanks,
Christian.
