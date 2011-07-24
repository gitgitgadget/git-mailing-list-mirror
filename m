From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Help using git I'm review process
Date: Sun, 24 Jul 2011 16:37:09 +0200
Message-ID: <4E2C2E15.8010602@web.de>
References: <245B4B40-CA0A-43F6-A3F0-85E50D75CB93@gmail.com> <CA+39Oz5OT_RjyGeQdKaFycHjwN6hzy+N6P6DDBAtSv3vTYo_4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mathew Benson <mathew.benson@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 16:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkzo8-00020V-Ei
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab1GXOhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:37:13 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:60389 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab1GXOhL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:37:11 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2AD3E1A7137BC;
	Sun, 24 Jul 2011 16:37:10 +0200 (CEST)
Received: from [93.246.40.48] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qkznq-0007Sg-00; Sun, 24 Jul 2011 16:37:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CA+39Oz5OT_RjyGeQdKaFycHjwN6hzy+N6P6DDBAtSv3vTYo_4A@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/RoZjsPjBRM0e01wau+zysPbiNHZf/G3FI4Mp0
	EwzvOZ7wqoW2qZ+mAzelQNKJMrhhLo0oWPKNt+fv2C2FI0WBFT
	KQ5eFipIhTowoBa5taBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177760>

Am 24.07.2011 14:16, schrieb Thomas Adam:
> On 24 July 2011 13:12, Mathew Benson <mathew.benson@gmail.com> wrote:
>> I'm planning to use git for a work project, which requires tight control of the peer review process.  In previous jobs, the peer review was a tedious manual process of creating PDF files, writing comments in spreadsheets, and copying comments to the CM system.  I want to use technology to my best advantage.
>>
>> Once a developer has completed all his changes in his development branch, what's the best way to get those files to the reviewers, without requiring the author to stop work?  First, I think I should create a tag in the developer branch.  Each developer has a local repository, and my review tool writes files directly in the work area.  Can they just fetch, checkout a tag (don't know how to do that), commit changes, and push it back to the central repository?  Is there a better workflow?--
> 
> This is what Gerrit is useful for.

Yes, Gerrit is a very sophisticated way to do that.

But you can also achieve a review process by just using git and email
too: Have each developer do each topic of his work on a separate feature
branch and send merge requests (e.g. per email) to the reviewer when he
is done. If the reviewer approves the changes, he merges that branch
(and deletes the remote topic branch, as that topic is now finished and
part of the history). If not, he requests improvements from the developer
who updates that branch and sends another review request when he is done.
We use this approach successfully at my dayjob.
