From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Wed, 13 May 2009 20:21:02 -0700
Message-ID: <7v4ovo1iap.fsf@alter.siamese.dyndns.org>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
	<bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Cory Sharp <cory.sharp@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 05:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4RVT-0000ZX-4S
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 05:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762394AbZENDVG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 23:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762260AbZENDVD
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 23:21:03 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41980 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761319AbZENDVB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 23:21:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514032103.ULHK17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 May 2009 23:21:03 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id rFM21b00B4aMwMQ04FM2vt; Wed, 13 May 2009 23:21:02 -0400
X-Authority-Analysis: v=1.0 c=1 a=zSBdUJs4lXYA:10 a=pGLkceISAAAA:8
 a=PLyqux32ZOV5aaw3ctQA:9 a=XhXsXVQaeJeDH1SMOEhcsQowsv4A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com> (Cory Sharp's message of "Wed\, 13 May 2009 19\:42\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119127>

Cory Sharp <cory.sharp@gmail.com> writes:

> Am I doing something a little wrong or unexpected?=C2=A0 Is there a w=
ay
> around this squash conflict behavior?=C2=A0 This doesn't seem to happ=
en
> with plain merge without squash.

Of course.  That's the whole point of recording a merge as a merge.
