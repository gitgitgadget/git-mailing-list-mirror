From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: temporarily unsetting sendemail.smtpuser
Date: Thu, 20 May 2010 08:23:11 +0000
Message-ID: <AANLkTilhkDWkGpbkMAbYtgHNI49gAGzi1oYLeE-sdsTE@mail.gmail.com>
References: <4BF46C0A.9070000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 20 10:23:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF12K-0007PF-11
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 10:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab0ETIXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 04:23:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42052 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab0ETIXN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 04:23:13 -0400
Received: by iwn6 with SMTP id 6so4037480iwn.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 01:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kYWSj61ZT9r3j/m3iaaKdtpJZVrkgO+hlEddv+SoXkE=;
        b=C9QeO94bOVjqZKKGNmf5hwC4GMFltAPVsF8rGIvpxbC+N2H0lkiXqqxb9MrSu2A74/
         q37lHQvq62PNTqLWbciFRL87EZ9za/inc1baNIgXR7raNcuQ3/9iMjLduGksRtPFk38O
         bzDdW5+vfPL5KRWnYUbaWDQCHba7iJwOD8Fko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jcyc5uvLoKY0p4RKtr+2TPn2lDN6DPWQVHnO+s1IkJKcaPmrqwCGHqr/lN1cgtAY5w
         sh6+VnNSR7n+PR1cCtulli2SMjxeu0ZHaKDOppvuZT60Nw8jQtoCtwdynN5fSyLZ8liw
         wcDbD4lZ7GD/GG4rX7ui0mJHgzrb+Em8cJkMk=
Received: by 10.231.157.77 with SMTP id a13mr4785352ibx.59.1274343792056; Thu, 
	20 May 2010 01:23:12 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 20 May 2010 01:23:11 -0700 (PDT)
In-Reply-To: <4BF46C0A.9070000@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147361>

On Wed, May 19, 2010 at 22:54, Eric Blake <eblake@redhat.com> wrote:
> But both of those are rather unappealing. =C2=A0Is there a better app=
roach to
> accomplishing what I wanted?

--no-smtp-user ?
