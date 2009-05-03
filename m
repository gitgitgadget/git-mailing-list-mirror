From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug in git diff --unified=0 ?
Date: Sat, 02 May 2009 22:18:07 -0700
Message-ID: <7vy6ten4s0.fsf@alter.siamese.dyndns.org>
References: <20090502234701.GL23604@spearce.org>
	<7vocub59b3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 03 07:18:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0U5o-0002qH-Oj
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 07:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbZECFSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 01:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbZECFSJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 01:18:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58615 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbZECFSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 01:18:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090503051808.DFHQ18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 3 May 2009 01:18:08 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id mtJ71b0064aMwMQ03tJ7zs; Sun, 03 May 2009 01:18:07 -0400
X-Authority-Analysis: v=1.0 c=1 a=4fBY6cwzPQcA:10 a=ybZZDoGAAAAA:8
 a=oAYF_C9AAAAA:8 a=uZvujYp8AAAA:8 a=8t8XoiZL3PYNxiWLLIcA:9
 a=Ybw6nnV2Icp4WcwBq9j4x1sJc5QA:4 a=qIVjreYYsbEA:10 a=R0wQ3QzoQ0IA:10
X-CM-Score: 0.00
In-Reply-To: <7vocub59b3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 02 May 2009 17\:17\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118162>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
> I do not know what the current status of the POSIX draft for spliting
> "context diff" format into "copied context" and "unified context"...

POSIX 1003.1-2008 (base specifications issue 7) was published in December
2008.

    http://www.opengroup.org/onlinepubs/9699919799/toc.htm

The text in the part I quoted in the previous message seems to be
unchanged.

    http://www.opengroup.org/onlinepubs/9699919799/utilities/diff.html#tag_20_34_10_07
