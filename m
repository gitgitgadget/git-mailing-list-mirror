From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 04:09:45 +0200
Message-ID: <484F33E9.1060205@keyaccess.nl>
References: <484F2174.9020508@keyaccess.nl> <ee77f5c20806101806u6dc04152rb8307eb12a6167c@mail.gmail.com> <484F26C9.9080608@keyaccess.nl> <20080611015608.GD29404@genesis.frugalware.org> <484F32B1.4050506@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	David Symonds <dsymonds@gmail.com>, git <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 04:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FnJ-0000oa-DY
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 04:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbYFKCJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 22:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbYFKCJo
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 22:09:44 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:44103 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231AbYFKCJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 22:09:43 -0400
Received: from [213.51.130.190] (port=42348 helo=smtp1.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6FmN-0003iW-KK; Wed, 11 Jun 2008 04:09:39 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:54648 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1K6FmN-000823-9k; Wed, 11 Jun 2008 04:09:39 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <484F32B1.4050506@gnu.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84581>

On 11-06-08 04:04, Paolo Bonzini wrote:
> Miklos Vajna wrote:
>> On Wed, Jun 11, 2008 at 03:13:45AM +0200, Rene Herman 
>> <rene.herman@keyaccess.nl> wrote:
>>> So in the case of merging a branch from the local repository into the 
>>> current branch, there is no difference between the two?
>>
>> There is no difference, but you really want to use git merge and not git
>> pull in such a case, I guess the git pull form is supported mainly to
>> keep backwards compatibility.
> 
> However, when you're on a tracking merge

On a what? :)

> only "git pull" will merge the right branch automatically into the
> current branch, fetching the branch name to merge from the config.
> If the branch.*.remote config key is ".", it will do a local merge.
> 
> Note that "git pull ." is optimized in that the fetch does nothing 
> except setting up MERGE_HEAD.

Rene.
