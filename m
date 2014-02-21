From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git-svn fetch after tag conversion?
Date: Fri, 21 Feb 2014 16:53:54 +0100
Message-ID: <53077692.4010408@web.de>
References: <CAHd499AnhD9V46uokx6Waj5XwBZCh-N8ms3ihkY99USej+GDOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 21 16:54:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGsQM-00006S-27
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 16:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbaBUPx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 10:53:58 -0500
Received: from mout.web.de ([212.227.15.14]:57685 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932276AbaBUPx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 10:53:57 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M6DyQ-1XDmSv1wCI-00y8xj for <git@vger.kernel.org>;
 Fri, 21 Feb 2014 16:53:55 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAHd499AnhD9V46uokx6Waj5XwBZCh-N8ms3ihkY99USej+GDOw@mail.gmail.com>
X-Provags-ID: V03:K0:3HKeg311BWnm5icf3qcDOfKS90Eajb1rPfXsn5skdjVO8GG82Ys
 ed91o4eHzeOZzbcdp5681XnguBaniYvqmhtE+0KKMkXSv5BEH5meB9u++uHNkfOFvYDy0tb
 vwOyR7FakB9bD//4Dh6GgLmIdTN8wyORAUcduziIAuOxGaCRIXXSUiBuOFq2vbCd4BM+P8k
 0SIxFgGejTFBnBEzxRUZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242467>

On 2014-02-21 15.42, Robert Dailey wrote:
> I'm converting a large SVN repository to a Git repository. I've run
> the first step of `git svn fetch` and now I have all of my branches,
> tags, and trunk. However my tags are still just branches, I have not
> converted them yet.
> 
> As I transition my team over to use Git, I wonder if it is possible to
> convert the tag-branches to real tags and still be able to do `git svn
> fetch` afterwards to continue to pull in changes. My goal is to have
> the git repository as ready as possible so that everyone can swap to
> it at once (and it'll be less downtime before i can push it to
> github). There are some scenarios I worry about:
> 
> - Will git re-fetch the tag-branches if they technically don't exist
> anymore (they would be real tags)?
> - What if a change is made to a tag, what will git-svn do?
> - New tags created, will those just create new tag-branches and I can
> convert them later?
> 
> Thanks in advance.
I stumbled over this as well.
As a tag and a branch is "the same" in svn, the best thing we can do
is to keep the svn tags as git branches, in the same way svn does.

Would it work if you make a script to tag the svn tags with a different name,
like "git_tag_v1.0" or so ?

Otherwise: just set up a test repo and see what happens ;-)
