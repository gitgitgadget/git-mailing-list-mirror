From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 19:26:23 -0500
Message-ID: <76718490902191626u2202ed38xf63111b6a2758206@mail.gmail.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
	 <76718490902191255w24b30bd8jacaed8aa919d6526@mail.gmail.com>
	 <7vzlgij7cb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaJFH-0006nq-Fj
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 01:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523AbZBTA00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 19:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758498AbZBTA00
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 19:26:26 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:33004 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758447AbZBTA0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 19:26:24 -0500
Received: by rv-out-0506.google.com with SMTP id g37so661798rvb.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 16:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f7Jb05694vdLD2d+g6LBkIDpkW/SnUc4ZupkA2xH/wc=;
        b=cf0MNP1R2LWcSxXKMSly+w+Vc9EiWntoDlCwkwRpW+E6oZFcF3lM5shMbx1RJQwwvF
         3oNM+v+UkcG6POrKCP/f840qXICAoHYTa1YYBzz/VjbJeFe6cXqRR6nzDukg+IaI3B9p
         z5LXMZvr1T6t86E3RotNlDbPR8OyejY9Ak/js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RZyAKwbF8v62rBJHpCmPJIHhpvsmEcDgku4szMQrXE1yvrZ3otKhmMuSmzgFG2IUzq
         zhueQcjA/Vd7wLU8zbprVHBOqZX06pr6qUZ7PsKhrHRqYm0i2QIt0XJRjT/c/QodCIik
         /Uprwkn6ZexCmkZPvtWUJ+NO3KCUk+9Wv1r44=
Received: by 10.140.172.21 with SMTP id u21mr73649rve.177.1235089583894; Thu, 
	19 Feb 2009 16:26:23 -0800 (PST)
In-Reply-To: <7vzlgij7cb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110771>

On Thu, Feb 19, 2009 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> $ git rebase -i -10
>> $ git rebase -i -n -10
>
> The syntax would certainly imply a different semantics from giving
> HEAD~10.  How would you compute the set of commits to rebase sanely when
> you have merges after your 10th direct parent commit?

I didn't mean to suggest that -10 and HEAD~10 are the same thing.

I would expect -10 to act the same when given to rebase as it does
when given to format-patch. In both cases, you are asking the command
for a set of commits.

But as I said, I don't exactly know what -10 means to format-patch if
there are merge commits because I've never tried to use it in such a
context.

j.
