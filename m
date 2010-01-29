From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 14:32:01 -0800
Message-ID: <op.u7bfjni44oyyg1@alvarezp-ws>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <op.u7a909hf4oyyg1@alvarezp-ws> <ron1-1F1799.13340029012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: "Ron Garret" <ron1@flownet.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 23:32:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NazNw-0005la-LP
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab0A2WcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754874Ab0A2WcL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:32:11 -0500
Received: from spider.alvarezp.com ([66.150.225.106]:35822 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab0A2WcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:32:10 -0500
Received: from alvarezp-ws (host-193-99-in-prt.caliente.com.mx [201.139.193.99] (may be forged))
	(authenticated bits=0)
	by spider.alvarezp.com (8.13.8/8.13.8/Debian-3) with ESMTP id o0TMW4L4032201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Jan 2010 14:32:06 -0800
In-Reply-To: <ron1-1F1799.13340029012010@news.gmane.org>
User-Agent: Opera Mail/10.20 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138389>

On Fri, 29 Jan 2010 13:34:01 -0800, Ron Garret <ron1@flownet.com> wrote:

> In article <op.u7a909hf4oyyg1@alvarezp-ws>,
>  "Octavio Alvarez" <alvarezp@alvarezp.ods.org> wrote:
>
>> On Fri, 29 Jan 2010 12:20:46 -0800, Ron1 <ron1@flownet.com> wrote:
>>
>> It means that if you switch to master^ and commit, your commit will
>> be applied but not tracked (since there is not any branch to advance).
>>
>> You would need to do git checkout -b 'new_branch', and then commit.
>> Now, new_branch will advance with your new commit.
>
> OK, I think I understand that.
>
> Here's the thing: I can do this:
>
> git checkout commit-id filename
>
> and restore a particular revision of a particular file to my working
> tree without affecting my HEAD pointer.  I would expect then that
>
> git checkout commit-id
>
> with no filename would do the same thing, except restore the entire tree
> from that commit (including deleting files that didnt' exist then).  And
> indeed it does that (or at least appears to -- I haven't explored this
> in depth), except that it DOES move my HEAD pointer to this weird
> non-branch thing.

I see. You somehow imply that "git checkout commit-id" overlaps with
"git reset --hard commit-id".

Even assuming the behavior was not documented in man git-checkout, the
second example looks useless. What is your use case? What would you do
after having all the files in the tree switched to another commit,
without actually updating HEAD to the commit, other than git reset --hard
again or git revert?
