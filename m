From: John Tapsell <johnflux@gmail.com>
Subject: Re: Automatically remote prune
Date: Thu, 5 Nov 2009 17:05:50 +0900
Message-ID: <43d8ce650911050005l6d120cb0h374f3c04b3948b25@mail.gmail.com>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
	 <7v639qi2un.fsf@alter.siamese.dyndns.org>
	 <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
	 <7viqdpemki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 09:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5xLx-0002RH-H9
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 09:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbZKEIFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 03:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbZKEIFq
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 03:05:46 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:65024 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbZKEIFp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2009 03:05:45 -0500
Received: by pwj9 with SMTP id 9so3735760pwj.21
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 00:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hiS9n+TwPa8rodG3gIflqYVPwW9wccij4J4n/dyeOrQ=;
        b=BSbCAB7WIIrKciOkerCSCzWJ8osYVIqje6SDZsYExh40ksXLaLmQM7xr+QuEU6FsM3
         KEH9z/OFYoK9gG4NRQKu+I5gqtHe/UM9mmgOnFazGcphttIO9dg2rp+u3yLxm93mvAsX
         /iqxaG0dGjtolAGNEFBrR4kw7UAO4p00/Smn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YdABuc8vgrTa5tybmu3uwUniWvbnST/avaa5vmn7x3Nt4vH4mDtAzEKuvTFNupAsWx
         isAOXv4LoRDs9qSEvOF1SgZsA7R8ecv8FzVPc6qm1aChCyTzqXz6btax1vRl0oB9pPwF
         Zyriw0VedbdvdrawkJwXDBgViAB8McXPWB5xk=
Received: by 10.114.242.14 with SMTP id p14mr4349044wah.179.1257408350756; 
	Thu, 05 Nov 2009 00:05:50 -0800 (PST)
In-Reply-To: <7viqdpemki.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132210>

2009/11/5 Junio C Hamano <gitster@pobox.com>:
> John Tapsell <johnflux@gmail.com> writes:
> "what the benefits are to give this information _in the 'branch' outp=
ut_"
> was what I meant. =C2=A0From the part you omitted from my message:

I omitted it just because, imho, it's not what I 'care about'.  I'm
not trying to help advanced users (Users that _want_ to keep
remotes/origin/* clean and users that _want_ to be careful to not lose
commits are both advanced users, imho).  I'm just interested in
reducing confusion for non-advanced users.  So either not-showing
removed remote branches by default, or showing them but marking them
as deleted.

> A better approach to please the first class of audience may be to
> introduce an option that tells fetch to cull tracking refs that are s=
tale.
> Then "branch -r" output will not show stale refs and there is no plac=
e
> (nor need) to show [Deleted] labels.

If it's a non-default option, then it won't help the non-advanced users=
=2E

> Such an option won't be very useful for the second class of audience,
> though. =C2=A0For them we would need something else, and it would lik=
ely be an
> enhancement to "git remote".

Which still leaves confusion when viewing "git branch -r" since they
would show up there still.


John
