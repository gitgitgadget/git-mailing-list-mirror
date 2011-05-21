From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Better error-handling around revert
Date: Sat, 21 May 2011 05:47:23 +0200
Message-ID: <201105210547.24831.chriscool@tuxfamily.org>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal> <20110520072846.GB6755@domU-12-31-39-06-A8-0A.compute-1.internal>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 05:53:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNdFq-0005vi-Pt
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 05:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab1EUDrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 23:47:39 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:32861 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486Ab1EUDrh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 23:47:37 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AACE8A62B6;
	Sat, 21 May 2011 05:47:26 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <20110520072846.GB6755@domU-12-31-39-06-A8-0A.compute-1.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174090>

Hi,

On Friday 20 May 2011 09:28:47 Ramkumar Ramachandra wrote:
> Hi,
> 
> Ugh, sorry about the whitespace breakage. Here's a fresh diff:

It looks like there is still whitespace breakage, because code is not indented 
anymore.

>     write_cherry_pick_head and write_message used to die when an operation
>     such as write_in_full failed.  Instead, clean up correctly, and return
>     an error to be handled by the caller.

Otherwise it looks good to me.

Thanks,
Christian.
