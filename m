From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Does anyone have any benchmarks against CVS?
Date: Tue, 12 Jun 2007 18:58:40 +1200
Message-ID: <46a038f90706112358x5e2265fdu9aa58fb721641885@mail.gmail.com>
References: <20070611090451.26209.qmail@science.horizon.com>
	 <46a038f90706111454i5f4898b5kd77d18f4a893904e@mail.gmail.com>
	 <7vlkeqnm96.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 08:58:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy0L2-0003Da-Fc
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 08:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbXFLG6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 02:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbXFLG6m
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 02:58:42 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:54197 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbXFLG6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 02:58:41 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1700593wxc
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 23:58:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mP4CN0EeHB07FCknGCU8y9RRwFbumfKwZ53Sb4oXTgOn6o8FRLW18rf6L9NFOC5Sl0euxpj9Ab2mlYmY1rdhzqugS3IFD6L4inrPSJ4xVp9OtspIMGN5jwIzZGfmP+A0se62i5RCbukgyZeq2KMduPbWMiAV4pz9pN5lqoRBxXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b8nYrNJS0D/mOAgxUc1Tesv0X7VY/yvsq3hT45WVzxvTPk+LYhbbftG0unSBnCO/89yyr6RB4JS9jUL8GMotiiqAUBDZrlOBbDuBpy0Y9GOHh/VCrOG/drZ5t2pI/4Z5wjYaHD2QCGXmIgkQWduTM1WDHaU7YV+VQzUb6hgR8ZE=
Received: by 10.90.104.14 with SMTP id b14mr5041466agc.1181631520886;
        Mon, 11 Jun 2007 23:58:40 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Mon, 11 Jun 2007 23:58:40 -0700 (PDT)
In-Reply-To: <7vlkeqnm96.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49928>

On 6/12/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> > It _will_ be a bit of an apple-to-oranges comparison, but you could
> > use a few large-ish projects that have a published GIT gateway.
> > ...
> >   - cvs status vs git status
>
> This _is_ apples and oranges.

_All_ of them are ;-)

git-log is _not_ the same as cvs log. And a clone is not the same as a
checkout, ever. Perhaps diff is the only reasonable comparison.

However, the benchmarks doco can show the comparative numbers and
explain how those are different. Which is a great alibi to explain why
almost all the git ops are insanely faster * and some of the
interesting concepts behind git.

* - except clone - but mention "--references" to speed it up)

> people seem to use "cvs -q update -n" often
> when they want to know "what's different between me and
> upstream"?

I'm one of those ;-)

>  - "git am a-dozen-of-mails" vs its cvs equivalent.
>  - "git rebase a-dozen-of-commits" vs its cvs equivalent.

Don't thing those exist.

cheers


martin
