From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sun, 21 Mar 2010 14:10:05 +0800
Message-ID: <41f08ee11003202310l555cae23r23dbdfa476e8398f@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <7vbpeibtij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 07:10:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtEMZ-0005mo-Lh
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 07:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab0CUGKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 02:10:09 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:16099 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab0CUGKF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 02:10:05 -0400
Received: by qw-out-2122.google.com with SMTP id 8so921686qwh.37
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 23:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Wpnxiazx25vUfvv/5FxcJ81SBX7vtRuZn9uXR4R7sF4=;
        b=hDbpUepQ5n8ILF8j26mDdPr8Dwv32YKaXCI04L5Ue0K1rA+efkWN+XTecJqH5Iwi/u
         FHPIqqvRxlIxG8xzvZhYfJXQgvsYs6ySeMUHYnGamv8cGpb1rTMic8zUooDCygMUN2Bs
         Ny2AIpobzvA8R8AsCvGA0r1/4y8sTucH3RXHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TLQKIp06T8W0cBPeaJLTvqq7+iiyTZnY2K7x9/FAwT1oFkZm5N2YR0l0dJnMmuX0iE
         m5VgDPYx5+1CLYY/6pCp4UkWDLsA6V6pfPKqqkNE4ZuzaNVg57GMyvQDz3IKuBJwGvp2
         U6MdVY9JMgmVits8WpER+LFL6/HvtGLljdhUg=
Received: by 10.229.81.81 with SMTP id w17mr121628qck.4.1269151805157; Sat, 20 
	Mar 2010 23:10:05 -0700 (PDT)
In-Reply-To: <7vbpeibtij.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142792>

>
> I would actually recommend you take a look at -L option from blame. =A0=
What
> I use most often and find very handy myself is this pattern:
>
> =A0 =A0 =A0 =A0blame -L '/^void some_function()/,/^}/' -- path
>
> as I do not have to count the line numbers.

I have look at that options and I find it is very convenient and
line-level browser will adopt that line syntax, too.

> There also was a discussion on allowing more than one -L to blame, wh=
ich I
> think is applicable to this feature. =A0Check the list archive for th=
e past
> few months.

I think it is rationale for 'git blame' to allow more than one -L to
let the users see more than one block of code. But for a tool which
used to explore history, I think the user almost focus on one thread
of history. If the history split on some point, we should ask user for
choose one to go on. So, I think the line-level browser need not to
support such a thing. :)

Regards!
Bo
