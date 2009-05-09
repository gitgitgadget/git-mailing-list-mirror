From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Sat, 09 May 2009 09:55:09 -0700
Message-ID: <7vskje6wsy.fsf@alter.siamese.dyndns.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
	<7v7i0scvcf.fsf@alter.siamese.dyndns.org>
	<op.utlq3vgx1e62zd@merlin.emma.line.org>
	<7vprek0ywq.fsf@alter.siamese.dyndns.org> <op.utlylkb61e62zd@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Matthias Andree" <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 09 18:56:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2pqn-0001cP-UV
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762AbZEIQzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756736AbZEIQzL
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:55:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58850 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747AbZEIQzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:55:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090509165510.HNUH18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 9 May 2009 12:55:10 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id pUv91b00D4aMwMQ04Uv9jH; Sat, 09 May 2009 12:55:10 -0400
X-Authority-Analysis: v=1.0 c=1 a=Sb75fb6s3KMA:10 a=5qu_ZHnkUusA:10
 a=INtQubLS65mAVwmbepAA:9 a=rMqpiAnSjjcZbYvUHZZ8c_NpJuIA:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118676>

"Matthias Andree" <matthias.andree@gmx.de> writes:

>> Fine then.  Or you could just append "." to the $PATH ;-)
>
> "." in the super user's PATH? Cool stuff, and so innovative.

I didn't mean to suggest PATH=$PATH:. *in the user's environment* ;-).
You do that inside GIT-VERSION-FILE, which is essentially the same thing
as running ./git$X from there.

What's innovative is whoever is running build as root.
