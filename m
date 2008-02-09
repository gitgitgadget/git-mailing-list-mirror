From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] remove "nohup" from git-help--browse
Date: Sat, 9 Feb 2008 23:03:51 +0300
Message-ID: <20080209200351.GC30368@dpotapov.dyndns.org>
References: <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org> <1202502982-6822-1-git-send-email-dpotapov@gmail.com> <200802090653.43280.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 21:04:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNvw9-0001wz-Cp
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 21:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbYBIUD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2008 15:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755358AbYBIUD6
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 15:03:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:3781 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbYBIUD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 15:03:56 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3269203fga.17
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=G6svTkJYF7TWrDJpv4wrqx3d/+fxA0XQ8+O5wWSlQCc=;
        b=Jxp/Q4XdsUbTUFhxk6bMISFeNRxEDwFTzhptyHwqfkI+cGhEbxKqIvGEJgJEiMeUOC/b9DkIZysfKIblXuXcwzKKojPkM78IpcqDKxAKO2cKz5wIgLpYidgqI9gdWnV+QeEcvRAOVx9/fvnh6YqBcDrUmuFRmeXb2QU4f+suugc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=ohVuAxVwacn4VQnInT87uhsceBVcMVYfRBFwH2O76l40d7PyHx7zclxlIHDHMNfBHOrG4IXxexXksmswa3jMzCcILPgcUtc6kfxeTES3LprLvAvKi9TsL4glj7zuG+3fkzzVUzybB9tDKvB3CuI2vTOv2zDHhMeb7i2SkMZE7Eg=
Received: by 10.86.28.5 with SMTP id b5mr13164901fgb.79.1202587435287;
        Sat, 09 Feb 2008 12:03:55 -0800 (PST)
Received: from localhost ( [85.140.169.229])
        by mx.google.com with ESMTPS id 3sm15551789fge.7.2008.02.09.12.03.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 12:03:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802090653.43280.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73256>

On Sat, Feb 09, 2008 at 06:53:43AM +0100, Christian Couder wrote:
> Le vendredi 8 f=E9vrier 2008, Dmitry Potapov a =E9crit :
> > There is no good reason to run GUI browsers using "nohup". It does =
not
> > solve any real problem but creates annoying "nohup.out" files in ev=
ery
> > directory where git help -w is run.
>=20
> That's right, but if you just remove "nohup", then there may be some=20
> annoying browser output on the terminal. Perhaps we should also redir=
ect=20
> stderr and stdout to /dev/null.

I don't mind this redirection, but I am not sure whether it is the righ=
t
thing to do, because it may hide relevant error information, and if you=
r
browser tends to print irrelevant and annoying messages at start, then
perhaps the script to start this browser should be corrected to suppres=
s
these output.

So, I want to hear what other people think. If there is no objection,
I will add this redirection.

>=20
> > This patch removes "nohup" from git-help--browse.sh
>=20
> "git-help--browse.sh" has been renamed "git-web--browse.sh" in next s=
o we=20
> need a similar patch for next.

Okay, I will base my patch on next.


Dmitry
