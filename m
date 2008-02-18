From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/5] Add platform-independent .git "symlink"
Date: Mon, 18 Feb 2008 15:04:27 +0100
Message-ID: <8c5c35580802180604w13e28cfdqce7aaad6676346e6@mail.gmail.com>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>
	 <1203331463-13857-2-git-send-email-hjemli@gmail.com>
	 <1203331463-13857-3-git-send-email-hjemli@gmail.com>
	 <alpine.LSU.1.00.0802181217580.30505@racer.site>
	 <8c5c35580802180518x5c392bddya21c48ea4db9a7cd@mail.gmail.com>
	 <alpine.LSU.1.00.0802181334010.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6cL-0000th-Cj
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbYBROE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYBROE2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:04:28 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:1605 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYBROE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:04:27 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2814908wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=09ZQAdgUKZFZwjVPBrTgiSsMJHLtZf0qAojVTX8pLtY=;
        b=Sd3VrU64TXl6ou22si5Q0pGtDjyM16RipUDZqZeR49duJ2O1H95onAlv0e/WSg5n5U1z6Y4QIl2SRS/gD0hO0cpvotJqnCsay5JSJokovyNlUsmbAU2s8eV/BMsohKIBQBk+iARrtNqDwOi00DpMDM5NUn9efG0EJKre9ir3Iog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xndETt0GdHnu4/fJF5jHgHGmyfNuVdnVVjwta+2/FAkuC032bthxwUdOZn7l7N88IP+F8xEwPY92rfNNc7/0RwC+C0fYdtfamyYxSxypG9RfGl5YB2FTf2kzBc8WqXCBC/swpmqkeG4FUo6BEUXsu31E5/lM9MXx9dsfhxaIWlo=
Received: by 10.114.153.18 with SMTP id a18mr5803664wae.82.1203343467085;
        Mon, 18 Feb 2008 06:04:27 -0800 (PST)
Received: by 10.115.92.8 with HTTP; Mon, 18 Feb 2008 06:04:27 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802181334010.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74292>

On Feb 18, 2008 2:35 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 18 Feb 2008, Lars Hjemli wrote:
>
> > On Feb 18, 2008 1:34 PM, Johannes Schindelin wrote:
> > >
> > > [* snip *]
> > >
> > > So maybe we can just scratch all that, and I agree that an invalid
> > > .git file means "no repository" (as opposed to "no valid repository").
> > >
> > > In that case, you might want to test for that, too...
> >
> > I think I do, did you find a loophole in the testing?
>
> I meant writing a readable, but invalid .git file.  Then testing that Git
> die()s with the correct message.

Ah, sorry for being slow, that's an excellent suggestion. I'll update
the test-script and resend 2/5.

--
larsh
