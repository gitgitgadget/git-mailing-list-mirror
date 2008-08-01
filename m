From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Fri, 1 Aug 2008 10:39:58 +0200
Message-ID: <cb7bb73a0808010139n69f6d59fl4702cf2b20a8159f@mail.gmail.com>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>
	 <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 10:42:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOqCV-0000dq-2X
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 10:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbYHAIkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 04:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbYHAIkA
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 04:40:00 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:22312 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbYHAIj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 04:39:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so554880ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/DABF6YjpOZU+Wk8eLDwNeSRh0IdbAh4vZu3rQZcqSQ=;
        b=xXB6jZNQtNI+WKwwt/UDZlfvlhqJYEDu81ZoiS6Nmwbr63s7gAS2H7N6tk1yMnGeYP
         ehOsvx6RwFsOKuYKAK265+2k6ZNqx1+ePzPleBzWkcxqS6SdOdW6DcLQrevCkEi8MBL9
         mEF2TT18+18CvKa89GWicfbxOJjM+AknjDZaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=d6NQb1enKn94KgF+btX8oASCUbQ8A/vQHOk2jZ0t3qIib8c04uglf/VemzUoFFnY+p
         o7uBcg6zvH57qpMBurFKamszHJ+cLNMCYYuM2dKtjXNbVKZfzeL1lMOdhbf6/SdlBWmF
         8RRZDaDD4ojwi7KVVeLbSYGUdso+I35Ki5IiM=
Received: by 10.151.42.21 with SMTP id u21mr2816443ybj.211.1217579998271;
        Fri, 01 Aug 2008 01:39:58 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Fri, 1 Aug 2008 01:39:58 -0700 (PDT)
In-Reply-To: <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91044>

On Fri, Aug 1, 2008 at 10:20 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Well, I forgot to say but the above was soliciting third party review;
> original submitter does not count ;-)
>
> ... nah, I am just joking.
>
> All of the things you said in the message I am responding to are good
> background information.  It would have been nicer if it were part of the
> initial message, perhaps below the three dash lines, which would have
> avoided this extra exchange.

Yeah, I know, I'm sorry, I realized I should have written it there as
I was replying to your email. I'll try to keep it in mind the next
time I submit a patch :)

> Thanks again for the patch.  Somewhere I heard that there are 10 Rubyista
> git users for every non Rubyista git user, so I am sure somebody would
> comment on your patch in a day or two.  Perhaps we might even get Python
> and Perl hunk patterns (although I suspect Perl people are happy with the
> default one we stole from GNU diff) to go with it ;-).

You know, I think the Ruby funcname would work pretty well with Python
as well. Or something very similar. I'll try cooking up a patch for
that too. (But I thought Python users used mercurial? 8-D)

-- 
Giuseppe "Oblomov" Bilotta
