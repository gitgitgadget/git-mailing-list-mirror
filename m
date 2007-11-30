From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run without sub-commands
Date: Fri, 30 Nov 2007 21:11:14 +0100
Message-ID: <85mysvwl25.fsf@lola.goethe.zz>
References: <e66701d40711300016v15700deft3d262d75a9055aca@mail.gmail.com>
	<20071130084131.GA29668@glandium.org>
	<e66701d40711300109nc43f3efyb33e591af15a060b@mail.gmail.com>
	<7vr6i7qz6b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kevin Leung" <kevinlsk@gmail.com>,
	"Mike Hommey" <mh@glandium.org>, "Git ML" <git@vger.kernel.org>,
	"Nanako Shiraishi" <nanako3@bluebottle.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 21:43:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyCiE-0006ra-HD
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 21:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbXK3Unb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 15:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbXK3Una
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 15:43:30 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:35970 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbXK3Una (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 15:43:30 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IyChp-0005Zp-Lq; Fri, 30 Nov 2007 15:43:25 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4191B1C407F0; Fri, 30 Nov 2007 21:11:14 +0100 (CET)
In-Reply-To: <7vr6i7qz6b.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 30 Nov 2007 12:02:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66661>

Junio C Hamano <gitster@pobox.com> writes:

> "Kevin Leung" <kevinlsk@gmail.com> writes:
>
>> On Nov 30, 2007 4:41 PM, Mike Hommey <mh@glandium.org> wrote:
>>> Still, 'git stash' alone should *do* the stash.
>>>
>>
>> How about `git stash' still does the stash, and `git stash llist'
>> exits with usage message? And if you want to save the stash with name,
>> you can only do it with `git stash save name_of_stash'.
>
> Sounds like a sensible thing to do.

Instead of "save", one could use "stash" since that is what it is
supposed to do.  Then

git stash stash stash

would create a stash called "stash".

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
