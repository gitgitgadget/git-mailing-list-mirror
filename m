From: Junio C Hamano <gitster@pobox.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Tue, 03 Jun 2008 23:58:11 -0700
Message-ID: <7vmym1zny4.fsf@gitster.siamese.dyndns.org>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 08:59:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3mxk-0003O6-Lr
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 08:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYFDG6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 02:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYFDG6U
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 02:58:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYFDG6U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 02:58:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA3B926A5;
	Wed,  4 Jun 2008 02:58:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F416926A4; Wed,  4 Jun 2008 02:58:13 -0400 (EDT)
In-Reply-To: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
 (wizzardx@gmail.com's message of "Wed, 4 Jun 2008 08:55:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C237F2A-3203-11DD-A423-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83751>

David <wizzardx@gmail.com> writes:

> Hi list.
>
> I've tried Googling for these, and checked the FAQ.
>
> 1) Is there a separate Git Users mailing list or FAQ?
>
> So that git noobs like myself don't bother the developers directly :-)
> Also so that non-git-developer users who want to help other users
> don't get a lot of mails with patches & git internal development
> discussions.
>
> 2) Is it possible to cherry pick multiple patches?
>
> Sometimes git rebase isn't appropriate, and it's a pain to do multiple
> 'git-cherry-pick' commands. Here is my current recipe:
>
> for C in $(git log --reverse <commit1>..<commit2> --pretty=format:%H);
> do git-cherry-pick $C; done
>
> Is there an easier syntax for doing this?

rebase --onto?
