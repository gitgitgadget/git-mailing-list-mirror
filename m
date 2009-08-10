From: Tim Visher <tim.visher@gmail.com>
Subject: Re: [Feature Request] git export
Date: Mon, 10 Aug 2009 12:27:43 -0400
Message-ID: <c115fd3c0908100927v4d9e4a87we4502e91d3789138@mail.gmail.com>
References: <200908101822.59940.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Mon Aug 10 18:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXiy-0007ku-9K
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbZHJQ1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755685AbZHJQ1p
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:27:45 -0400
Received: from mail-yw0-f193.google.com ([209.85.211.193]:48120 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbZHJQ1o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:27:44 -0400
Received: by ywh31 with SMTP id 31so4032692ywh.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/Q82E0OMO07qSMCUsmiYdLRNTtF48GdDI0V417ymdlM=;
        b=mStjhX8lEVQFmgxw+wU+9Fqq+PuLvcDNouVBvLC50fxZZnaCnfbHkOOEVjys9V4w30
         KcaQoPmAhjXRlcKD13ypbewXJl/ZMR3kYxmEHQb/MATPjt007voZ50yqnnGiCf7NghHW
         CoBW0HAVQzJOqhMBDAjss8uFMML31H4Doa68w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pUifCOB709ESDWokE6LWXev/tYBVA5qkI66+biDfOjlBLNccfcZZSs4wUxSKTBTz+0
         6s3iCuaDkONo4YR1sRaT1364E8ioemq7872UHvstTBdbho/5PLiYKjUxZd0t7GN2mbXu
         IvCcgF6v92rvoTrTvdHCW2Kz7ENN+SWz/gXNQ=
Received: by 10.100.154.9 with SMTP id b9mr3896971ane.11.1249921663959; Mon, 
	10 Aug 2009 09:27:43 -0700 (PDT)
In-Reply-To: <200908101822.59940.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125482>

Hey Thomas,

On Mon, Aug 10, 2009 at 12:22 PM, Thomas Koch<thomas@koch.ro> wrote:
> could you please provide a simple solution to save a tree object into an
> arbitrary location?

This has been requested a few times and I have no idea what the
development status of it is.  Most people seem to recommend just
making an alias around git checkout-index.

> I found some hints, that it would be possible by missusing either git
> checkout-index or git-archive, but I think that it shouldn't require that much
> GIT FU to do such a simple thing.

It's not really a misuse, as the [man page
itself](http://www.kernel.org/pub/software/scm/git/docs/git-checkout-index.html)
recommends using checkout-index as a way to export an entire tree.
Until someone decides that it's worth making the porcelain command
(like you perhaps) then I think you can just stick with checkout-index
knowing you're not abusing anything.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
