From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git checkout error
Date: Wed, 10 Oct 2012 09:02:30 +0200
Message-ID: <CAB9Jk9AFnauxX0dk8LfpBkpGDSWpWhqnzVew1Eo51K+qEA680A@mail.gmail.com>
References: <CAB9Jk9DUEL_J3MmH_4k7NC82m+crpCf1r3NS3gQBMZy+kvY3-A@mail.gmail.com>
	<m2lifg7zsj.fsf@igel.home>
	<CAB9Jk9CZ8d=8ugYs7XHXs84Kj9xJmTHZyZ2J0hU66OBS7YDZTg@mail.gmail.com>
	<7v626jdx8f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 09:02:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLqJa-0006zN-La
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 09:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab2JJHCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 03:02:32 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45204 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab2JJHCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 03:02:31 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so362381vcb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7IwM7EReSgnLneI1onD1UGF+e5ULe7VII6skkuX0YCE=;
        b=li4zVKl21Bkkl38Z3Z3hePNAySx3Hp2sv49V0tbXLLZMpP8kJ9z7VdV60FdBkOxbPB
         KmpyjM+Gh1kFC8b+ylD+i2cExsBaqMqPUtTV6p+n6GoyY9YEfGMnn4aKgckgvL8eWUTk
         wv3ByGQ7Ch+quPp8lvNAtVNWUUFf/5twUVf2aX7/28iEwrEplcEyrB6YhxZS3xVjOVmT
         D4KX/vTaiKjbfdHloh24cUwr+gzVJbjTDw4qXHA8mSa7iRm/uKY5ygOF6BMRl61DcRtg
         c3wcazS2EYCGXreax1dZr5Tiprs0Gp3ggwAPrSWkdPcYqOhfDfmlWmlqp4/w+bAGUzny
         nrNA==
Received: by 10.58.179.40 with SMTP id dd8mr2790540vec.41.1349852550423; Wed,
 10 Oct 2012 00:02:30 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 10 Oct 2012 00:02:30 -0700 (PDT)
In-Reply-To: <7v626jdx8f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207369>

Junio,

giving the user a better error message is certainly an improvement.
But would not be another improvement to describe better the command syntax
so as to help the user write the command right in the first place?
After all, what is the syntax section in commands for?
If I had seen in the syntax:

     git checkout [-q] [-f] [-m] [ [--track|--no-track](-b|-B)
<new_branch>] [<start_point>]

I would have written the command correctly, and not even stumbled on a
misleading
error message.
Note that the above syntax is exactly what the command must look like.
The syntax is mostly a description of the form of command for the
user. Internally, the
implementer can use it or can even use a different one (e.g. a more
lenient one and
detect errors at the semantic level instead). But here what matters is
not how the
command is implemented, but how the user has to form it.
Why it is so difficult to convince people to make documentation better?

-Angelo
