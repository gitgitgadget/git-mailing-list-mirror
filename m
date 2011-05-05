From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: How to fork a file (git cp ?)
Date: Thu, 5 May 2011 21:27:03 +0200
Message-ID: <BANLkTimPXVosaJBnOEUkURu4nsk=UNtRag@mail.gmail.com>
References: <4DC1934D.6070608@aldan.algebra.com>
	<4DC19955.7040503@kdbg.org>
	<7viptqdvrf.fsf@alter.siamese.dyndns.org>
	<4DC20461.4090703@aldan.algebra.com>
	<7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
	<BANLkTimD7byL=rgy79BWFT3vqKpzv9aNOQ@mail.gmail.com>
	<7vk4e56kxa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mikhail T." <mi+thun@aldan.algebra.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:27:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4Cc-00027d-LH
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab1EET1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 15:27:05 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1EET1E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 15:27:04 -0400
Received: by vxi39 with SMTP id 39so2594397vxi.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ytJlGXSCZJaMB8vE6kFfh20iHFBpWa9bo1VG0P5TvW0=;
        b=A+bMdOv1mYRuSdl5xEfHN830vDUgmJdqUZBCTTkwg1afx9eFAG0cxItGWDzNA09HC6
         c0KnAV5lIVhSennc9udSefxUhTAoDkTVTOBtD1NvvIjgrnJRoXEwF3bs0YPDcyDvu7E1
         WAZdgEaJaNIzjbnBLtNBMmLic20HJAhT/Btwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a1IXolfrwGZQ8lYgdBHt5U3syfL+bIsFwHJ3/YntKMkv08blE0xYJN1bl1OvycFdJF
         dLn1hKH4JdipGTQomEALZWWpSE6dgAirmljeIHTvQIDv7tsBwQE7AQ5Kx2ipmDzJdEzW
         3UyGatIjQhZrVl7q9zqdah8ktBpBVPoMGiW9U=
Received: by 10.52.111.136 with SMTP id ii8mr36292vdb.72.1304623623882; Thu,
 05 May 2011 12:27:03 -0700 (PDT)
Received: by 10.220.201.135 with HTTP; Thu, 5 May 2011 12:27:03 -0700 (PDT)
In-Reply-To: <7vk4e56kxa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172887>

On Thu, May 5, 2011 at 8:50 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> Maybe Mikhail wanted to say that if there's a git-mv as a shortcut f=
or
>> =A0 "cp old new ; rm old; add new"
>> then there should be a git-cp as a shortcut for
>> =A0 "cp old new; add new"
>
> Copying and then futzing with a copy is a bad discipline to begin wit=
h.
> git already has a reputation of having too many commands. =A0I am not
> thrilled about the idea of making things worse by adding an unnecessa=
ry
> command, and especially one that encourages a bad workflow.

I'm not saying I want to have git-cp, but could you explain what is wro=
ng with
"cp old new; add new" (why is that bad workflow? How come adding a copy
of a file can be a workflow at all?)


--=20
Piotr Krukowiecki
