From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 15:55:03 -0500
Message-ID: <76718490902191255w24b30bd8jacaed8aa919d6526@mail.gmail.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:56:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaFwi-0006U6-AY
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 21:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbZBSUzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 15:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbZBSUzH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 15:55:07 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:16895 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZBSUzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 15:55:05 -0500
Received: by rv-out-0506.google.com with SMTP id g37so582374rvb.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 12:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UsNriw6HbhQ52sTSuyB2RKJKZAfnR/JO8VR67iGZezY=;
        b=ardfiZzY8ogVenEUYcFF9MutiQw9WKzZS4TtHZaE9zVOZcOfs1bcMLACW6xljatrMu
         vLOc2uZutK57U6N0dC4uaAGLU06jy3baVBgwk5bP0lDYzFWw2/LZ4gmaRc4OqXEvgaU3
         r0HZBq1MvzwS8olEWuYlVBhiWY2CL6i1tqIKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A9Jla+ceJbnHNOdwrWBA8RmFz52o1jqD61eLX3I+vWH4nyX09crVZ8eHq6RuzHzpok
         cv2LoWoOfJPmVKK1bxiLtJF6wNaWxGuFFDJoGFQ2D5f4HB2MrNi4nzWCtVRdpU1MoqgK
         e/RundPWDkXv9xDUEt43a1/fG87wTXEokXpOw=
Received: by 10.141.87.13 with SMTP id p13mr232617rvl.229.1235076903828; Thu, 
	19 Feb 2009 12:55:03 -0800 (PST)
In-Reply-To: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110750>

On Thu, Feb 19, 2009 at 4:21 AM, John Tapsell <johnflux@gmail.com> wrote:
> Hi,
>
>  I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
> doesn't matter if you go back 'too far' I just always use HEAD~10 even
> if it's just for the last or so commit.
>
>  Would there be any objections to making  'git rebase -i' default to
> HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
> helps a bit with making it easier to use.

I think the following might be reasonable to support:

$ git rebase -i -10
$ git rebase -i -n -10

j.
