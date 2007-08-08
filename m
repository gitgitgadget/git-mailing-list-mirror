From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-write-tree strangeness
Date: Wed, 08 Aug 2007 12:39:03 -0700
Message-ID: <7vabt14y08.fsf@assigned-by-dhcp.cox.net>
References: <20070808154211.GA25015@dervierte>
	<81b0412b0708080910u3aee166fo92ea73a4a0a78ccf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:39:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrN8-0002iZ-Jy
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbXHHTjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754321AbXHHTjF
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:39:05 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52138 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755733AbXHHTjE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:39:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808193902.VQID7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 15:39:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZXf31X0051kojtg0000000; Wed, 08 Aug 2007 15:39:03 -0400
In-Reply-To: <81b0412b0708080910u3aee166fo92ea73a4a0a78ccf@mail.gmail.com>
	(Alex Riesen's message of "Wed, 8 Aug 2007 18:10:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55345>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 8/8/07, Steven Walter <stevenrwalter@gmail.com> wrote:
>> I'm importing a large repository from svn into git with a custom tool,
>> and I noticed a strange issue with one of the commits.
>>
>> Upon investigating further, I found that when I ran "git-write-tree"
>> followed immediately by "git-diff-index <tree>" I had differences.  Does
>> that mean that git-write-tree incorrectly recorded the index, or do I
>> misunderstand things?
>
> What kind of differences? Different sha1 of content?
> I can't simply reproduce it.

Isn't this simply just a dirty worktree and missing --cached
option?
