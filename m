From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stage/commit issue when checking out a branch
Date: Tue, 12 May 2009 09:38:24 -0700
Message-ID: <7v8wl28ef3.fsf@alter.siamese.dyndns.org>
References: <d96d20670905120901qa4c0353xc50160f880e17a21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter MacMillan <peterm@metavera.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3v0D-0000du-HM
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbZELQiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbZELQiY
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:38:24 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64767 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbZELQiX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:38:23 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512163824.ZUMZ17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Tue, 12 May 2009 12:38:24 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id qgeQ1b0054aMwMQ04geQi0; Tue, 12 May 2009 12:38:24 -0400
X-Authority-Analysis: v=1.0 c=1 a=gf8Twd_tMvMA:10 a=QsmizHufYfoA:10
 a=JrH4EILzeUE5pKkCsQwA:9 a=81k92EqqiNE1d4miPTz3b12UEuEA:4
X-CM-Score: 0.00
In-Reply-To: <d96d20670905120901qa4c0353xc50160f880e17a21@mail.gmail.com> (Peter MacMillan's message of "Tue\, 12 May 2009 12\:01\:14 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118921>

Sorry; broken as of v1.6.3~60; 83ae209 (checkout branch: prime cache-tree
fully, 2009-04-20) is the culprit.
