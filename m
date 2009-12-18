From: Zhi Li <lizhi1215@gmail.com>
Subject: Re: how can I push a sub-tree
Date: Fri, 18 Dec 2009 08:55:39 +0800
Message-ID: <2986b3940912171655t397f90b2tf28bac3555181292@mail.gmail.com>
References: <2986b3940912170150o17118a07i8f91e785c08e2ac9@mail.gmail.com>
	 <be6fef0d0912170214u433769e3ucf8180022aa72fb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 01:56:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLR8R-0001V7-SX
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 01:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbZLRAzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 19:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbZLRAzl
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 19:55:41 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:55273 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZLRAzk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 19:55:40 -0500
Received: by iwn1 with SMTP id 1so1850169iwn.33
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 16:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=KKvYGzpAZfFUQLA8499ZwbZ5YOCL9lYUhg4W1rufYqo=;
        b=fbEuJ/0gPuefiH6U+hc9BcyzA+BbJD0eXf7lGhvLe4dZh0t3iTKP8d+GSQ5Qq+fZ83
         /diZXMhYzg1uUs43c9UdrFdbeqyq3ifn2BSx6/d/AjnNx/K9/ZwfYyTRfYXs8NIwyfIS
         b9+1P23jQ2rA5F/8aPKwzZvw3MxhwM10BwaRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=t3j3nRHdQ4H4XaiQCM/K04v/9ExKHLmxv2gyXttj1QfS/4xgwt51Qs/UfYMRVHp/J+
         JC2GQsRiHqs7HrkmwvT6d42bQn0hwySvjqR85J0rhLwe5gzGYswOYh+zPKJhRQP9/yHG
         j7+fftiMjdgykoQl/bxpZ/sSMxr+/475ij/tw=
Received: by 10.231.24.142 with SMTP id v14mr1172297ibb.55.1261097739555; Thu, 
	17 Dec 2009 16:55:39 -0800 (PST)
In-Reply-To: <be6fef0d0912170214u433769e3ucf8180022aa72fb3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135393>

Hi,

Not sub-module, but sub-tree.

My problems are:
$ git remote add rack_remote git@github.com:schacon/rack.git
$ git fetch rack_remote
$ git branch rack_branch rack_remote/master
$ git read-tree --prefix=rack/ -u rack_branch

Now in master branch, I have a sub-tree rack. Later I modified
something in rack sub-tree. Then, how could I push my changes to
rack_remote?

Thanks
Zhi

On Thu, Dec 17, 2009 at 6:14 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Thu, Dec 17, 2009 at 5:50 PM, Zhi Li <lizhi1215@gmail.com> wrote:
>> I tried to find a way to push a sub-tree. In section 6.7 of "Pro Git",
>> there's a way for pulling a git sub-tree. But I have not found the
>> opposite: push a git sub-tree. Can someone help me?
>
> I've not read the book, but perhaps you mean submodules?
>
> If so, refer to the part in the git submodule tutorial that describes
> how to make changes within a submodule on the GitWiki at
> http://git.or.cz/gitwiki/GitSubmoduleTutorial.
>
> --
> Cheers,
> Ray Chuan
>
