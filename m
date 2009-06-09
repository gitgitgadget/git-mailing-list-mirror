From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git merge selective files
Date: Tue, 09 Jun 2009 13:54:05 -0700
Message-ID: <7v63f5ku1e.fsf@alter.siamese.dyndns.org>
References: <34b359190906090253v653ecc71q6684f4ebff2be59d@mail.gmail.com>
	<32541b130906091132sc5a647cn5fe0289ff9793cc3@mail.gmail.com>
	<4A2EB575.8050107@workspacewhiz.com>
	<32541b130906091239x1c92a1caxd260983a66e8025f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	joe higton <draxil@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 22:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME8LF-0007R9-00
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 22:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758905AbZFIUyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 16:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756852AbZFIUyF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 16:54:05 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37516 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637AbZFIUyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 16:54:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609205405.TXOQ18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jun 2009 16:54:05 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1wu51c00F4aMwMQ03wu5TZ; Tue, 09 Jun 2009 16:54:05 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=U8hHh_MNlOVWoaVu3JcA:9
 a=h-ft26lHrMJXG6Iiwdv_6F3-dhEA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <32541b130906091239x1c92a1caxd260983a66e8025f@mail.gmail.com> (Avery Pennarun's message of "Tue\, 9 Jun 2009 15\:39\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121224>

Avery Pennarun <apenwarr@gmail.com> writes:

> And the "'merge --squash' and don't commit the changes you don't want"
> option looks okay to me too.

Whatever you do to prepare the tree contents to suit the desire of the
original request, I think it is essential not to record the result of such
an operation as a merge (because it is not, and it will screw up later
merges).

Use of "merge --squash" in this thread is a very good suggestion.

Good job.
