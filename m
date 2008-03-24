From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Mon, 24 Mar 2008 10:54:28 -0400
Message-ID: <76718490803240754g161998bereb5bf3a22eb8ca76@mail.gmail.com>
References: <47E65AF5.4060708@dirk.my1.cc>
	 <76718490803230645k13471472sc99932563b0239da@mail.gmail.com>
	 <47E66382.5030800@dirk.my1.cc>
	 <20080323193842.GA23227@coredump.intra.peff.net>
	 <20080323194514.GA23492@coredump.intra.peff.net>
	 <76718490803231854u6ee76437h5acf37b0b602f3b1@mail.gmail.com>
	 <7vzlso3kjc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"=?UTF-8?Q?Dirk_S=C3=BCsserott?=" <newsletter@dirk.my1.cc>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 15:55:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdo4w-0007Qi-1M
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 15:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760047AbYCXOya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 10:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759014AbYCXOya
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 10:54:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:37433 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758392AbYCXOy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 10:54:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3463904wah.23
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=R+iSuq1eVTQXFXl4Oxnqhnt+PoOXKjchrZBrb1hEskg=;
        b=Xz6EZ6JOjmBunToTjrdBTVM9H9jgOJnCpHqrIJ/DONVnjyOK0AHf1bjFeq5II2dLE+Ij9KbKk+L75uNrmdGWYjdhz1/NhXwCZS0dLIl8JbMrxamsSnSs0b0qY3g1BKp+pKdWIpS8eC+cmHdJq9yJkufy/sghGz+JJNFOtZ1yzAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mRgyI7n7J8v5c9zQiYpdX673M8HIokgWy4IfikrZFQ3NGXUtbG04TaIyFlpp7fV301QtWrxXCezySeGOw2HPlauYVfcLrVLSgXkok9BzBP6PUYDRUg6UgQXTYWgu04Pcs9PHsqrmDYtX55fc858Z3hoS1qsF2Fq50FclC4xwkEo=
Received: by 10.115.78.1 with SMTP id f1mr11804939wal.100.1206370468478;
        Mon, 24 Mar 2008 07:54:28 -0700 (PDT)
Received: by 10.114.13.5 with HTTP; Mon, 24 Mar 2008 07:54:28 -0700 (PDT)
In-Reply-To: <7vzlso3kjc.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78046>

On Sun, Mar 23, 2008 at 10:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jay Soffian" <jaysoffian@gmail.com> writes:
>
>  > All my shell aliases therefor look like:
>  >
>  > h          = "!sh -c 'git alias \"$1\" || git help \"$1\"' -"
>  >
>  > (Notice the trailing '-'.)
>
>  Just for my curiosity, why aren't they
>
>  > h          = "!sh -c 'git alias \"$0\" || git help \"$0\"'"
>
>  without trailing '-'?

Lost to the mists of time. But I think for consistency with other
aliases where I was checking $#. Maybe.

j.
