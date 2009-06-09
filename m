From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Refuse to send cover-letter template subject
Date: Tue, 09 Jun 2009 12:00:30 -0700
Message-ID: <7v4oupmdv5.fsf@alter.siamese.dyndns.org>
References: <7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch>
	<7v4ouqwa42.fsf@alter.siamese.dyndns.org>
	<200906092025.18643.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Tue Jun 09 21:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME6Yp-000193-Ga
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 21:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbZFITAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbZFITAa
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 15:00:30 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54468 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbZFITA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 15:00:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609190031.ZIIW20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jun 2009 15:00:31 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1v0X1c0084aMwMQ04v0XuR; Tue, 09 Jun 2009 15:00:31 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=fC4PegqPu0EA:10 a=rURELfc3W64A:10
 a=icSiC9i23aQzfIDuuFsA:9 a=2PI6k7mUX7JmM_GIMTcA:7
 a=YCCbR988qUgH_eJSZeKwQyakN6wA:4 a=5KVauyKsRKMA:10
X-CM-Score: 0.00
In-Reply-To: <200906092025.18643.markus.heidelberg@web.de> (Markus Heidelberg's message of "Tue\, 9 Jun 2009 20\:25\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121207>

Markus Heidelberg <markus.heidelberg@web.de> writes:

>> Good ;-).  More valuable to detect would be an empty "blurb" section
>> (i.e. not "unedited *** BLURB HERE ***" string, but literally, there is
>> nothing said in the message other than the shortstat).
>
> My mail "[PATCH 0/6] fixes for git-send-email" had an empty blurb
> section because it didn't need any additional description.
> I wouldn't want git to refuse sending it.

I actually wouldn't have wanted to see that [0/6] with empty description.

If the list of 6 patch titles give clear enough description of the theme
of the whole series, you would not need [0/6] to set the stage, and that
is the best kind of series.  For your send-email patches, you certainly
chose very good titles for them.
