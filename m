From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Approxidate with YYYY.MM
Date: Sun, 22 May 2011 17:10:08 +0000
Message-ID: <BANLkTik_kSx8cumFWxnoCze1T72yzBxkQQ@mail.gmail.com>
References: <CAE5FB52-0F90-4F21-828F-7E40ED596B33@gernhardtsoftware.com>
 <4DC8DCC2.8050208@drmicha.warpmail.net> <964517.31047.1305010481774.JavaMail.trustmail@mail1.terreactive.ch>
 <4DC8EBD8.50707@terreactive.ch> <4DC8F91C.5090709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Victor Engmark <victor.engmark@terreactive.ch>,
	Andreas Ericsson <ae@op5.se>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 22 19:10:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOCAv-0007Cn-HQ
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 19:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab1EVRKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 13:10:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33272 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab1EVRKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 13:10:40 -0400
Received: by iyb14 with SMTP id 14so4059093iyb.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=tcRZ6xhN4Ic8Am1wHKe3o+1MCJ/MbrwqDRx9PgL0RRQ=;
        b=hwz3UFBmaZkpR49Nr32I3TB/WzbqIDWv/HG2L94yDQ8Zo/VQekZr4FBjSi2mVcQKj5
         g/ld7KJ+fHR0C0NGh82O/plBWBOAbDsunZNAkkzzNp2baeG1bM5ABRXTivmYMPi4lcvy
         qsVY5plvDC/4iQXengl4L3giOpCQbbt+cEFvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jt39jyXR5rRdcqF91TMm+MldItiAy4ysfKl4PSNQToqp7ASGfG3UbA2G+HeQWXvB9R
         AXIx/qgIHkKNyghx0S7icw1FrBbDrYubYpMiwQBjK24sLhRBbCjj2nwyrOuFHw5bxCtf
         LJKyLFpQxUrYW/LDQ5nMw2IdkVh7qXCVMP4+I=
Received: by 10.42.159.194 with SMTP id m2mr8022614icx.83.1306084239050; Sun,
 22 May 2011 10:10:39 -0700 (PDT)
Received: by 10.42.173.72 with HTTP; Sun, 22 May 2011 10:10:08 -0700 (PDT)
In-Reply-To: <4DC8F91C.5090709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174192>

On Tue, May 10, 2011 at 08:36, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Incidentally, we do not parse 2010-3 as March of 2010 either. Again,
> this is not ISO date format (but an unofficial abbreviation). We may
> decide to dwim that to 2010-03-01, and I would even appreciate that.

Wouldn't it make the most sense to provide another option to allow the
user to specify whatever date format he wants (from the conversion
specifiers understood by strptime(3))?

It seems really ridiculous to keep growing the date parsing code.
