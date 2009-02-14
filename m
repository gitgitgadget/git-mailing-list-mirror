From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/3 v2] send-email: correct logic error with 
	--suppress-cc=cc
Date: Sat, 14 Feb 2009 02:15:45 -0500
Message-ID: <76718490902132315l1a9d9463n255cdfe5cce15d22@mail.gmail.com>
References: <1234583491-61260-2-git-send-email-jaysoffian@gmail.com>
	 <1234592519-71980-1-git-send-email-jaysoffian@gmail.com>
	 <7viqndzf0o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 08:17:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYEm1-0003i7-PH
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 08:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbZBNHPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 02:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbZBNHPq
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 02:15:46 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:6333 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZBNHPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 02:15:46 -0500
Received: by rv-out-0506.google.com with SMTP id g37so947702rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 23:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YzBJ9Usoe12xU+txtHFmSwrhJPMPRSRsq/Cx9y0L09o=;
        b=qLasaj4jcSWmUeqgaL5lc9Lm0nXJ1oYRnPvViWAgjBkCQiDBfXUPHTTmB2bZFpszR5
         T3BzuzFjEtLoOsxMMogltA7+bubnZJ61otsGQU5kY4oL9cyo21M7XzlSMF1roHAnM5+9
         QLxoZy7oLFUl8fGPpzJ8bOinyJ0MiH/GbH9MM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dAxeARFj+rHmDpKzoghtksRBg8svWz58Tpg83y5lQDcAwzS4ajDyIF3umg4qvL3jh7
         /wDF7QEF13sj4DXMzrRYNJbYxU528zZBYTNyJohcLo3LY+EmoRRn2/6eehYRjXN9cJ5J
         OGJYXR3+XXp3foXt4yQafEJ2DCP2cLFvCiGtU=
Received: by 10.141.196.8 with SMTP id y8mr285501rvp.101.1234595745517; Fri, 
	13 Feb 2009 23:15:45 -0800 (PST)
In-Reply-To: <7viqndzf0o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109837>

On Sat, Feb 14, 2009 at 1:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps it is easier to clarify the goal by updating the tests to define
> what needs to happen first?  Working from tests often makes the end result
> much more robust than randomly modifying the existing code here and there
> until it happens to start doing something you think it should do.

In this case the problem is that the existing code had no tests, so I wasn't
quite sure what it was supposed to do, and I divined the wrong thing from it.

But now that I understand what it should do, I'll add tests.

Who let the original code in w/o tests, hmm? :-)

j.
