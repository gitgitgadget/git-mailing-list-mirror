From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Any command to simplify 'git fetch origin && git reset --hard origin/master'?
Date: Sat, 19 Jan 2008 00:06:15 -0800
Message-ID: <7vbq7i9r48.fsf@gitster.siamese.dyndns.org>
References: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
	<7vr6ge9tvh.fsf@gitster.siamese.dyndns.org>
	<46dff0320801190003x622a4f81j1c156f346f5bac03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 09:06:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG8j7-0004bv-5G
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 09:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbYASIGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 03:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbYASIGY
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 03:06:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbYASIGX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 03:06:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C54C5CA7;
	Sat, 19 Jan 2008 03:06:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EC7A45CA4;
	Sat, 19 Jan 2008 03:06:17 -0500 (EST)
In-Reply-To: <46dff0320801190003x622a4f81j1c156f346f5bac03@mail.gmail.com>
	(Ping Yin's message of "Sat, 19 Jan 2008 16:03:39 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71086>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Jan 19, 2008 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Ping Yin" <pkufranky@gmail.com> writes:
>>
>> > I often encounter the case that the origin reposotory is rebased and i
>> > make sure i want to use the origin head as my master
>> > Now I have to do
>> > $ git fetch origin && git reset --hard origin/master
>>
>> The fact you are resetting means you do not have anything
>> interesting in your own branch yourself (--hard will lose your
>> changes and you are willing to lose it), which makes the use
>> case much less interesting, but I can understand a workflow that
>> is based around rebases, as in:
>>
>>         $ git fetch origin && git rebase origin/master
>>
> I know 'git pull --rebase' and use it frequently. However, in the case
> i mentioned above, i never do any change in this local branch, i just
> use this branch for deployment which should always keep the same with
> the origin head (just like the remote tracking branch). So i need a
> 'fetch & reset --hard' equivalent, not the 'fetch & rebase'
> equivalent.

Unless I am misreading you, you did not read what I wrote.

If you do not have any change on that branch, "git rebase
origin/master" will be equivalent to "git reset --hard
origin/master".
