From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: backwards compatibility, was Re: [PATCH v1 1/3] Introduce config 
	variable "diff.primer"
Date: Mon, 26 Jan 2009 10:29:17 -0500
Message-ID: <76718490901260729m21ba140dke157d1d461aed2d5@mail.gmail.com>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu>
	 <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
	 <7v1vurf7lq.fsf@gitster.siamese.dyndns.org>
	 <alpine.GSO.2.00.0901251345240.12651@kiwi.cs.ucla.edu>
	 <20090126031206.GB14277@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0901261154330.14855@racer>
	 <20090126111605.GB19993@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Keith Cascio <keith@cs.ucla.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 16:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRTQE-0005XD-Tq
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 16:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbZAZP3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 10:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbZAZP3T
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 10:29:19 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:27684 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbZAZP3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 10:29:18 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5892376rvb.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 07:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Um9J2hN9MGSYyKzeR4+5VuPifpn8SdsRSEdnL5y6qLU=;
        b=VVUd6vb9zo/9OeUgUQsLvedr1xDIsjpRe20Au4uJa0DlMpYqWt7dpDJKubuWzBcMYw
         Bj0XDkad5meV8v2ZQTxwM9s0END9V/1yuTqvuWu5UECGlSRjjR+vewxoknCbas2omBC1
         ydSUUtWwnd54Cmi2qwQT+jxFIb4cy27LwuKBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UVhnWcrjdVMCEEuvvmIp7jHT1e70V3OQmU+6O9naJ2mzmCyJsY0iLWlrXKqVKo81bF
         ySwU2AVlM6Rp9ruMbyVDv9WXe83Pa7aQ7nt0fDcNywDuzgW9TDMSz7Xp9VAwWPWhPfcF
         3gLKk+dW4eP+3zeDVNviOJi6SRIM1HuHEuCwU=
Received: by 10.140.143.11 with SMTP id q11mr1017466rvd.104.1232983757885; 
	Mon, 26 Jan 2009 07:29:17 -0800 (PST)
In-Reply-To: <20090126111605.GB19993@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107218>

On Mon, Jan 26, 2009 at 6:16 AM, Jeff King <peff@peff.net> wrote:
> I don't want to break existing setups, either. But at some point you
> have to say "this is porcelain, so don't rely on there not being any
> user-triggered effects in its behavior". If porcelain is cast in stone,
> then what is the point in differentiating plumbing from porcelain?
>
> And when the line is blurred (as I think it is in several places)

Aside, AIX has commands that are run both directly or via smit (a
curses-based interface). When smit calls the commands, it passes a
switch to let said commands know that they are being run from smit.
e.g.:

       -J
            This flag is used when the installp command is executed from the
            System Management Interface Tool (SMIT) menus.

Perhaps adding such a concept to those git commands which can be used
in both porcelain and plumbing contexts would be useful for git.

j.
