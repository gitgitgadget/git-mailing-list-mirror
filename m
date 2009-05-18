From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging a branch when I don't want conflicts
Date: Mon, 18 May 2009 09:17:00 -0700
Message-ID: <7v8wkucrnn.fsf@alter.siamese.dyndns.org>
References: <93c3eada0905171930m36765d4fued9c2efdc57e51a4@mail.gmail.com>
	<4A10FDC6.2040706@viscovery.net>
	<20090518194548.6117@nanako3.lavabit.com>
	<be6fef0d0905180857y538b2c4y7208faa147a57601@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	geoffrey.russell@gmail.com, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 18:22:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M65bG-0004yr-Av
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 18:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543AbZERQRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 12:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758668AbZERQRB
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 12:17:01 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33569 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758771AbZERQQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 12:16:59 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090518161700.PGJB17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Mon, 18 May 2009 12:17:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id t4H01b0074aMwMQ044H01v; Mon, 18 May 2009 12:17:00 -0400
X-Authority-Analysis: v=1.0 c=1 a=J1y-1VvqGugA:10 a=3oNeO2JCQ8EA:10
 a=pGLkceISAAAA:8 a=UQnXkbzPAAAA:8 a=VwQbUJbxAAAA:8 a=jPdXFNcGvDuZXN3-mUMA:9
 a=Oo28jlsMNNTBJNKvmxZfoVcvHTgA:4 a=MSl-tDqOz04A:10 a=Q21-j9j7q-gA:10
X-CM-Score: 0.00
In-Reply-To: <be6fef0d0905180857y538b2c4y7208faa147a57601@mail.gmail.com> (Tay Ray Chuan's message of "Mon\, 18 May 2009 23\:57\:54 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119455>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Hi,
>
> On Mon, May 18, 2009 at 6:45 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
>> I think -Xours enhancement that was developed long time ago
>
> I think this is now called -s ours/--strategy=ours:
>
> http://www.kernel.org/pub/software/scm/git/docs/git-merge.html

Read it again.  -Xours is very different from -s ours.
