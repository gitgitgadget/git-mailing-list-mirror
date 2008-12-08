From: "David Copeland" <davetron5000@gmail.com>
Subject: Re: Can someone confirm what the contents of refs/heads/master means?
Date: Mon, 8 Dec 2008 14:42:21 -0500
Message-ID: <f95d47890812081142k575264fctd77254ed3386a069@mail.gmail.com>
References: <f78b0fcc-6165-440a-b76b-b1b0a281b15c@k8g2000yqn.googlegroups.com>
	 <eaa105840812081135p56eceb97yb968575b11a7f985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Harris" <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 20:43:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9m18-0006s8-V2
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 20:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbYLHTmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 14:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbYLHTmY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 14:42:24 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:31314 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbYLHTmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 14:42:24 -0500
Received: by yw-out-2324.google.com with SMTP id 9so528814ywe.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 11:42:22 -0800 (PST)
Received: by 10.103.214.8 with SMTP id r8mr1377703muq.6.1228765341609;
        Mon, 08 Dec 2008 11:42:21 -0800 (PST)
Received: by 10.103.239.6 with HTTP; Mon, 8 Dec 2008 11:42:21 -0800 (PST)
In-Reply-To: <eaa105840812081135p56eceb97yb968575b11a7f985@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: f377a6262485f88a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102578>

Thanks for the info :)

The reason I edited by hand is when I was on trunk (e.g. git checkout
trunk), I did a git svn dcommit and it worked, but said "you aren't on
a branch", so I was concerned I might be in some weird state (i.e. if
trunk isn't a branch, can I make a branch off of it?)

Dave

On Mon, Dec 8, 2008 at 2:35 PM, Peter Harris <git@peter.is-a-geek.org> wrote:
> On Mon, Dec 8, 2008 at 2:23 PM, davetron5000 wrote:
>>
>> So, I overwrote refs/heads/master with the contents of refs/remotes/
>> trunk (i.e. the SHA-1 of the svn trunk).
>>
>> Things seem to be working; git svn dcommit commits to the trunk and
>> git svn rebase updates from svn's trunk.
>>
>> So, I want to make sure that refs/heads/master actuall does, in fact,
>> point to the head revision of whatever branch is considered "master".
>
> I do believe so, yes. That, or an entry in packed-refs.
>
>> Can someone comfirm this (or provide the actual explanation if I'm
>> wrong?)
>
> Overwriting internal files by hand feels a little too much like work
> for my taste. I would have done something more like "git reset --hard
> trunk" (or, if not on master, "git branch -D master; git branch master
> trunk" ), but of course you can feel free to do things the hard way if
> you prefer. :-)
>
> Peter Harris
>
