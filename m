From: Daniel <daniel@netwalk.org>
Subject: Re: dependable submodules
Date: Sun, 20 Mar 2011 09:06:44 -0700
Message-ID: <AANLkTimA-MKXrYfwE+WDOaPd7H1P6vvtcHTC6ODO5kAd@mail.gmail.com>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>
	<7vd3lmv2k1.fsf@alter.siamese.dyndns.org>
	<AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>
	<4D85F4E1.1020607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 20 17:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1L9X-0002Lp-IP
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 17:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab1CTQGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 12:06:47 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49600 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab1CTQGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 12:06:46 -0400
Received: by wwa36 with SMTP id 36so6554609wwa.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 09:06:45 -0700 (PDT)
Received: by 10.227.196.208 with SMTP id eh16mr3137910wbb.224.1300637204820;
 Sun, 20 Mar 2011 09:06:44 -0700 (PDT)
Received: by 10.227.141.84 with HTTP; Sun, 20 Mar 2011 09:06:44 -0700 (PDT)
X-Originating-IP: [216.228.174.132]
In-Reply-To: <4D85F4E1.1020607@web.de>
X-Google-Sender-Auth: 7IySvcIkDYZIjIYzYbxG7wJp9NA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169514>

On Sun, Mar 20, 2011 at 5:36 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 20.03.2011 05:32, schrieb Daniel:
>> So would it be correct to say that even though those files are
>> remotely fetched on a clone of the repository, they are actually
>> revisioned and stored in the super project?
>
> Not in the superproject, but you'll have your copy of the history
> of the submodule in its own .git directory on your harddrive.
>
>> This would have to be true for me to be able to still be able to
>> access those files in which case the project was abandoned (or if I
>> lacked internet access).
>
> If the remote side vanishes you still have your local copy. And if
> you need to share that with others you can push the submodule
> somewhere else and adjust the .gitmodules entry accordingly.
>


Because I'm using it to version control my own home directory, and not
all files are checked in to to git, this would post a problem for
backup. I only back up the .git folder itself since it's all I need
(running git checkout . to restore all the files) and individually
selecting each file to restore is a lot of work.

Perhaps I just have an odd use-case.
