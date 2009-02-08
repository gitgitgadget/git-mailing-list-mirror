From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sun, 8 Feb 2009 11:31:43 +0100
Message-ID: <2c6b72b30902080231i3f550322s106e1be2e5a4ed@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk>
	 <20090206191511.GD19494@coredump.intra.peff.net>
	 <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
	 <20090207071056.GB14856@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 11:33:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6yP-0000Hp-3o
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbZBHKbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 05:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbZBHKbq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 05:31:46 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:57640 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbZBHKbp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 05:31:45 -0500
Received: by fxm13 with SMTP id 13so2071670fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 02:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=7qLa0Pk3Ah1krDIcqVVe/DdJYZaem9ISKuw2Cq1mPos=;
        b=cbcCzuRpO4JnXRRopBrDpJFAduNJd3nk5zSbLnUpwc9MJh3+KuQlyvhhamR82hwid6
         T+3knM7hOyAHSHdn6PU3nBJov+5NiVtPD/nl7hLNlphcJllMc4GKl4m6MeaE3HFrKhTE
         PHzovqEd3cCC0sXQJQH9+Nnr6Vfqwu7VtnrsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=UO3hMsNCzO3U5NvOOQPdYSHjm97k5WM2c6npuayMTZQgmaydlA57P5+6uk7+C4BGVj
         SUkpbeQ+ipBVvRoBSQCrDQkCAaw15P7DSOyykwW8sDaAK+QQw/vnXQQQn4NIqgpE0SkD
         gRo4hLOR6dFQ87BFeBWgOw81XJJQ4zbVbjZgs=
Received: by 10.181.198.10 with SMTP id a10mr1359686bkq.120.1234089103748; 
	Sun, 08 Feb 2009 02:31:43 -0800 (PST)
In-Reply-To: <20090207071056.GB14856@coredump.intra.peff.net>
X-Google-Sender-Auth: a4bbd1912b159873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108949>

On Sat, Feb 7, 2009 at 08:10, Jeff King <peff@peff.net> wrote:
> It would require a "reload and jump to this arbitrary line" function,
> which I remember being problematic when I did my original patch a long
> time ago.  But I haven't looked at the new code to see if it is easier
> now (it looks like you have been doing quite a bit of refactoring in
> that area lately).

Yes, support for restoring/jumping to an arbitrary line is possible by
setting the view lineno and then call open_view with the OPEN_REFRESH
flag.

-- 
Jonas Fonseca
