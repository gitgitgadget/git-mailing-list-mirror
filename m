From: Sven Joachim <svenjoac@gmx.de>
Subject: Re: ambiguous argument '...': unknown revision or path not in the working tree
Date: Mon, 18 Jan 2010 09:48:57 +0100
Message-ID: <87vdezol1i.fsf@turtle.gmx.de>
References: <87ska5vzbs.fsf@turtle.gmx.de>
	<7v3a23ucdm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 09:49:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWnIN-0000nV-7P
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 09:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab0ARItH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 03:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606Ab0ARItE
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 03:49:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:41466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751218Ab0ARItB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 03:49:01 -0500
Received: (qmail invoked by alias); 18 Jan 2010 08:48:59 -0000
Received: from p5486433D.dip.t-dialin.net (EHLO turtle.gmx.de) [84.134.67.61]
  by mail.gmx.net (mp011) with SMTP; 18 Jan 2010 09:48:59 +0100
X-Authenticated: #28250155
X-Provags-ID: V01U2FsdGVkX19o9ZJt1nJoDU9jdvg0ByfA17p1a77uT3ApThMLMb
	0CjC+l/0sGHtNT
Received: by turtle.gmx.de (Postfix, from userid 1000)
	id AEDD535545; Mon, 18 Jan 2010 09:48:58 +0100 (CET)
In-Reply-To: <7v3a23ucdm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 17 Jan 2010 22:59:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137376>

On 2010-01-18 07:59 +0100, Junio C Hamano wrote:

> Sven Joachim <svenjoac@gmx.de> writes:
>
>> I've got a strange error message in 'git push':
>>
>> ,----
>> | % git push
>> | Counting objects: 47, done.
>> | Delta compression using up to 2 threads.
>> | Compressing objects: 100% (24/24), done.
>> | Writing objects: 100% (24/24), 4.37 KiB, done.
>> | Total 24 (delta 22), reused 0 (delta 0)
>> | fatal: ambiguous argument '3bbc6def8a06e4411bee130b811ff9507e90503d:debian/changelog': unknown revision or path not in the working tree.
>> | Use '--' to separate paths from revisions
>
> I think there is nothing "fatal" in your git setup, other than that the
> repository at the remote end you are pushing into has a broken hook script
> (perhaps update, post-receive, or post-update) that is issuing the error
> message.

Thanks, that hits the nail on the head.

> I would raise the issue with the owner of the repository if I were you.

I've opened a support ticket.

Sven
