From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] git-gc --auto: add documentation.
Date: Mon, 17 Sep 2007 12:54:00 -0700
Message-ID: <7vr6kxyso7.fsf@gitster.siamese.dyndns.org>
References: <11900186941912-git-send-email-gitster@pobox.com>
	<11900187073420-git-send-email-gitster@pobox.com>
	<Pine.LNX.4.64.0709171031420.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 21:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXMfp-0005U3-CJ
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 21:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbXIQTyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 15:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756158AbXIQTyF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 15:54:05 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52845 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbXIQTyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 15:54:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917195403.TCBM11237.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 17 Sep 2007 15:54:03 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id pXu21X00A1gtr5g0000000; Mon, 17 Sep 2007 15:54:02 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58476>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 17 Sep 2007, Junio C Hamano wrote:
>
>> +	When there are approximately more than this many loose
>> +	objects in the repository, `git gc --auto` that is
>> +	invoked by some Porcelain commands will create a new
>> +	pack and prune them.
>
> It might strike a newbie as dangerous to read "prune them" here.  Maybe
>
> 	... `git gc --auto` will pack the loose objects.  Some Porcelain 
> 	commands use this command, to do a light weight garbage collection
> 	from time to time.
> +
> *Note*: you should still run "git gc" from time to time, since the 
> "--auto" option is designed to be fast, whereas "git gc" _without_ 
> auto is designed to create small packs.
>
> Hmm? (I think that this is the most visible part of the --auto business, 
> so I would document the "git gc" note here...)

Makes sense.
