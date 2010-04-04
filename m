From: Eli Barzilay <eli@barzilay.org>
Subject: Re: [PATCH] Add `%B' in format strings for raw commit body in `git  log' and friends
Date: Sun, 4 Apr 2010 18:33:57 -0400
Message-ID: <19385.5077.27968.796350@winooski.ccs.neu.edu>
References: <19370.53192.313137.191218@winooski.ccs.neu.edu>
	<m3eiiunbky.fsf@winooski.ccs.neu.edu>
	<7v6346zwu1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 00:34:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyYOI-00026F-TO
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 00:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab0DDWd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 18:33:59 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:56979 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212Ab0DDWd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 18:33:58 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NyYOD-0003qS-1G; Sun, 04 Apr 2010 18:33:57 -0400
In-Reply-To: <7v6346zwu1.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143957>

On Apr  4, Junio C Hamano wrote:
> Isn't this the same as "%s%n%+b"?

The problem with that is that it wraps the first paragraph.  So it's
fine as long as it's always used as a subject line.

(I'm migrating a project to git, and some people will never remember
to do that.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
