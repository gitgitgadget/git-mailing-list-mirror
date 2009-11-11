From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 18:57:24 +0100
Message-ID: <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 18:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8HS4-0002aE-2R
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 18:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757828AbZKKR5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 12:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757697AbZKKR5k
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 12:57:40 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60201 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510AbZKKR5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 12:57:40 -0500
Received: by bwz27 with SMTP id 27so1281337bwz.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 09:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=W6W0Q4CmuDEB2uIwBmJF8GNvzfrqEVkijwsWIi6gPWw=;
        b=O3zU8W4JBNqhlPE7MAl619TGI3LdTz9bdhw4svTGKnpyGrEBI8jDh6bV/+DkE8XY69
         7BK1IjqovS+6ysRYk8a5kdY1WhtMhLLUwaQB5qmDBEtmx7tE3eEngpc4i/TSJkZJxhAj
         CVwfK6pKtSWkEZdoF60l4obVajKvXbW6DTiDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=N8Q6FzjCTFum1F969qFCFXEB/8OVlm8QMX5ujUXofPfHgyB52M70ML0y5NP+/zACP1
         KdD8for5eAajrPfjLyglZBi31gvi9eQp8QXNfYWVRV/u0JaXOhsEUp2WSdwQYaIX2eqs
         akr8F0NLBYncfFVccsDyy+FSqUmEvPpPjxKlw=
Received: by 10.216.93.4 with SMTP id k4mr547718wef.155.1257962264382; Wed, 11 
	Nov 2009 09:57:44 -0800 (PST)
In-Reply-To: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132681>

Heya,

On Wed, Nov 11, 2009 at 10:34, Junio C Hamano <junio@pobox.com> wrote:
> * sr/gfi-options (2009-09-06) 6 commits.
> =A0- fast-import: test the new option command
> =A0- ...
> =A0- fast-import: put option parsing code in separate functions
>
> It seemed to be moving again soon, but nothing has happened yet...

I ran out of git time due to the start of my uni's next quarter, this
is next on my to-do list though, as my remote helper depends on it.

> * sr/vcs-helper (2009-11-06) 12 commits
> =A0- Add Python support library for remote helpers
> =A0- ...
> =A0- Fix memory leak in helper method for disconnect
>
> Re-rolled series that contains Daniel's and Johan's.
> Any comments? =A0Is everybody happy?

Daniel, are you going to send a follow-up to the memory-leaking patch?
If not, this needs to stay out of next until I have time to do so. My
gitdir patch might need to be evicted as it is connected to
sr/gfi-options which is not yet done. Also, we need to update the
documentation, but I think we can at least start cooking it in next
without these documentation updates?

> * ks/precompute-completion (2009-10-26) 3 commits.
> =A0(merged to 'next' on 2009-10-28 at cd5177f)
> =A0+ completion: ignore custom merge strategies when pre-generating
> =A0(merged to 'next' on 2009-10-22 at f46a28a)
> =A0+ bug: precomputed completion includes scripts sources
> =A0(merged to 'next' on 2009-10-14 at adf722a)
> =A0+ Speedup bash completion loading
>
> What's the status of this thing? =A0Last time I polled the list I had=
 an
> impression that it was not quite ready...

Does the current version require me to 'cd contrib/completion && make'
each time we update completion? If so, that's a (very annoying)
regression that needs to be fixed before it's merged to master IMHO.

--=20
Cheers,

Sverre Rabbelier
