From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Documentation/remote-helpers: Add invocation section
Date: Mon, 05 Apr 2010 16:01:46 -0700
Message-ID: <7v1vetmrl1.fsf@alter.siamese.dyndns.org>
References: <x2zf3271551003311240i53ecb2fck173c8f34bdb3257@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 01:02:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyvJB-0000Ez-73
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 01:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab0DEXCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 19:02:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817Ab0DEXCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 19:02:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA6FA8217;
	Mon,  5 Apr 2010 19:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rvSDW0v/yJgKDh5Vna7xwi2i5D4=; b=alZPoN
	1bsCdKLwqRCC174UwE/l3Nwb4z+Y77PDTuzZmRLRgVHEkdObJuHP9axIRMc7A/+y
	3Q1szjUZMorX+CBia9VN6hTakL8+vv3O0paoLUDaqk5GcD3r/8OM7IVeQWroIYYR
	Q4JAC6lNEVyFz9bdqYoyk0VZaJizMGiJt8tJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rm9ZVsKTcLvAh6Z1qeJEduiYRrGwCEeA
	TxMzYQMjyPOThQU1+N4iMn62X23f2CWzbziStu1f6hDbMc5tSrKNJS+q2y2IuOCV
	LP3uVF8pkkI/u+/20QAQEGsBGtp2RHhvWPUeKBdGyj6QIKzX4OWfsGoShPpaIOgu
	yMDULBfVw9U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07AA1A820F;
	Mon,  5 Apr 2010 19:01:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FACCA8203; Mon,  5 Apr
 2010 19:01:47 -0400 (EDT)
In-Reply-To: <x2zf3271551003311240i53ecb2fck173c8f34bdb3257@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu\, 1 Apr 2010 01\:10\:04 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BE6F8F2-4107-11DF-918B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144072>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Add an invocation section to specify what the command line arguments
> mean. Also include a link to git-remote in the see also section.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  What changed since v3: Clarification on what URLs can be, and
>  possibility of second argument making the first redundant.
>
>  Documentation/git-remote-helpers.txt |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-remote-helpers.txt
> b/Documentation/git-remote-helpers.txt
> index 2382fb4..f2b2738 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -38,6 +38,20 @@ Git comes with a "curl" family of remote helpers,
> specifically
>  'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
>  and 'push'.
>
> +INVOCATION
> +----------
> +
> +Remote helper programs are invoked with one or (optionally) two
> +command line arguments. The first argument specifies a remote
> +repository as in git; typically, it is either the name of a configured
> +remote or just a URL. The second argument, if present, is a URL. When
> +the remote specified in the first argument has more than one
> +configured URL, it serves to resolve the ambiguity and pick one of the
> +URLs. Depending on the remote helper, supplying the second argument
> +can make the first argument redundant. URLs may be those normally
> +recognized by git, or arbitrary URL-like strings recognized by the
> +specific remote helper being invoked.
> +

What is the target audience of this paragraph?  You would need to keep
these questions in mind, depending on what your target audience is:

 - As a potential developer for a new "remote helper", how would one be
   helped by this description?

 - As a user of non-native transport served by a remote helper, how would
   one be helped by this description?

Suppose I am writing a remote helper 'frotz' to interact with the frotz
SCM.  What are the things I need to know about the remote-helper
mechanism?

 - I will write "git-remote-frotz"; it will need to be told which
   "repository" in native frotz SCM format the program should interact
   with, and that information would eventually come from the end users.

   By the way, is this even clear in the existing documentation?

 - The user will somehow specify that 'frotz' helper is called for the
   repository.  Perhaps "git clone frotz::<some info>" will create a new
   git repository and leave enough information in its .git/config so that
   later "git fetch" or "git pull" will automatically know that the name
   'origin' refers to my 'frotz' helper, and <some info> is passed to my
   "git-remote-frotz" program in some way.

   During the initial cloning, my 'frotz' helper will be called and will
   be given <some info> so that it can interact with the remote before
   having enough information in .git/config, perhaps.

   "git remote add mine frotz::<some info>" would leave similar kind of
   information in .git/config so that the nickname 'mine' refers to my
   'frotz' helper, and <some info> is passed to my "git-remote-frotz"
   program in some way, hopefully the same way as the above.

   Or "git fetch frotz::<some info>" from the command line may be used
   without any additional information from .git/config and would call my
   "git-fermote-frotz" with <some info>.

This INVOCATION section needs to spell out exact details of how that <some
info> is given to git-remote-frotz, so that I can decide how to encode the
repository information the program would use.

With some transports like the p4 example given in earlier discussion,
perhaps a single token that can be given from the command line may not
be sufficient to identify a foreign repository, in which case <some
info> might be just 'p4' and I would need to look up 'p4.origin.*' for
additional information on my own.  The details of p4 implementation does
not have to be spelled out in this INVOCATIONS section, but it needs to
hint the possibility of doing something like that.

I would think that INVOCATION section needs to specify how the helper is
selected (e.g. taking "frotz" out of "frotz::<some info>", or using the
configuration variable remote.origin.vcs), and where the one or two
parameters given to the program come from, to help such a developer who
wants to add his own remote helper.
