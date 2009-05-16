From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Improve the naming of guessed target repository for  git clone
Date: Sat, 16 May 2009 10:49:39 -0700
Message-ID: <7vbpptndjg.fsf@alter.siamese.dyndns.org>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	<200905121557.18542.Hugo.Mildenberger@namir.de>
	<81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	<200905121900.00625.Hugo.Mildenberger@namir.de>
	<81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	<20090512172452.GA32594@blimp.localdomain>
	<20090513180853.GB26288@blimp.localdomain>
	<20090513205333.GA21631@blimp.localdomain>
	<7vfxf81ppd.fsf@alter.siamese.dyndns.org>
	<81b0412b0905132254n5046666t24f3887f1fd4e4d9@mail.gmail.com>
	<81b0412b0905140133l78def06kae0cb4798feaa4a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 16 19:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5O2A-00057w-FB
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 19:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbZEPRtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 13:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbZEPRtj
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 13:49:39 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44524 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbZEPRtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 13:49:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090516174939.HAQE20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 May 2009 13:49:39 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id sHpg1b0014aMwMQ04Hpgi0; Sat, 16 May 2009 13:49:40 -0400
X-Authority-Analysis: v=1.0 c=1 a=uSRkTckIU-MA:10 a=csnF2-1mRMQA:10
 a=pGLkceISAAAA:8 a=FE8NFRucEt1jTTdsGHEA:9 a=3HPtf-W6P8FxnlwW9nddHs8xiNQA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119370>

Alex Riesen <raa.lkml@gmail.com> writes:

> Strip leading and trailing spaces off guessed target directory, and
> replace sequences of whitespace and 'control' characters with one
> space character.
>
> User still can have any name by specifying it explicitely after url.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

Thanks, will queue.
