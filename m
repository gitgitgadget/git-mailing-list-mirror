From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] warn use of "git diff A..B"
Date: Thu, 24 Mar 2011 14:16:28 -0400
Message-ID: <AANLkTiknZiZbEedOgJwRqwN_9APb2x_9opOFsXYe8cWJ@mail.gmail.com>
References: <7voc51cydw.fsf@alter.siamese.dyndns.org> <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
 <AANLkTikjN_90UApfD2rRksDk8qXyE6pJHhd00Aw-Qe7Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 19:17:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2p5n-0008TW-6j
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 19:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab1CXSRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 14:17:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51110 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab1CXSQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 14:16:59 -0400
Received: by iyb26 with SMTP id 26so217093iyb.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=qZkdZWLRcBb+d2Rma8ajYmEVkfRI8Xwn2geMhnbTY3Q=;
        b=srPbrFhIC6OXsoI8R8UJ0Qss3sFeKtyVrfx8MqnVDKQHa4sfFb51X5EGsVXDU2YV0+
         kYe7jqebLtD68w5oxA/rTgn0rgg8dB7RaXNkQC+HvKzkP0AHEH/3qy5tPKBfEa/ojckY
         pOfDz5UmQ0YIGno6yLyYMPhc6N8/qca6wVl6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Hd+nwFZdke8yiWIkQvq+K8Jz5khRIbkJSIwz5OX+Izn6d9s3jv/Msx8uRW2MWEAZFn
         Dmo1ZCe0QfUqajmltFTot6lHfwckxu19y3li2r6N1K57qRg8VBvjgoxim+KMsZsoFUQt
         XSRUJvTI14oMvWQjftx/ZZUK7QdUVuNNFtcu8=
Received: by 10.231.113.42 with SMTP id y42mr2008072ibp.68.1300990619400; Thu,
 24 Mar 2011 11:16:59 -0700 (PDT)
Received: by 10.231.181.91 with HTTP; Thu, 24 Mar 2011 11:16:28 -0700 (PDT)
In-Reply-To: <AANLkTikjN_90UApfD2rRksDk8qXyE6pJHhd00Aw-Qe7Y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169935>

On Thu, Mar 24, 2011 at 2:11 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Also, the fact that a one-sided '..' implies HEAD on the other side

Sorry, stray sentence. Ignore it.

But also, context matters. I don't get confused that Perl has a ".."
operator which can be both a range operator and a flip-flop operator.

Of all the things that git overloads (reset, checkout, ...), this
seems the least confusing to explain.

$0.03. :-)

j.
