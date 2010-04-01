From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 5/7] remote-helpers: add support for an export command
Date: Thu, 1 Apr 2010 09:14:40 -0600
Message-ID: <h2ofabb9a1e1004010814v587eda10pe743efb1e269caad@mail.gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com> 
	<1269881309-19690-6-git-send-email-srabbelier@gmail.com> <7v634bsrg5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 17:15:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxM72-0007WH-8l
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 17:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab0DAPPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 11:15:05 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:43484 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab0DAPPD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 11:15:03 -0400
Received: by bwz1 with SMTP id 1so922134bwz.21
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GPg4iaB+EmaXbsJdme5VUE50mdkkQwu47BiWS0HBTbo=;
        b=B+z12UAE13Eaffej7L7kSaNE8LEF5Bu8gOyXdNQ9uDkHjEbboPoA816cYwdnx6lqFh
         xBv9O287+DooNXclqjO6bTP97+h1NHKrCe3jMCpm7Z2ul1ojka8mohoberjCYqBDE75Q
         I1g0TNJYxuMhi6CkN4AmaZ1T7769Mj/3a7HVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZjlwUiWzxKjPp/epwnU8oWfytjAL1zvnGhalJ+wYKgPubcM0yJfCLSsKFsJ8m2297/
         aaiJxVF8eOjs+YXLamZDF+1I5RBnnEML88ujE7hKpKHuHFHVThk4LSgVLbaNJFnc+d1G
         OuS7dJu+QsCqmasJD2whwZywpc8j7iUJMrpyc=
Received: by 10.204.153.219 with HTTP; Thu, 1 Apr 2010 08:14:40 -0700 (PDT)
In-Reply-To: <7v634bsrg5.fsf@alter.siamese.dyndns.org>
Received: by 10.204.127.70 with SMTP id f6mr1619133bks.76.1270134901316; Thu, 
	01 Apr 2010 08:15:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143732>

Heya,

On Wed, Mar 31, 2010 at 22:54, Junio C Hamano <gitster@pobox.com> wrote=
:
> I've queued this in 'pu' only to say "I've seen it", but I suspect th=
at
> this has to wait until after 1.7.1. =A0I've been trying to shoot for =
6-8
> week cycle as originally envisioned, and if things go as planned, pos=
t
> 1.7.1 cycle opens around mid April.

Okay, fair enough.

> What's happening here? =A0Style violations aside, it appears that "pr=
ivate"
> is accessed uninitialized when data->refspecs is NULL.

Ah, you are right, it should have been "char *private =3D NULL".

--=20
Cheers,

Sverre Rabbelier
