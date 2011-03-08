From: Michel Lespinasse <walken@google.com>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Tue, 8 Mar 2011 04:39:48 -0800
Message-ID: <AANLkTi=ybDr61jH2J+sZq3r+zeyN2KxdguGpKH67wrAe@mail.gmail.com>
References: <20110225133056.GA1026@sigill.intra.peff.net>
	<201102251658.22678.johan@herland.net>
	<20110301215907.GA23945@sigill.intra.peff.net>
	<201103020121.54690.johan@herland.net>
	<20110307233902.GA20447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 13:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwwCk-0001VY-JO
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 13:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab1CHMjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 07:39:53 -0500
Received: from smtp-out.google.com ([74.125.121.67]:39246 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab1CHMjw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 07:39:52 -0500
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p28CdodI028475
	for <git@vger.kernel.org>; Tue, 8 Mar 2011 04:39:50 -0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1299587991; bh=/KifH3yokOTW7awAGiGzfh1loQk=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	b=YqHVfVJYJs6K4AwlEru0RvG0rePFtzJmkQSxQZ8XqQtsoV8uUl1D0ysDFKKR7fnaW
	 vN8ZNMwfpMJxpr2HGbElw==
Received: from qwk3 (qwk3.prod.google.com [10.241.195.131])
	by wpaz5.hot.corp.google.com with ESMTP id p28CdLcR032429
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 8 Mar 2011 04:39:49 -0800
Received: by qwk3 with SMTP id 3so3677010qwk.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 04:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1DVQskQ11DoXqLAN0QjTU/yscrtJFTeH/05WOh37h+U=;
        b=XRwHg7UWyHKUvtdR0eMv+NxkvbT/fcsuzk/JTBxy7Pml9pEjv1XbaXzb+hsg13Rmqf
         AFz1XkS4r4llaxJddRiQ==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kVHr0kjkeFofx9VyAXr2+TGu47dU9P+JzEd7zGpPU+268tokq+CXv0KfgOaf8+5t1R
         hGEHbTHZLYq5PCME7sKA==
Received: by 10.229.206.42 with SMTP id fs42mr2633768qcb.150.1299587988944;
 Tue, 08 Mar 2011 04:39:48 -0800 (PST)
Received: by 10.229.5.83 with HTTP; Tue, 8 Mar 2011 04:39:48 -0800 (PST)
In-Reply-To: <20110307233902.GA20447@sigill.intra.peff.net>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168658>

On Mon, Mar 7, 2011 at 3:39 PM, Jeff King <peff@peff.net> wrote:
> Yeah, that's my biggest concern. I just really foresee myself getting
> annoyed by typing "--- nOtes ---", or "-- Notes ---". It's just a few
> characters shorter, but "---" is really less error prone.

git often puts comment lines lines (starting with '#') around the
commit message. How about just adding one more such comment:

# Lines after this one will be added as git notes

and make it so that any non-empty line entered afterwards does get
added as notes ?


Also, I would love to see this functionality in other places such as
rebasing (if the original commit has notes attached, I would like
these to show up so I can attach these to the rebased commit as well).
I realize not everybody would want that, but this could be easily
controlled with message hooks...

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
