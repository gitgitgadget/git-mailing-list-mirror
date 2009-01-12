From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Lightweight tag ?
Date: Mon, 12 Jan 2009 21:50:17 +0100
Message-ID: <m2r638p7ue.fsf@gmail.com>
References: <38b2ab8a0901111044x5db21d74i25ff7a26bb702a5d@mail.gmail.com>
	<7v63klsgf5.fsf@gitster.siamese.dyndns.org> <m2bpucnas2.fsf@gmail.com>
	<496B3DA8.1040308@drmicha.warpmail.net>
	<38b2ab8a0901120556x279f320oe693304dd2452050@mail.gmail.com>
	<496B59A3.2080507@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:00:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMTtG-0006BT-5M
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbZALU6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 15:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZALU6m
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 15:58:42 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:11728 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbZALU6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 15:58:41 -0500
Received: by fk-out-0910.google.com with SMTP id 18so5493042fkq.5
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 12:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=uP1YZ1SGzphU63Ys2tLD0OQGMdJ6h/vj2H7xuN6gZjw=;
        b=KKiutgK++pgGKhccqhT4YZbx3Kj45PHU+TmPSRAEfsEFl3ss9aCMGhr1jWt9J88v4o
         et4COSRzsQ9r6Ed4Pl1JB+mcMNOmIEaxxm69sIVGk8GXcbrWw1pujFccetbNdqah+9Y0
         2rrMn5YHqRmdnVWgavIuCrAn8+HAt6AgmsT6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:references:from:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=xEfmx/MyLgDuiFTrpXaMu+YGoInPuZyUPkUURyatLkoCESeys15qORPUYjmQyfyhCi
         A9pO6Sq6ugqEMKpLoFvGf+ZXFnm3kFpFNoayi0bj8kIH4+tMcY1vrGtjLatSnYb3Wofh
         SiR73UEnJDGjuLZDLCPgljrNl/RTPfDnWiakQ=
Received: by 10.103.175.9 with SMTP id c9mr10981617mup.3.1231793420420;
        Mon, 12 Jan 2009 12:50:20 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id j9sm60592381mue.49.2009.01.12.12.50.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 12:50:20 -0800 (PST)
In-Reply-To: <496B59A3.2080507@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 12 Jan 2009 15\:54\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105379>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Perhaps it needs documents which are more user friendly: I don't know where
>> the 'lightweight' word is coming from (perhaps from the implementation) but
>> I would expect that the _local_ term appears in the git-tag manual.
>
> It's the other way round. "lightweight" is in the first few lines of the
> man, "local" nowhere. In fact I don't see it anywhere in the docs.

Sorry my previous reply wasn't clear, I meant that the word
'lightweight' appears in the man page of git-tag but I don't see why
such term is used, well now I can see but it's implementation detail
so useless (or worth: confusing) for a dumb user (me).

In contrary I would have expected to find the 'local' word if git
support local tags.

>> I just need to create a local tag where I'm sure it won't be seen by others
>> whatever the git operations I'm doing, normally a simple "git tag" switch
>> should be enough...
>
> Taking "whatever" literally this is impossible, of course.
> 
>
> Taking it /cum grano salis/ it's still impossible within the same repo:
> If others have read access they can "ls-remote" and "fetch" happily what
> they want. The sane and easy way is to use a private repo for your local
> work and all your "local tags", then to push to a public (i.e.
> publically readable) repo those branches and tags which you want to be seen.
>

This is how things are currently implemented but if lightweight is
really useless and local tags are somehow missing in Git then I'm
pretty sure it's possible to create such tags that are not seen by
git-{pull,push,fetch] operations.

>
> Are you a Mercurial user by any chance?

Nope.

> "hg tag -l" creates local tags which are stored in an unversioned,
> private file, whereas "hg tag" creates (and commits) a tag entry in
> a versioned file, which is the source of some confusion and problems
> with hg tags ("hg co sometag" does not contain sometag etc.). Maybe
> you want the behaviour of "hg tag -l"?

Yes, It sounds that 'hg tag -l' is what I'm looking for in git...

Thanks
-- 
Francis
