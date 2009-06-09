From: Junio C Hamano <gitster@pobox.com>
Subject: notice: pu broken tonight
Date: Tue, 09 Jun 2009 01:36:20 -0700
Message-ID: <7vy6s1pzwb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 10:36:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDwon-00066W-MN
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 10:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758459AbZFIIgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 04:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757175AbZFIIgT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 04:36:19 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52845 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbZFIIgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 04:36:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609083620.LGET17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jun 2009 04:36:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1kcL1c0034aMwMQ03kcLL5; Tue, 09 Jun 2009 04:36:20 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=LyMkAgo1seGUXlHPiS8A:9
 a=bxr-91cR7NYkGHgFaobeJX5SElsA:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121156>

I've queued a handful of patches from yesterday on maint and master,
advanced sp/msysgit topic to next, and queued the remaining new patches
along with the old topics on pu.

I added "just in case output from strerror() had % in it" patch to
tr/die_errno topic when I queued it, but I didn't look at the conversion
from die() to die_errno().

Also I didn't queue the show-branch default_arg patch.  Other than that I
do not think I forgot to queue any patch I saw on the list.

I usually make sure all four branches pass the tests before pushing them
out, but in tonight's integration, the tip of 'pu' does not pass test for
me, hence this notice.
