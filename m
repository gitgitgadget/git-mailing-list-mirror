From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Refuse to send cover-letter template subject
Date: Mon, 08 Jun 2009 16:59:09 -0700
Message-ID: <7v4ouqwa42.fsf@alter.siamese.dyndns.org>
References: <7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 09 01:59:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDokH-0000k1-Uk
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 01:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZFHX7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 19:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753146AbZFHX7I
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 19:59:08 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40707 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbZFHX7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 19:59:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608235909.YRMN18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jun 2009 19:59:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1bz91c00A4aMwMQ03bz9gs; Mon, 08 Jun 2009 19:59:09 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=fC4PegqPu0EA:10 a=rURELfc3W64A:10
 a=wsEszfqlzf6qkVSM4QcA:9 a=YMC2T0Ly_rLOkTmFX9gA:7
 a=pm8I3FZK04FIa2j70h8FsQ9mxEwA:4
X-CM-Score: 0.00
In-Reply-To: <7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon\,  8 Jun 2009 23\:34\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121134>

Thomas Rast <trast@student.ethz.ch> writes:

> Every so often, someone sends out an unedited cover-letter template.
> Add a simple check to send-email that refuses to send if the subject
> contains "*** SUBJECT HERE ***", with an option --force to override.

Good ;-).  More valuable to detect would be an empty "blurb" section
(i.e. not "unedited *** BLURB HERE ***" string, but literally, there is
nothing said in the message other than the shortstat).

One twist is that I am reasonably sure that somebody will soon fix the
shortstat part of the cover letter with something more reasonable
(i.e. not categorized by author, but instead retaining the order of
patches, and for an added bonus, append names of authors other than
yourself at the end of the line in parentheses, or something).
