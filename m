From: Chase Brammer <cbrammer@gmail.com>
Subject: Re: Push not writing to standard error
Date: Tue, 12 Oct 2010 16:18:58 -0600
Message-ID: <AANLkTikVE_iQ8nMdq7_G9aX17M3hQ4vM=oe2o=qynR-U@mail.gmail.com>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
	<20101012192117.GD16237@burratino>
	<20101012193204.GA8620@sigill.intra.peff.net>
	<20101012193830.GB8620@sigill.intra.peff.net>
	<AANLkTim_pjJ76J0ctSQO=eYsVtkZAgq2nhm0fskjjo+g@mail.gmail.com>
	<20101012204845.GA12790@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 13 00:19:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5nBa-0004ZH-8c
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 00:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab0JLWTA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 18:19:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62240 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab0JLWS7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 18:18:59 -0400
Received: by wyb28 with SMTP id 28so485168wyb.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/5qVzczFdhMN15lfI0PxwGN+PidBCSiiyEw3X7Wcn5Y=;
        b=fnjrjWh15JupYRsa8ypMYWtTqBlR5PCPeG0FRVu+NrWjA5540BU45XIkF7znQjG+az
         j/D/xr72Jg5nU8TL1yXc1BNQ/InFc7xBJ8J60URpIj4LCnjrB5g4pCVSSWfKLYlFVnt+
         dmtlYf3nu+2B8W0AbtgLNkpHb4dJEjqKqEkt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n3KdCc6ZabIphCi2s/onZPg0J5jCg8EN6JltP7S1hSp7E+WRLbPkOG7rpMEzpo0al/
         pQzcB65NayhkSLgGnnqRMtMdyC+rU03xrGphC3hp0WjCuQ4rjLpgSv6ejO/xSMhm5AJw
         lQSKafXOH3E8A4Jmdaz4naD5MRraNQM9fPk9s=
Received: by 10.216.19.13 with SMTP id m13mr7384306wem.101.1286921938655; Tue,
 12 Oct 2010 15:18:58 -0700 (PDT)
Received: by 10.216.29.195 with HTTP; Tue, 12 Oct 2010 15:18:58 -0700 (PDT)
In-Reply-To: <20101012204845.GA12790@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158884>

Peff

Thanks for all the help.  It worked fantastic.  I hope you don't mind
me packing this into a commit and submitting it to Junio.  It is
something I really need in the next release.  I don't know much about
protocol here, and I don't want to step on toes.

Chase



On Tue, Oct 12, 2010 at 2:48 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 12, 2010 at 02:37:50PM -0600, Chase Brammer wrote:
>
>> Wow, I am amazed at how quick you churned that out. =A0I haven't
>> participated in the git patch and release cycle, so forgive my
>> ignorance. =A0Do you think that this will be released in the next
>> release (1.7.3.2) ? If so, any expectations on release date?
>
> Well, at 5 minutes it was really only 1 line of code per minute. ;)
>
> I'm hoping that somebody else on the list who has worked in the
> transport code recently can comment on whether this is the right fix.
> Did you test it? Does it fix your issue?
>
> If it seems OK, then somebody needs to submit a cleaned-up version wi=
th
> commit message to Junio, who will probably cook it in "next" for at
> least a few weeks, and then hopefully it would be in v1.7.3.2. He doe=
s
> maintenance releases as-needed, which seems to generally be every few
> weeks.
>
> -Peff
>
