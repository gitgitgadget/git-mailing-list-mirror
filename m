From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Thu, 11 Jun 2009 16:59:16 -0700
Message-ID: <7viqj2e2zv.fsf@alter.siamese.dyndns.org>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	<ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
	<20090612084209.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 01:59:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEuB3-00050r-BP
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 01:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757455AbZFKX7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 19:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755049AbZFKX7P
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 19:59:15 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64641 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbZFKX7P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 19:59:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090611235916.LFIT20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 11 Jun 2009 19:59:16 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2nzG1c00X4aMwMQ04nzGab; Thu, 11 Jun 2009 19:59:17 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ZkqYN0c8iNwA:10 a=Z2nhhV3jvI0A:10
 a=UQnXkbzPAAAA:8 a=VXS7YyLET2W0mWfvAOAA:9 a=s2lAcL2y7zym7wY0WX_l_o4m8y0A:4
 a=Q21-j9j7q-gA:10
X-CM-Score: 0.00
In-Reply-To: <20090612084209.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Fri\, 12 Jun 2009 08\:42\:09 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121379>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> It would be ideal if you can inspect the certificate and decide if you
> need to ask for decrypting password before using it (and otherwise you
> don't ask). If you can't do that, probably you can introduce a config
> var that says "this certificate is encrypted", and bypass your new code
> if that config var isn't set.

True, and true.
