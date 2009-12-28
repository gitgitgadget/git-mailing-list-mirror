From: Carlos Santana <neubyr@gmail.com>
Subject: Re: immutable tags?
Date: Mon, 28 Dec 2009 16:22:40 -0600
Message-ID: <92c9564e0912281422h1a69b5b7u15090f91327c237e@mail.gmail.com>
References: <92c9564e0912281204h13c6a566w95069023e6909eda@mail.gmail.com>
	 <87d41yvlpm.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: davidk@lysator.liu.se
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 23:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPNzI-0006I4-F2
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 23:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbZL1WWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 17:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbZL1WWl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 17:22:41 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:48373 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZL1WWl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2009 17:22:41 -0500
Received: by mail-fx0-f225.google.com with SMTP id 25so4885136fxm.21
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 14:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f83cSr7STHycKF5T29+k51OentC9Jl7bGUh/mGarhqE=;
        b=Idgq+FadhiX011cvDIFSXQeuhvlS4Y+O9QHvHsPEzKZavaAOtS/h0PsFKPnH18LhyH
         Liis7B7kJRy9xgx1ISqUAd6JnbFRP4ku19jxtJa8yZJ6c5gfwTktTg+9ioFq1i/GDSba
         1O1raUxPKNL+/tl+MlYckLXFI0jooOhv5T8rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QmPqY2NwBwaGZPBrrwSlr4bdDAFYvMBjLSAeAtVWrifeJAd7EpvpODobbiZb95S2T8
         9YzSm0wJMVFSLmGBILmVpmBDhKL6XzUpz9Bs0QBJiMm2mTnbf1kkM5QhI83RHKqhdqWF
         TCqrvf4GuvhvlT79RGtfQH3FLcLrQVTctNofg=
Received: by 10.223.15.148 with SMTP id k20mr20874740faa.6.1262038960285; Mon, 
	28 Dec 2009 14:22:40 -0800 (PST)
In-Reply-To: <87d41yvlpm.fsf@krank.kagedal.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135769>

Got it now.
Thank you all for explanation...

-
CS.


On Mon, Dec 28, 2009 at 3:21 PM, David K=E5gedal <davidk@lysator.liu.se=
> wrote:
> The following message is a courtesy copy of an article
> that has been posted to gmane.comp.version-control.git as well.
>
> Carlos Santana <neubyr@gmail.com> writes:
>
>> I would like to know if there is any difference between branches and
>> tags. Is it only conceptual - convention to be followed by a develop=
er
>> or some technical difference? =A0e.g. : Is it possible to create
>> immutable tags so that nothing can be checked in to that 'tagged
>> directory'?
>
> You are always in full control of your own repository, and have no
> control over what other people do with their's. So you can't prevent
> other people from changing the tags in their private repos, but you c=
an
> prevent them from propagating these changes back to you, or to a cent=
ral
> repository you control.
>
> But perhaps there is nothing to worry about. I think the git commands
> won't modify a tag unless you force it.
>
> Also, if you use signed tags, you can be sure that they are not silen=
tly
> replaced while still claiming to be tagged by you.
>
> --
> David K=E5gedal
>
