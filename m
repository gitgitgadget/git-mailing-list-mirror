From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fix memory leak in parse_object when check_sha1_signature fails
Date: Thu, 24 May 2007 19:38:46 -0700
Message-ID: <7virahtyo9.fsf@assigned-by-dhcp.cox.net>
References: <1b46aba20705241846u615785eeh7c3ebeaf840b2180@mail.gmail.com>
	<20070525020939.GT28023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 25 04:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPha-0005sT-Gk
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbXEYCis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbXEYCis
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:38:48 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42792 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbXEYCir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 22:38:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525023847.QREV2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 24 May 2007 22:38:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3Eem1X00X1kojtg0000000; Thu, 24 May 2007 22:38:47 -0400
In-Reply-To: <20070525020939.GT28023@spearce.org> (Shawn O. Pearce's message
	of "Thu, 24 May 2007 22:09:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48339>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Carlos Rica <jasampler@gmail.com> wrote:
>> When check_sha1_signature fails, program is not terminated:
>> it prints an error message and returns NULL, so the
>> buffer returned by read_sha1_file should be freed before.
> ...
>> 		if (check_sha1_signature(sha1, buffer, size, typename(type)) 
>> 		< 0) {
> ...
>
> gmail strikes again.  The above line is wrapped, which means your
> patch is whitespace damaged and won't apply properly.

That is only between your eyes, imagination and your MUA (hint:
"format: flowed").

For applying after saving it in mbox it does not pose a problem,
but it _does_ affect people who want to comment on the patch
while in MUA.

Is there a way to turn that "format: flawed" off?
