From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] add --abbrev to 'git cherry'
Date: Sat, 30 May 2009 17:16:12 -0700
Message-ID: <7vzlcuw2ib.fsf@alter.siamese.dyndns.org>
References: <20090530140349.GA25265@unpythonic.net>
	<780e0a6b0905301413o2686fe34qaa076209c26c0b55@mail.gmail.com>
	<7v63fiyyrz.fsf@alter.siamese.dyndns.org>
	<200905310144.56380.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun May 31 02:16:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAYjH-00050U-3F
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 02:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbZEaAQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 20:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466AbZEaAQM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 20:16:12 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58368 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbZEaAQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 20:16:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090531001612.DGNN20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 May 2009 20:16:12 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id y0GC1b00F4aMwMQ040GDzZ; Sat, 30 May 2009 20:16:13 -0400
X-Authority-Analysis: v=1.0 c=1 a=YxzLv42keDoA:10 a=J_Enn-26-KwA:10
 a=GZcKEzH0szRENTo9eQMA:9 a=A9l166Tvn41YCYHeVEnTDB9_cxYA:4 a=5KVauyKsRKMA:10
X-CM-Score: 0.00
In-Reply-To: <200905310144.56380.markus.heidelberg@web.de> (Markus Heidelberg's message of "Sun\, 31 May 2009 01\:44\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120371>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Junio C Hamano, 31.05.2009:
>> Why do people even think a change like this to a _plumbing_ command is
>> desirable?
>
> git-cherry is plumbing? In git(1) it is listed as porcelain.

I'd say it is a miscategorization, but I do not care too deeply, as I
never use it myself (even though my Porcelain scripts would).
