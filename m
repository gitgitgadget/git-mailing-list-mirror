From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fread does not return negative on error
Date: Wed, 24 Jun 2009 14:55:59 -0700
Message-ID: <7veit9qosw.fsf@alter.siamese.dyndns.org>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu>
	<25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com>
	<4A3FB479.2090902@lsrfire.ath.cx>
	<7vhby64i8f.fsf@alter.siamese.dyndns.org>
	<20090624081819.GA10436@elte.hu>
	<alpine.DEB.1.00.0906241201040.4773@pacific.mpi-cbg.de>
	<7vws71wquf.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906241835240.7946@intel-tinevez-2-302>
	<20090624175940.GC7576@elte.hu>
	<81b0412b0906241419q3bdef822laf9a879ce790d8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	roel kluin <roel.kluin@gmail.com>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 23:56:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJaRu-0007IA-Vm
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 23:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbZFXVz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 17:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbZFXVz6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 17:55:58 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:65245 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbZFXVz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 17:55:57 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090624215601.FMCQ17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Wed, 24 Jun 2009 17:56:01 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 7xvz1c00S4aMwMQ04xvzPr; Wed, 24 Jun 2009 17:56:00 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=F_o4wktclTQA:10 a=pGLkceISAAAA:8
 a=tW5YD1WfPYsZa-yfGNkA:9 a=9NHhnpXBFkgtjR8gaL0A:7
 a=2h2WSfJHheX7L_Xill1dpOuUT6EA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <81b0412b0906241419q3bdef822laf9a879ce790d8f@mail.gmail.com> (Alex Riesen's message of "Wed\, 24 Jun 2009 23\:19\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122161>

Alex Riesen <raa.lkml@gmail.com> writes:

> 2009/6/24 Ingo Molnar <mingo@elte.hu>:
>> +Here is an (incomplete!) list of main contributors to those files
>> +in util/* and elsewhere:
>> +
>> + Alex Riesen
>
> Wow. But I actually think it may be more fair to sort the list after
> any kind of rating (even something as dumb as commit count).
>
> As everyone one the list knows, I am nowhere near a "major contributor"
> to the project, as the first place may imply to a casual reader.

Heh, it was kind of obvious to a casual reader that the list was sorted
alphabetically by the first name (unusual, eh?).

And no, you are indeed a valuable contributor to the git project.

Thanks.
