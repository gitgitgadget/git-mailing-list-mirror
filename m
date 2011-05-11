From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [BUG?] git revert option parsing too lenient?
Date: Wed, 11 May 2011 22:51:46 +0200
Message-ID: <BANLkTi=ScEiUiE7Lm4LnhcWLGCzOWK5YQw@mail.gmail.com>
References: <BANLkTi=dPzu0wrDr3aycEv68M2tw7k5m8A@mail.gmail.com>
 <20110511203645.GB28742@sigill.intra.peff.net> <BANLkTin5FMYJkeLTNeZ47jsXtVxvrLRL+Q@mail.gmail.com>
 <20110511204851.GA29146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 11 22:52:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKGOW-0001jv-A5
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 22:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab1EKUw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 16:52:27 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34464 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab1EKUw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 16:52:26 -0400
Received: by qyg14 with SMTP id 14so520190qyg.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 13:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=e13UQsea8G3/9EwweZ+M6VNHOuhFBQ5busvIpbQ7+MQ=;
        b=UAPL4Y7ynYP/Lk3BOVoylBixqsL95aUdCIF1wYw3byJOl5pasdGIxOsT9jG54/6/Jz
         1kT3Su9x4iJB2Ot6o6rpEK0sKg/d14Yfs5cc4vczk9l6jKF1HxrroXOZqmF2RDNyK+/x
         H2kEmbEjhYPHFP690dRPUO9zdKURR5fZMKJVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=W7xD7pCScV+f2mfRMM59cy6dRSAWXwHRe2Kn36oO4eLvay4i8hOqZkD3H9hdL1M24B
         mAPBCGhFFBUMxawCQXjL8JqyZmP6nP4IPp234Zh4W53cXQ+yiPvKFm3/oYD+CQpQBRil
         lySEiIcb12HnXLFiCNPdrn0PfrIM35d3oVUq4=
Received: by 10.229.45.203 with SMTP id g11mr7698462qcf.65.1305147146124; Wed,
 11 May 2011 13:52:26 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Wed, 11 May 2011 13:51:46 -0700 (PDT)
In-Reply-To: <20110511204851.GA29146@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173427>

Heya,

On Wed, May 11, 2011 at 22:48, Jeff King <peff@peff.net> wrote:
> And I don't want to discourage you from trying to work on it. :)

Who knows, maybe I'll have some time to work on git(-remote-hg) sometime :).

-- 
Cheers,

Sverre Rabbelier
