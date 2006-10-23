From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-branch a builtin
Date: Mon, 23 Oct 2006 16:44:08 -0700
Message-ID: <7vfydewqbb.fsf@assigned-by-dhcp.cox.net>
References: <11616396262982-git-send-email-hjemli@gmail.com>
	<20061023215506.GB8344@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 01:44:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc9T1-0004m3-7j
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 01:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWJWXoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 19:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWJWXoL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 19:44:11 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60877 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932321AbWJWXoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 19:44:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061023234409.BRVO6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Oct 2006 19:44:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id dzjs1V01f1kojtg0000000
	Mon, 23 Oct 2006 19:43:53 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061023215506.GB8344@spearce.org> (Shawn Pearce's message of
	"Mon, 23 Oct 2006 17:55:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29902>

Shawn Pearce <spearce@spearce.org> writes:

> Lars Hjemli <hjemli@gmail.com> wrote:
> [snip]
>> ---
>>  Makefile         |    3 +-
>>  builtin-branch.c |  217 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  builtin.h        |    1 +
>>  git-branch.sh    |  131 --------------------------------
>>  git.c            |    1 +
>>  5 files changed, 221 insertions(+), 132 deletions(-)
> [snip]
>> diff --git a/git-branch.sh b/git-branch.sh
>> deleted file mode 100755
>> index 4379a07..0000000
>> --- a/git-branch.sh
>> +++ /dev/null
>> @@ -1,131 +0,0 @@
> [snip 131 lines]
>
> Aside from compatability with non-Git tools...
>
> Wouldn't it make more sense to just include the full SHA1 of the
> file we are deleting rather than the entire 131 line negative diff?

How would you do "git apply -R" on something like that?
