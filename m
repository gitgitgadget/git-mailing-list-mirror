From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 09:30:20 -0500
Message-ID: <b4087cc50904240730n42e605e1od37d88d43e00f142@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org>
	 <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
	 <20090423201636.GD3056@coredump.intra.peff.net>
	 <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
	 <20090424141139.GC10761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 16:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxMRa-0005fA-4X
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 16:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbZDXOaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 10:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbZDXOaW
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 10:30:22 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:31200 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbZDXOaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 10:30:21 -0400
Received: by qw-out-2122.google.com with SMTP id 5so935227qwd.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vVP2AubDl3+/a1tadgLJCDKbLrCC8dfpiT2uS+OMphM=;
        b=FYd8PvVNi8tzZ/fdWZ+wkPM/tvX3MJAvAWE7eQsMf+giQ75j5y5TiA5upSp6SqxQlf
         piY4LUVPHgxkMeZ7kVCakJpbs81UTUSrl1PQnbtuq1zwwxeNvIEPZ0OGzOCNTSywQEfN
         KYFrg95QsY5gKGg2oSTaNZnRbZwSnwJG/h768=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Lt7M8DI27xAAc+AgP/6LYLV+sVU6xdOQuQgcZJTsp+MSjzlmd0gAG+cvrq6Xx5ECmo
         Z8t0CikQZ+FwJDtPtrmsTSTMUcrTCIFdf/PDav/DQNYiSX3G9DY4QMjJqO9d8LVjoygo
         C02il06TdQi9n1XnMejC9qWFuY2aV1GeLsJ70=
Received: by 10.224.37.19 with SMTP id v19mr2835687qad.70.1240583420584; Fri, 
	24 Apr 2009 07:30:20 -0700 (PDT)
In-Reply-To: <20090424141139.GC10761@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117443>

On Fri, Apr 24, 2009 at 09:11, Jeff King <peff@peff.net> wrote:
> I think I wasn't clear in my original message. I didn't mean teaching
> low-level stuff like plumbing or file layouts. By "bottom-up" I really
> meant teaching concepts (like objects, their types, and references),
> from which user operations and workflows can be explained (or often
> deduced by the user). Whereas a top-down approach would _start_ with
> workflows and say "To accomplish X, do Y".

I knew you would make exactly this rebuttle ;-D

However, notice that you can't reasonably be expected to understand
"accomplish X" without having concepts like objects and references.
The reason most people get by is that git's operation can be
compatible with a number of other theories people might have already
picked up from using computers. The trouble starts when their existing
theories don't mesh well with the underlying git theory, leading the
user to develop the equivalent of epicycles in order to explain to
himself whats going on.

Basically, the problem is that the documentation is currently catering
for people, who just want to download source files (as Bruce basically
said); a quick shell synopsis for this is fine, but there needs to be
documentation solely devoted to understanding git fully and precisely.
