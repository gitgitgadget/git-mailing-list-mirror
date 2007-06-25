From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: record merge strategy in the log message on auto resolved merges
Date: Mon, 25 Jun 2007 00:50:27 -0700
Message-ID: <7vk5ts1ni4.fsf@assigned-by-dhcp.pobox.com>
References: <20070625071624.7919.qmail@82fa8ed4561cac.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:50:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2jLB-0004se-Sx
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbXFYHu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXFYHu2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:50:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55149 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXFYHu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:50:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625075028.UEJU3339.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 03:50:28 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FjqT1X0031kojtg0000000; Mon, 25 Jun 2007 03:50:27 -0400
In-Reply-To: <20070625071624.7919.qmail@82fa8ed4561cac.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Mon, 25 Jun 2007 07:16:23 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50876>

Gerrit Pape <pape@smarden.org> writes:

> If a strategy module auto resolved the merge cleanly, record the used
> strategy in the log message, e.g.:
>
>   Merge branch 'maint' using strategy ours
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>
>> I personally find this useful especially for the 'ours' strategy.

I really do not think we want to do this, especially when the
user did not specify anything unusual like "ours".

At least, exclude recursive and octopus out of it, please.
