From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run without sub-commands
Date: Fri, 30 Nov 2007 12:02:52 -0800
Message-ID: <7vr6i7qz6b.fsf@gitster.siamese.dyndns.org>
References: <e66701d40711300016v15700deft3d262d75a9055aca@mail.gmail.com>
	<20071130084131.GA29668@glandium.org>
	<e66701d40711300109nc43f3efyb33e591af15a060b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mike Hommey" <mh@glandium.org>, "Git ML" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nanako Shiraishi" <nanako3@bluebottle.com>
To: "Kevin Leung" <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 21:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyC54-0008NK-Ch
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 21:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbXK3UDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 15:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753973AbXK3UDA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 15:03:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44640 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbXK3UDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 15:03:00 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 859752F9;
	Fri, 30 Nov 2007 15:03:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0617C9B73B;
	Fri, 30 Nov 2007 15:03:15 -0500 (EST)
In-Reply-To: <e66701d40711300109nc43f3efyb33e591af15a060b@mail.gmail.com>
	(Kevin Leung's message of "Fri, 30 Nov 2007 17:09:58 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66660>

"Kevin Leung" <kevinlsk@gmail.com> writes:

> On Nov 30, 2007 4:41 PM, Mike Hommey <mh@glandium.org> wrote:
>> Still, 'git stash' alone should *do* the stash.
>>
>
> How about `git stash' still does the stash, and `git stash llist'
> exits with usage message? And if you want to save the stash with name,
> you can only do it with `git stash save name_of_stash'.

Sounds like a sensible thing to do.
