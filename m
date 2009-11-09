From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pulling git -- version confusion
Date: Mon, 09 Nov 2009 13:58:46 -0800
Message-ID: <7vzl6vqs15.fsf@alter.siamese.dyndns.org>
References: <f46c52560911082214x81ae8beya139a8bcb3cbcf2a@mail.gmail.com>
 <fabb9a1e0911082237x462b1203v724b51e309a2d89@mail.gmail.com>
 <f46c52560911082345y71eb12c9w114b799d70720dc6@mail.gmail.com>
 <fabb9a1e0911082351o326b205aic205552faae4e4da@mail.gmail.com>
 <f46c52560911090524l51140858sdde29d76e2cfed49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 22:59:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7cGO-00076N-Ee
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 22:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbZKIV6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 16:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbZKIV6x
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 16:58:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZKIV6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 16:58:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 989847ABDA;
	Mon,  9 Nov 2009 16:58:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C/aQfi4SBM4yl+dGollOCVx+QhU=; b=L208c3
	tcth/TDYWbbDP0zf63liXyYEWyIjwXZWk5RgXgMMInhzOC8MJziTPr8vlItXMHMz
	080vSLuR6VfA9GTsynWrWKxNb3CZXsJLWx05awvBCMqHDcpYxiwLFc3UW4wtMPXX
	1XQr1Z8Oe+/RXDeyolcezfThsDLggIQNxrjy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XR21cNJ8J5ixg1bAdnx6LzaPa//a+1sU
	AZhyGINMFyp98stONs9xKmyqJRUkWZ93jbqCl9I2YmZBrBGn+ZGE+j57a8bS7uON
	jq3Rnfem9H1qtVTEPF2txJNqmwHEwH4CxnVKlR9Rt71PIIgIe6ZYgQtrRm6aREo0
	oXnKoHPJfoE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 688A97ABD9;
	Mon,  9 Nov 2009 16:58:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7BE57ABD8; Mon,  9 Nov
 2009 16:58:48 -0500 (EST)
In-Reply-To: <f46c52560911090524l51140858sdde29d76e2cfed49@mail.gmail.com>
 (Rustom Mody's message of "Mon\, 9 Nov 2009 18\:54\:52 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1292B50E-CD7B-11DE-9A69-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132523>

Rustom Mody <rustompmody@gmail.com> writes:

> On Mon, Nov 9, 2009 at 1:21 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> On Mon, Nov 9, 2009 at 08:45, Rustom Mody <rustompmody@gmail.com> wrote:
>>> Gives me
>>> fatal: ambiguous argument 'origin/master': unknown revision or path
>>> not in the working tree.
>>> Use '--' to separate paths from revisions
>>
>> Well, as what remote do you have upstream configured?
>>
>> What is the output of
>> $ git config -l
>
> gives me
>
> core.safecrlf=true
> user.email=<my email>
> user.name=<my name>
> core.repositoryformatversion=0
> core.filemode=true
> gui.geometry=885x450+0+27 207 192
>
> So theres no remote?
> But .git/remotes/origin has
>
> URL: git://git.kernel.org/pub/scm/git/git.git
> Pull: refs/heads/master:refs/heads/origin
> Pull: refs/heads/maint:refs/heads/maint
> Pull: refs/heads/next:refs/heads/next
> Pull: refs/heads/html:refs/heads/html
> Pull: refs/heads/pu:refs/heads/pu
> Pull: refs/heads/todo:refs/heads/todo
> Pull: refs/heads/man:refs/heads/man

That's a layout that was default before 1.5.0, I think.  3 years is an eon
in git timescale.

People giving advice based on modern git experience would say things like
"origin/master", but in your layout that ref that keeps track of where the
'master' branch at the remote repository is is not called 'origin/master',
but simply 'origin'.

So instead of

> Try either:
> $ git checkout master
> $ git reset --hard origin/master

that Sverre gave you, in your repository you would do:

    $ git checkout master
    $ git reset --hard origin
