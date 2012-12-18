From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Tue, 18 Dec 2012 12:29:28 +1100
Message-ID: <CAH5451kpNYqJ99Lepjyq8-KEM1D3zeao1gSx05Q7LWWdE_=8jw@mail.gmail.com>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com> <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
 <17103971665F4C4495C6C96086A58B8F@PhilipOakley> <7v1ueol6ut.fsf@alter.siamese.dyndns.org>
 <CAH5451nVe1VcD3VzCO7EtKSkzv9CyJs=uqQ9MkMTJEXMTwEvmw@mail.gmail.com> <7vobhsjq6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Git List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:35:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkm5c-0008CH-Et
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 02:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab2LRBfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 20:35:04 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:45947 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab2LRBfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 20:35:03 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2012 20:35:03 EST
Received: by mail-qc0-f170.google.com with SMTP id d42so30768qca.15
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 17:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=22aQCEFxykCO8chLe3VjV8W+c08NU1Q8CtSNHbaypPM=;
        b=QtF+z55lsrgQJ6mNWBOOGLOYcgx4UMkLp8cxMSUWN6yTZGi6lfUP+uOE+gV2dqQXat
         R4xQJk1tggAX0cxvskqn1f3wYxm6oGOVNSo3DN9JpElA52EblCRfa630IaPVIM/pqATY
         /xTHXyRxxBtEU+7wunwT2QzT9Qs+/qGjV0cwOLXFb8/O0SMqX1BKPOJrDSl8ytRUEHs0
         tOTVefQ1r05kPh7qr6nCm3ZYtx5sLehK+60hySlviaTx1cpX6pVqT8TPkHQEhmbNjNY+
         CyD9McBCsZyAe9df22BBqERBL5BIJIRQm8UInzpFX4uYzSGuBsSkyoWSS2u0/10FBCVd
         uguw==
Received: by 10.49.118.138 with SMTP id km10mr150877qeb.18.1355794189123; Mon,
 17 Dec 2012 17:29:49 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Mon, 17 Dec 2012 17:29:28 -0800 (PST)
In-Reply-To: <7vobhsjq6a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211726>

On 18 December 2012 08:59, Junio C Hamano <gitster@pobox.com> wrote:
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>> Even if the primary purpose of "git checkout <branch>" is to "check
>> out the branch so that further work is done on that branch", I don't
>> believe that means it has to be stated first. In fact, I would say
>> that there are enough other use cases that the language should be
>> slightly more use-case agnostic in the first situation. For example,
>> someone might switch to another branch or commit simply to see what
>> state the tree was in at that point.
>
> I've been deliberately avoiding the term "switch", actually.  I
> agree that it may be familiar to people with prior exposure to
> subversion, but that is not the primary audience of the manual.

I don't have much experience with svn, so I didn't make that
connection. Independent of svn usage, what is wrong with the term
'switch'?

I would be interested to hear how translators communicate the checkout
concept, as I assume the word checkout doesn't exist in many
languages. For me, switching between revisions is a natural way of
phrasing the action, but perhaps there is a better way of saying the
same thing?

>> Some people use checkout to
>> deploy a tag of the working tree onto a production server. The first
>> example in particular is, I think, a common enough operation that
>> restricting the opening lines of documentation to talking about
>> building further work is misleading.
>
> I agree with you that sightseeing use case where you do not intend
> to make any commit is also important.  That is exactly why I said
> "further work is done on that branch" not "to that branch" in the
> message you are responding to.

Ah ok, I didn't pick up on that nuance. Your suggestion from earlier
has, for example, "Prepare to work on building new history on
<branch>" which *is* excluding that use case. Perhaps modifying
similar lines to something like "Prepare to work with the
repository/history/something from <branch>" or maybe just "Prepare to
work with <branch>" would better encapsulate those use cases.
Following lines would expand on what it means to work with a branch or
commit, and the technical details of updates to the repositories
current state.

Regards,

Andrew Ardill
