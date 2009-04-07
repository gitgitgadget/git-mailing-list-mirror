From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH 5/5] branch: show upstream branch when double verbose
Date: Tue, 7 Apr 2009 10:12:29 +0200
Message-ID: <4d8e3fd30904070112w72ada661p99525aaa9437f8ff@mail.gmail.com>
References: <20090407070254.GA2870@coredump.intra.peff.net>
	 <20090407071656.GE2924@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 10:14:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6Ri-00039F-D6
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbZDGIMf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 04:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbZDGIMd
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:12:33 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38901 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbZDGIMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 04:12:31 -0400
Received: by fxm2 with SMTP id 2so2207687fxm.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BN0bywzvF/UefR2O5IUlZnSLwPlfYFSBBRJtTXJXyXY=;
        b=QV/WwNQVNAjzYDcIPxtZS2s7fjkimaPoj0tvWDu8SZyzt9YxGmSl4n9ohATEJtEDi3
         7uZfwlcb/yKbc9FMkjPZmzhpLMt9jJWKrUtqmzduW6IXjBsSRfIUkrH/vBHqhDshkM6I
         a8KkCatVa6udoFlPQa+689Ch5/462TfWezbJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DXsyKY7k8Xme7xTozwaUywJ4QluuVw7y8OsNtjUj+564cyeJqU91zriXyJiCuvUBv9
         3SkGYnmC1UZvqXIkIFbTcYaRxnP50o4jk6xmbNQvOEDMEkdGYgwTF5mIdusKoA7SLPPG
         1jKvCDQcyLhYU9RIq9v4qx087R5XxJTLPXw78=
Received: by 10.86.59.2 with SMTP id h2mr3826194fga.73.1239091949179; Tue, 07 
	Apr 2009 01:12:29 -0700 (PDT)
In-Reply-To: <20090407071656.GE2924@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115930>

On Tue, Apr 7, 2009 at 9:16 AM, Jeff King <peff@peff.net> wrote:
> This information is easily accessible when we are
> calculating the relationship. The only reason not to print
> it all the time is that it consumes a fair bit of screen
> space, and may not be of interest to the user.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This one is very RFC. Should this information be part of the regular
> "-v"? Should it be part of "git branch" with regular verbosity?
>
> Should the format be different? I wonder if
>
> =A0master 1234abcd [origin/master: ahead 5, behind 6] whatever
>
> will be interpreted as "origin/master is ahead 5, behind 6" when it i=
s
> really the reverse. Maybe "[ahead 5, behind 6 from origin/master]" wo=
uld
> be better?

Yes I think so.
Thanks a lot for your work!

-Paolo
