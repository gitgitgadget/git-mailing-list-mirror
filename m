From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git checkout error
Date: Wed, 10 Oct 2012 01:25:59 +0200
Message-ID: <CAB9Jk9CZ8d=8ugYs7XHXs84Kj9xJmTHZyZ2J0hU66OBS7YDZTg@mail.gmail.com>
References: <CAB9Jk9DUEL_J3MmH_4k7NC82m+crpCf1r3NS3gQBMZy+kvY3-A@mail.gmail.com>
	<m2lifg7zsj.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 01:26:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLjBj-0006TF-Qb
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 01:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab2JIX0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 19:26:01 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35949 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038Ab2JIX0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 19:26:00 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so7681381vcb.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4vAxR05LiDVgmPpS/myWtVYUqL1EF/vGgW4ljOYTH3o=;
        b=kQ9d6UpNPSQCKbkqLSmh7UwQdbZLva0J08f9iIzSo0eC3xN5C4nkGS3pAaBhcpGasK
         0Oht4fcZIbIwv/zzWZrN9KmcTnw+5e7ehUmE1sC+3SdLnUlepJyEBKLKL+PtXDhSvlqn
         dJ5qxo+exbatuoqp1M6hLqFslsXNey7p1ihjaT5kz5nLfAbupWKKPzNZSuRkxUzfYKgP
         R8RnwlyJ7PXLILWKXSWaZaouK8Mdss0vO9Odge5gVGLO/RSrgzvOL+tMk1Z8dZNwLt0L
         s+fEorK2PuKnvkHAqV0Eo2xGb5rKQNCYxB92Y9kh/Z1/FKTS/2xDW2N9G7whKNyyLv0C
         xZJg==
Received: by 10.52.90.147 with SMTP id bw19mr10289637vdb.17.1349825159194;
 Tue, 09 Oct 2012 16:25:59 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 9 Oct 2012 16:25:59 -0700 (PDT)
In-Reply-To: <m2lifg7zsj.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207353>

Hi Andreas,

>
> -b requires an argument <new_branch>, which you specify as --no-track
> here.  <start_point> is topic, and the rest is interpreted as <paths>.
>
The man page describes --track and --no-track as "options". This is why a
reader thinks that they can be specified in any order.
It is also very counter-intuitive to think that --no-track is <new_branch> and
<start_point> is topic. This is certainly not what the command does with
these data because it creates a new branch whose name is <new_branch> and not
--no-track.

I proposed a small change that clarifies the syntax, but if you prefer
to keep it obscure ...

-Angelo
