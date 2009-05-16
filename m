From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] new test fails "add -p" for adds on the top line
Date: Sat, 16 May 2009 12:13:21 -0700
Message-ID: <7vr5yon9ny.fsf@alter.siamese.dyndns.org>
References: <1c5969370905152010m486a8b85s96334e99e6c54ad5@mail.gmail.com>
	<20090516192529.6117@nanako3.lavabit.com>
	<200905161612.30911.trast@student.ethz.ch>
	<7viqk1ndlk.fsf@alter.siamese.dyndns.org>
	<fabb9a1e0905161055q89b9e6ei77a922749ed8cd5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Matt Graham <mdg149@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 21:13:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5PK8-0002hu-Cb
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 21:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931AbZEPTNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbZEPTNV
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 15:13:21 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49792 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756926AbZEPTNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 15:13:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516191321.JUWU17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 May 2009 15:13:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id sKDM1b0084aMwMQ04KDMfu; Sat, 16 May 2009 15:13:21 -0400
X-Authority-Analysis: v=1.0 c=1 a=bKi9ceUIwy0A:10 a=8WvdOqfm3OgA:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=E0lODpZpHy6aUO5pZPQA:9
 a=bgwnTTf1E3ArIc4PnakA:7 a=DWIqSvcOBc6mI8C41igtV47xJcQA:4 a=MSl-tDqOz04A:10
 a=qIVjreYYsbEA:10 a=iIAgB-EZmTb8K3QA:21 a=RpfgfHAp2XyUwCpS:21
X-CM-Score: 0.00
In-Reply-To: <fabb9a1e0905161055q89b9e6ei77a922749ed8cd5e@mail.gmail.com> (Sverre Rabbelier's message of "Sat\, 16 May 2009 19\:55\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119375>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Sat, May 16, 2009 at 19:48, Junio C Hamano <gitster@pobox.com> wrote:
>> We could also remove that "edit" thing; I do not use nor trust it
>> (fundamentally you cannot trust it).
>
> But it is very useful to split up patches! Of course, I always verify
> the end result (usually by diffing against HEAD@{...}), but it is
> definitely a very useful tool that I would hate to see removed :(.

Sorry, forgot a smiley ;-).
