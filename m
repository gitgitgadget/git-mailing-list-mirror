From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to properly update dumb-hosted repo (using rsync..?)
Date: Mon, 17 Dec 2007 15:46:44 -0800
Message-ID: <7v3au06g0r.fsf@gitster.siamese.dyndns.org>
References: <9b3e2dc20712171511r41e6bd4p64d243747ad4d2af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:48:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Pgh-0004EF-6T
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933108AbXLQXr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933284AbXLQXr2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:47:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933108AbXLQXr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:47:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2678C40BE;
	Mon, 17 Dec 2007 18:47:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D064140B3;
	Mon, 17 Dec 2007 18:46:46 -0500 (EST)
In-Reply-To: <9b3e2dc20712171511r41e6bd4p64d243747ad4d2af@mail.gmail.com>
	(Stephen Sinclair's message of "Mon, 17 Dec 2007 18:11:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68665>

"Stephen Sinclair" <radarsat1@gmail.com> writes:

> $ git-pull
> Warning: No merge candidate found because value of config option
>          "branch.master.merge" does not match any remote branch fetched.
> No changes.
> -------------------
>
> However I haven't done any branching in this cloned repo, it is
> immediately after a git-clone from the web server.
>
> My .git/config basically looks like this, minus the "core" section:
>
> -------------------
> [remote "origin"]
>         url = http://my.server.com/git/project.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
> -------------------
>
> Which seems fine to me...
> Any ideas?

A dumb question.  does "git ls-remote origin" show what you expect to be
there?  Specifically, does refs/heads/master exist?
