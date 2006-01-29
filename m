From: Junio C Hamano <junkio@cox.net>
Subject: Re: git commit error on initial (the very first) commit
Date: Sun, 29 Jan 2006 13:08:58 -0800
Message-ID: <7v1wyqivx1.fsf@assigned-by-dhcp.cox.net>
References: <200601292026.54893.arvidjaar@mail.ru>
	<20060129181625.GA5540@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 22:09:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3JnH-0004Nk-TS
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 22:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWA2VJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 16:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWA2VJE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 16:09:04 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37370 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751104AbWA2VJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 16:09:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129210759.DYOY15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 16:07:59 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060129181625.GA5540@fieldses.org> (J. Bruce Fields's message
	of "Sun, 29 Jan 2006 13:16:25 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15245>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Sun, Jan 29, 2006 at 08:26:54PM +0300, Andrey Borzenkov wrote:
>> May be I do something wrong? What is correct procedure to initially import 
>> tree? git 1.1.4
>> 
>> {pts/0}% git init-db
>> defaulting to local storage area
>> {pts/0}% git add .
>> {pts/0}% git commit -m 'initial import'
>
> It needs to know which paths to update.

While I agree with you that individual developers should always
say "commit -a" after testing their changes, I do not think that
has much to do with Andrey's problem.

In a freshly created repository, "git add ." would register
everything to the index file, and a "git commit" with or without
"-a" that immediately follows "git add ." would commit what is
in the index.  Use of "-a" would not make a difference here.
